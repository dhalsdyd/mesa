const crypto = require("crypto");

const algorithm = "aes-256-cbc";
const key = crypto.randomBytes(32); // 256비트 키 생성
const iv = crypto.randomBytes(16); // 16바이트 IV

function encryptData(data) {
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  let encrypted = cipher.update(data, "utf8", "hex");
  encrypted += cipher.final("hex");
  return { encrypted, iv };
}

const testData = "This is a secret file content.";
const { encrypted, iv } = encryptData(testData);

console.log(`Encrypted Data: ${encrypted}`);
console.log(`IV: ${iv.toString("hex")}`);
