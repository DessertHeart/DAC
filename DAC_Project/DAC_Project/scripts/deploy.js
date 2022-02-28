//从ethers中获取w外部账户：Signers对象
//ethers变量在全局作用域下都可用,如果希望代码更明确，则可以在顶部添加以下这一行
const { ethers } = require("hardhat");

async function main() {

    // Signer是代表以太坊账户的对象
    const [deployer] = await ethers.getSigners();

    // 账户地址
    console.log(
    "Deploying contracts with the account:",
    await deployer.getAddress()
    );

    // 账户余额
    console.log("Account balance:", (await deployer.getBalance()).toString());

    // ContractFactory是用于部署新智能合约的实例化
    const Token = await ethers.getContractFactory("Token");

    //部署合约，等待部署完成
    const hardhatToken = await Token.deploy();
    await hardhatToken.deployed();

    // 合约地址
    console.log("Token address:", hardhatToken.address);

    // 保存合约地址与ABI到前端目录
    saveFrontendFiles(hardhatToken);
}


function saveFrontendFiles(token) {
  const fs = require("fs");
  const contractsDir = __dirname + "/../wp-small-team-project-master/src/contracts";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + "/contract-address.json",
    JSON.stringify({ Token: token.address }, undefined, 2)
  );

  const TokenArtifact = artifacts.readArtifactSync("Token");

  fs.writeFileSync(
    contractsDir + "/Token.json",
    JSON.stringify(TokenArtifact, null, 2)
  );
}

main()
.then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
