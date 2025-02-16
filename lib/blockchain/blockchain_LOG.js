const Web3 = require("web3");
const contractABI = require("./SecurityLogABI.json");
const CONTRACT_ADDRESS = "0xYourContractAddress";
const PRIVATE_KEY = "0xYourPrivateKey";

const web3 = new Web3("https://sepolia.infura.io/v3/YOUR_INFURA_KEY");
const account = web3.eth.accounts.privateKeyToAccount(PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);
const contract = new web3.eth.Contract(contractABI, CONTRACT_ADDRESS);

// ====== 블록체인에 비정상 접근 기록 저장 ======
async function logSecurityEvent(details) {
  const tx = contract.methods.recordLog(details);
  const gas = await tx.estimateGas({ from: account.address });
  const txData = tx.encodeABI();
  const signedTx = await web3.eth.accounts.signTransaction(
    { to: CONTRACT_ADDRESS, data: txData, gas },
    PRIVATE_KEY
  );

  await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  console.log("✅ 블록체인에 이상 접근 기록 저장 완료");
}

// ====== 테스트 ======
logSecurityEvent("Unauthorized file access detected from external IP: 8.8.8.8");
