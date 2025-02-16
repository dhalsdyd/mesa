const fs = require("fs");
const chokidar = require("chokidar");

// ====== 실시간 파일 감지 시스템 ======
console.log("🔍 실시간 파일 감지 시스템 시작...");

chokidar.watch("monitored_folder").on("all", (event, path) => {
  console.log(`📂 ${event.toUpperCase()} 감지됨: ${path}`);

  if (event === "add" || event === "change") {
    analyzeFileAccess(path);
  }
});

// ====== 이상 접근 분석 함수 ======
function analyzeFileAccess(filePath) {
  const fileSize = fs.statSync(filePath).size / (1024 * 1024); // MB 단위 변환

  if (fileSize > 100) {
    console.log(`🚨 [경고] 비정상적으로 큰 파일이 감지됨: ${filePath}`);
  }
}
