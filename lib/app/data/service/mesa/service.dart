// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';
import 'dart:html';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:pointycastle/export.dart';

class ListEquality {
  bool equals(List<int> list1, List<int> list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }
}

class MesaService extends GetxController {
  Rx<bool> isLoading = false.obs;

  // ======= 설정 =======
  final String MAGIC_HEADER = "MESA"; // 고유 파일 시그니처
  final int SALT_LENGTH = 16; // PBKDF2 소금값(Salt) 길이
  final int ITERATIONS = 100000; // PBKDF2 반복 횟수
  final int KEY_LENGTH = 32; // AES-256을 위한 32바이트 키

  // ======= 동적 환경 데이터 수집 (브라우저 기반) =======
  Future<String> getDynamicEnvironmentData() async {
    String browserInfo = window.navigator.userAgent;
    String language = window.navigator.language ?? "unknown";
    return "$browserInfo-$language";
  }

  // ======= 키 생성 함수 (PBKDF2 + 동적 환경 적용) =======
  Future<Uint8List> generateDynamicKey(String password, Uint8List salt) async {
    final envData = await getDynamicEnvironmentData();
    final keySource = utf8.encode("$password-$envData");

    final pbkdf2 = KeyDerivator("SHA-256/HMAC/PBKDF2")..init(Pbkdf2Parameters(salt, ITERATIONS, KEY_LENGTH));

    return pbkdf2.process(Uint8List.fromList(keySource));
  }

