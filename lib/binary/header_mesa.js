const fs = require("fs");

const HEADER_MAGIC = Buffer.from("MESA"); // 파일 식별자
const VERSION = Buffer.from([0x01]); // 버전 정보
const ENCRYPTION_TYPE = Buffer.from([0x02]); // 암호화 유형 (예: 0x02 = AES-256)

function createHeader() {
  return Buffer.concat([HEADER_MAGIC, VERSION, ENCRYPTION_TYPE]);
}

console.log(createHeader()); // 헤더 확인a
