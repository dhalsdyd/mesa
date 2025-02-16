const { create } = require("ipfs-http-client");
const Web3 = require("web3");
const fs = require("fs");
const contractABI = require("./FileTrackingABI.json"); // 스마트 컨트랙트 ABI

const IPFS_NODE = "http://localhost:5001"; // 로컬 IPFS 노드 (또는 Infura 등 사용 가능)
const CONTRACT_ADDRESS = "0xYourContractAddress"; // 배포된 스마트 컨트랙트 주소
const PRIVATE_KEY = "0xYourPrivateKey"; // 이더리움 지갑 개인키

const web3 = new Web3("https://sepolia.infura.io/v3/YOUR_INFURA_KEY"); // 이더리움 네트워크 연결
const ipfs = create({ url: IPFS_NODE });
const account = web3.eth.accounts.privateKeyToAccount(PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);
const contract = new web3.eth.Contract(contractABI, CONTRACT_ADDRESS);

// ====== 파일 IPFS 업로드 & 블록체인 등록 ======
async function uploadFile(filePath) {
  const file = fs.readFileSync(filePath);
  const { cid } = await ipfs.add(file);
  const ipfsHash = cid.toString();

  console.log(`✅ IPFS 업로드 완료: ${ipfsHash}`);

  const tx = contract.methods.uploadFile(ipfsHash);
  const gas = await tx.estimateGas({ from: account.address });
  const txData = tx.encodeABI();
  const signedTx = await web3.eth.accounts.signTransaction(
    { to: CONTRACT_ADDRESS, data: txData, gas },
    PRIVATE_KEY
  );

  await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  console.log("✅ 블록체인에 파일 등록 완료");
}

// ====== 파일 접근 기록 저장 ======
async function logFileAccess(ipfsHash, deviceInfo) {
  const tx = contract.methods.logFileAccess(ipfsHash, deviceInfo);
  const gas = await tx.estimateGas({ from: account.address });
  const txData = tx.encodeABI();
  const signedTx = await web3.eth.accounts.signTransaction(
    { to: CONTRACT_ADDRESS, data: txData, gas },
    PRIVATE_KEY
  );

  await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  console.log("✅ 파일 접근 기록 저장 완료");
}

// ====== 파일 다운로드 (IPFS에서 해시값 조회 후 다운로드) ======
async function downloadFile(ipfsHash, outputFilePath) {
  const stream = ipfs.cat(ipfsHash);
  let data = "";

  for await (const chunk of stream) {
    data += chunk;
  }

  fs.writeFileSync(outputFilePath, data);
  console.log(`✅ 파일 다운로드 완료: ${outputFilePath}`);
}

// ====== 실행 ======
// 파일 업로드 및 추적 테스트
uploadFile("test.txt").then(() => {
  logFileAccess("Qm...YourIPFSHash", "Windows 11 - Office PC");
  downloadFile("Qm...YourIPFSHash", "downloaded_test.txt");
});