  // ======= AES-256 CBC 암호화 함수 =======
  Uint8List encryptAES(Uint8List key, Uint8List iv, Uint8List data) {
    final cipher = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESFastEngine()))
      ..init(
        true,
        PaddedBlockCipherParameters(
          ParametersWithIV(KeyParameter(key), iv),
          null,
        ),
      );
    return cipher.process(data);
  }

  // ======= AES-256 CBC 복호화 함수 =======
  Uint8List decryptAES(Uint8List key, Uint8List iv, Uint8List encryptedData) {
    final cipher = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESFastEngine()))
      ..init(
        false,
        PaddedBlockCipherParameters(
          ParametersWithIV(KeyParameter(key), iv),
          null,
        ),
      );
    return cipher.process(encryptedData);
  }

  // ======= 파일 암호화 (웹 파일 업로드 & 다운로드) =======
  Future<void> encryptFile() async {
    String password = "mesa2025"; // await askPassword("🔑 파일 암호를 입력하세요:");
    if (password.isEmpty) return;

    // 파일 업로드 처리
    FileUploadInputElement uploadInput = FileUploadInputElement()..accept = '*/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) async {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoadEnd.first;

      Uint8List data = Uint8List.fromList(reader.result as List<int>);
      Uint8List salt = _generateRandomBytes(SALT_LENGTH);
      Uint8List iv = _generateRandomBytes(16); // 16바이트 IV

      Uint8List key = await generateDynamicKey(password, salt);

      // 메타데이터 생성
      Map<String, dynamic> metadata = {
        "filename": file.name,
        "createdAt": DateTime.now().toIso8601String(),
        "permissions": ["read", "write"]
      };
      Uint8List encryptedMetadata = encryptAES(key, iv, utf8.encode(jsonEncode(metadata)));

      // 파일 암호화
      Uint8List encryptedData = encryptAES(key, iv, data);

      // SHA-256 해시 계산 (무결성 검사용)
      final hash = sha256.convert(encryptedData);

      // 바이너리 헤더 구성 (MESA + Salt + IV + 해시 + 암호화된 메타 + 암호화 데이터)
      List<int> finalBuffer = [...utf8.encode(MAGIC_HEADER), ...salt, ...iv, ...hash.bytes, ...encryptedMetadata, ...encryptedData];

      // 다운로드 처리
      _downloadFile(Uint8List.fromList(finalBuffer), "${file.name}.mesa");
    });
  }

  // ====== 사용자 입력을 암호화하여 다운로드 ======
  Future<void> encryptText(String text, String fileName) async {
    String? password = "mesa2025"; // await askPassword("🔑 파일 암호를 입력하세요:");

    isLoading.value = true;

    Uint8List salt = _generateRandomBytes(SALT_LENGTH);
    Uint8List iv = _generateRandomBytes(16);
    Uint8List key = await generateDynamicKey(password, salt);

    Uint8List encryptedData = encryptAES(key, iv, utf8.encode(text));
    final hash = sha256.convert(encryptedData);

    List<int> finalBuffer = [...utf8.encode(MAGIC_HEADER), ...salt, ...iv, ...hash.bytes, ...encryptedData];

    isLoading.value = false;

    _downloadFile(Uint8List.fromList(finalBuffer), "$fileName.txt.mesa");
  }

  // ======= 파일 복호화 (웹 파일 업로드 & 다운로드) =======
  Future<void> decryptFile() async {
    String password = "mesa2025"; // await askPassword("🔑 파일 암호를 입력하세요:");
    if (password.isEmpty) return;

    // 파일 업로드 처리
    FileUploadInputElement uploadInput = FileUploadInputElement()..accept = '.mesa';
    uploadInput.click();
    uploadInput.onChange.listen((e) async {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoadEnd.first;

      Uint8List fileBytes = Uint8List.fromList(reader.result as List<int>);

      // 1. 헤더 검증 (Magic Number 확인)
      String magic = utf8.decode(fileBytes.sublist(0, 4));
      if (magic != MAGIC_HEADER) {
        window.alert("❌ 잘못된 파일 형식입니다.");
        return;
      }

      // 2. 헤더에서 Salt, IV, 저장된 해시값 추출
      Uint8List salt = fileBytes.sublist(4, 20);
      Uint8List iv = fileBytes.sublist(20, 36);
      Uint8List storedHash = fileBytes.sublist(36, 68);

      // 3. 키 재생성
      Uint8List key = await generateDynamicKey(password, salt);

      // 4. 암호화된 메타데이터 및 파일 데이터 추출
      int metadataSize = 256; // 메타데이터 크기를 가정
      Uint8List encryptedMetadata = fileBytes.sublist(68, 68 + metadataSize);
      Uint8List encryptedData = fileBytes.sublist(68 + metadataSize);

      // 5. 무결성 검증
      final computedHash = sha256.convert(encryptedData);
      if (!ListEquality().equals(computedHash.bytes, storedHash)) {
        window.alert("❌ 무결성 검증 실패! 파일이 변조되었거나 암호가 틀렸습니다.");
        return;
      }

      // 6. 파일 데이터 복호화
      Uint8List decryptedData = decryptAES(key, iv, encryptedData);

      // 다운로드 처리
      _downloadFile(decryptedData, "decrypted_${file.name.replaceAll('.mesa', '')}");
    });
  }

  // ====== 업로드한 암호화된 텍스트 파일을 복호화하여 다운로드 ======
  Future<void> decryptTextFile() async {
    String? password = "mesa2025"; // await askPassword("🔑 파일 암호를 입력하세요:");
    if (password == null || password.isEmpty) return;

    // 암호화된 파일 선택
    FileUploadInputElement uploadInput = FileUploadInputElement()..accept = '.mesa';
    uploadInput.click();
    uploadInput.onChange.listen((e) async {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoadEnd.first;

      Uint8List fileBytes = Uint8List.fromList(reader.result as List<int>);

      // 1. 헤더 검증 (Magic Number 확인)
      String magic = utf8.decode(fileBytes.sublist(0, 4));
      if (magic != MAGIC_HEADER) {
        window.alert("❌ 잘못된 파일 형식입니다.");
        return;
      }

      isLoading.value = true;

      Uint8List salt = fileBytes.sublist(4, 20);
      Uint8List iv = fileBytes.sublist(20, 36);
      Uint8List storedHash = fileBytes.sublist(36, 68);
      Uint8List encryptedData = fileBytes.sublist(68);

      Uint8List key = await generateDynamicKey(password, salt);

      // 2. 무결성 검증
      final computedHash = sha256.convert(encryptedData);
      if (!ListEquality().equals(computedHash.bytes, storedHash)) {
        window.alert("❌ 무결성 검증 실패! 암호가 틀리거나 파일이 변조됨.");
        return;
      }

      // 3. 복호화
      Uint8List decryptedData = decryptAES(key, iv, encryptedData);
      String decryptedText = utf8.decode(decryptedData);

      isLoading.value = false;

      // 4. 복호화된 텍스트를 .txt로 다운로드 제공
      _downloadFile(Uint8List.fromList(utf8.encode(decryptedText)), "decrypted_${file.name.replaceAll('.mesa', '.txt')}");
    });
  }

  // ======= 랜덤 바이트 생성 함수 =======
  Uint8List _generateRandomBytes(int length) {
    final rnd = SecureRandom("AES/CTR/AUTO-SEED-PRNG")..seed(KeyParameter(Uint8List(32)));
    return rnd.nextBytes(length);
  }

  // ======= 파일 다운로드 처리 =======
  void _downloadFile(Uint8List bytes, String fileName) {
    final blob = Blob([bytes]);
    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    Url.revokeObjectUrl(url);
  }
}
