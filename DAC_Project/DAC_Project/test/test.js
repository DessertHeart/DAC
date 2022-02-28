//chai是一个"匹配器"函数库，来自Waffle
//返回一个Promise，故需要await配合，详细查看Waffle文档
const { expect } = require("chai");

describe("Token contract", function() {
  it("Deployment should assign the total supply of tokens to the owner", async function() {
    const [owner] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("Token");

    const hardhatToken = await Token.deploy();
    await hardhatToken.deployed();

    // 验证总发行量是否等于部署后的owner的余额
    const ownerBalance = await hardhatToken.balanceOf(owner.getAddress());
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });
});
