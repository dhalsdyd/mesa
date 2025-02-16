function readMesaFile(filePath) {
  const fileBuffer = fs.readFileSync(filePath);

  const magic = fileBuffer.slice(0, 4).toString();
  if (magic !== "MESA") {
    throw new Error("Invalid file format");
  }

  const iv = fileBuffer.slice(5, 21); // 16바이트 IV
  const encryptedData = fileBuffer.slice(21).toString("hex");

  return { iv, encryptedData };
}

function decryptData(encrypted, iv) {
  const decipher = crypto.createDecipheriv(algorithm, key, iv);
  let decrypted = decipher.update(encrypted, "hex", "utf8");
  decrypted += decipher.final("utf8");
  return decrypted;
}

const { iv: storedIv, encryptedData } = readMesaFile("secret.mesa");
const decryptedText = decryptData(encryptedData, storedIv);

console.log(`Decrypted Text: ${decryptedText}`);
