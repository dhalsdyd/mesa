function saveToFile(filePath, encryptedData, iv) {
  const header = createHeader();
  const dataBuffer = Buffer.from(encryptedData, "hex");
  const ivBuffer = Buffer.from(iv, "hex");

  const finalBuffer = Buffer.concat([header, ivBuffer, dataBuffer]);
  fs.writeFileSync(filePath, finalBuffer);
}

saveToFile("secret.mesa", encrypted, iv.toString("hex"));
console.log("Encrypted file saved as secret.mesa");
