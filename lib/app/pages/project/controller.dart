import 'package:get/get.dart';
import 'package:mesa/app/data/service/mesa/service.dart';

class ProjectPageController extends GetxController with StateMixin {
  static ProjectPageController get to => Get.find<ProjectPageController>(); // add this line

  final MesaService mesaService = Get.find<MesaService>();

  Rx<bool> onDrop = false.obs;
  Rx<bool> isLoading = false.obs;

  Future<void> downloadFileWithMesa(int importance) async {
    // importance 1 = 공모전 주제, 2 = 신청서 양식, 3 = 기획서 세부사항
    isLoading.value = true;

    String data = "";
    switch (importance) {
      case 1:
        data = '''
**공모주제**:

InfoSec 관련 다양한 하위 주제와 이를 해결할 수 있는 웹/앱 실천 아이디어 제안

**세부일정**

**① 공모접수** 24.12.13.(금)~25.3.7.(금)

**② 서면심사** 3.11.(화)~3.17.(월)

**③ 전문가 멘토링** 3.20.(목)~3.23.(일) * 온라인

| **세부주제** | **세부예시** |
| --- | --- |
| **M-Security** | **모바일 활용 금융거래·쇼핑·개인정보 입력 등 정보보안, 해킹방지 및 임의 접근 차단, 피싱·스미싱 등 모바일 범죄 위험에서의 보호 등** |
| **e-Privacy** | **개인정보 유출방지 및 관리시스템, 추적방지 및 유출 차단, 개인 맞춤형 개인정보보호 등** |
| **AI** | **AI 기반 정보보안 시스템 개발, AI 기반 개인 맞춤화 피싱 설계 방지 및 대책, 자동화된 도구 활용 공격규모 확대 방지 등** |
| **DeepFake** | **딥페이크 기술 악용 방지를 위한 탐지 및 예방 솔루션, 딥페이크 생성 방지 및 데이터 접근 제한 기술, 피해 방지/대응 시스템 구축 등** |
| **Industrial Cyber Defense** | **산업별 고유특성을 반영한 보안관리와 기술개발, 핵심기술/기술유출의 위험성 및 예방, 기업의 정보보안 구축 등** |
| **기타** | **해당 주제 융합 및 다양한 정보보안 주제 관련 아이디어 제안 가능** |''';
        break;
      case 2:
        data = '''
**제출 이메일 주소 : contest_all@naver.com**

**이메일 제목 : *(팀명) 5회 공모전 제출***

**파일명 : *(팀명) 5회 공모전_참가신청서, (팀명) 5회 공모전_서약서, (팀명) 5회 공모전_기획서 등***

**④ 수정제출** 3.23.(일)~3.26.(수)

**⑤ 최종 발표심사** 3.28.(금) * 온라인

**⑥ 시상식** 4.26.(토) *수상자 발표 4.4.(금)''';
        break;
      case 3:
        data = '''
### 1. 주제

**M-Security, e-Privacy, AI, DeepFake, Industrial Cyber Defense, 기타 중 택 1**

### 2. 기획 의도

**선정 배경 및 이유, 관련 문제점 진단, 제안 배경 등**

### 3. 주요 기능 및 사용방법

**앱/웹 개발 세부 내용, 기능 안내, 사용방법 등**

### 4. 기대효과

**문제 해결의 기여 가능성, 예상 성과 및 결과, 효과성 등** 

### 5. 구현링크 및 캡쳐본

**앱/웹 구현 페이지 링크 필수 포함.** 

### 6. 기타

**기타 공모작에 대한 기타 추가 내용, 참고문헌 및 출처 등**''';
        break;
    }

    String fileName = "";
    switch (importance) {
      case 1:
        fileName = "공모전 주제";
        break;
      case 2:
        fileName = "신청서 양식";
        break;
      case 3:
        fileName = "기획서 세부사항";
        break;
    }

    await mesaService.encryptText(data, fileName);
    isLoading.value = false;
  }
}
