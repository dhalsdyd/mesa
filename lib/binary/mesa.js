const fs = require("fs");
const crypto = require("crypto");
const os = require("os");
const readline = require("readline");
const axios = require("axios");

// ======= 설정 =======
const MAGIC_HEADER = Buffer.from("MESA"); // 고유 파일 시그니처
const VERSION = Buffer.from([0x03]); // 파일 버전 (업데이트됨)
const ALGO = "aes-256-cbc"; // 암호화 알고리즘
const SALT_LENGTH = 16; // PBKDF2 소금값(Salt) 길이
const ITERATIONS = 100000; // PBKDF2 반복 횟수
const KEY_LENGTH = 32; // AES-256을 위한 32바이트 키

// ======= 사용자 입력을 위한 인터페이스 =======
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function askPassword(promptText) {
  return new Promise((resolve) => {
    rl.question(promptText, (password) => {
      resolve(password);
    });
  });
}

// ======= 동적 환경 데이터 수집 (OS, IP, 위치 기반) =======
async function getDynamicEnvironmentData() {
  try {
    const networkInterfaces = os.networkInterfaces();
    const ip = networkInterfaces["Wi-Fi"]
      ? networkInterfaces["Wi-Fi"][0].address
      : "127.0.0.1"; // IP 가져오기

    const locationData = await axios.get("https://ipapi.co/json"); // 위치 정보 가져오기
    const location = `${locationData.data.city}-${locationData.data.country_code}`;

    const systemInfo = `${os.platform()}-${os.arch()}-${os.hostname()}`; // OS 정보 가져오기

    return `${systemInfo}-${ip}-${location}`; // 환경을 하나의 문자열로 조합
  } catch (error) {
    return "default-environment"; // 실패 시 기본값 적용
  }
}

// ======= 키 생성 함수 (PBKDF2 + 동적 환경 적용) =======
async function generateDynamicKey(password, salt) {
  const envData = await getDynamicEnvironmentData();
  const fullKeySource = `${password}-${envData}`;
  return crypto.pbkdf2Sync(
    fullKeySource,
    salt,
    ITERATIONS,
    KEY_LENGTH,
    "sha256"
  );
}

// ======= 메타데이터 암호화 함수 =======
function encryptMetadata(metadata, key, iv) {
  const cipher = crypto.createCipheriv(ALGO, key, iv);
  let encrypted = Buffer.concat([
    cipher.update(Buffer.from(metadata, "utf8")),
    cipher.final(),
  ]);
  return encrypted;
}

function decryptMetadata(encryptedMetadata, key, iv) {
  const decipher = crypto.createDecipheriv(ALGO, key, iv);
  let decrypted = Buffer.concat([
    decipher.update(encryptedMetadata),
    decipher.final(),
  ]);
  return decrypted.toString("utf8");
}

// ======= 파일 암호화 =======
async function encryptFile(inputFilePath, outputFilePath) {
  const password = await askPassword("🔑 암호를 입력하세요: ");
  rl.close();

  const data = fs.readFileSync(inputFilePath);
  const salt = crypto.randomBytes(SALT_LENGTH); // 랜덤 소금값 생성
  const key = await generateDynamicKey(password, salt); // 동적 환경 기반 키 생성

  // 1. 파일 메타데이터 구성
  const metadata = JSON.stringify({
    filename: inputFilePath,
    createdAt: new Date().toISOString(),
    permissions: ["read", "write"],
  });

  const ivMeta = crypto.randomBytes(16); // 메타데이터용 IV
  const ivData = crypto.randomBytes(16); // 파일 데이터용 IV

  // 2. 메타데이터 암호화
  const encryptedMetadata = encryptMetadata(metadata, key, ivMeta);

  // 3. 파일 데이터 암호화
  const cipher = crypto.createCipheriv(ALGO, key, ivData);
  let encryptedData = Buffer.concat([cipher.update(data), cipher.final()]);

  // 4. SHA-256 해시 계산 (무결성 검사용)
  const hash = crypto.createHash("sha256").update(encryptedData).digest();

  // 5. 바이너리 헤더 조합 (MESA + 버전 + Salt + IV(메타) + IV(데이터) + 해시 + 암호화된 메타 + 암호화 데이터)
  const header = Buffer.concat([
    MAGIC_HEADER,
    VERSION,
    salt,
    ivMeta,
    ivData,
    hash,
  ]);
  const finalBuffer = Buffer.concat([header, encryptedMetadata, encryptedData]);

  // 6. `.mesa` 파일로 저장
  fs.writeFileSync(outputFilePath, finalBuffer);
  console.log(`✅ 암호화 완료: ${outputFilePath}`);
}

// ======= 파일 복호화 =======
async function decryptFile(inputFilePath, outputFilePath) {
  const password = await askPassword("🔑 암호를 입력하세요: ");
  rl.close();

  const fileBuffer = fs.readFileSync(inputFilePath);

  // 1. 헤더 검증 (Magic Number 확인)
  if (!fileBuffer.slice(0, 4).equals(MAGIC_HEADER)) {
    throw new Error("❌ 잘못된 파일 형식입니다.");
  }

  // 2. 헤더에서 Salt, IV(메타), IV(데이터), 저장된 해시값 추출
  const salt = fileBuffer.slice(5, 21);
  const ivMeta = fileBuffer.slice(21, 37);
  const ivData = fileBuffer.slice(37, 53);
  const storedHash = fileBuffer.slice(53, 85);

  // 3. 사용자 입력 기반 키 재생성
  const key = await generateDynamicKey(password, salt);

  // 4. 암호화된 메타데이터 및 파일 데이터 추출
  const encryptedMetadata = fileBuffer.slice(85, 85 + 256); // 256바이트 길이로 가정
  const encryptedData = fileBuffer.slice(85 + 256);

  // 5. 해시 검증 (무결성 체크)
  const computedHash = crypto
    .createHash("sha256")
    .update(encryptedData)
    .digest();
  if (!storedHash.equals(computedHash)) {
    throw new Error(
      "❌ 무결성 검증 실패! 파일이 변조되었거나 암호가 틀렸습니다."
    );
  }

  // 6. 메타데이터 복호화
  const decryptedMetadata = decryptMetadata(encryptedMetadata, key, ivMeta);
  console.log(`📂 파일 메타데이터: ${decryptedMetadata}`);

  // 7. 파일 데이터 복호화
  const decipher = crypto.createDecipheriv(ALGO, key, ivData);
  let decryptedData = Buffer.concat([
    decipher.update(encryptedData),
    decipher.final(),
  ]);

  // 8. 복호화된 파일 저장
  fs.writeFileSync(outputFilePath, decryptedData);
  console.log(`✅ 복호화 완료: ${outputFilePath}`);
}

// ======= 사용 예제 =======
// 테스트용 텍스트 파일을 암호화 후 `.mesa` 파일 생성
encryptFile("test.txt", "test.mesa").then(() => {
  // `.mesa` 파일을 다시 복호화하여 원본 복원
  decryptFile("test.mesa", "decrypted_test.txt");
});
