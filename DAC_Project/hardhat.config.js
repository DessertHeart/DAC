require("@nomiclabs/hardhat-waffle");


//let dotenv = require('dotenv')
//dotenv.config({path:"./.env"})
//.env file content should be : MNEMONIC="your mnemonic"


// Go to https://infura.io/ and create a new project
// Replace this with your Infura project ID

//const INFURA_PROJECT_ID = "YOUR INFURA PROJECT ID";
//const mnemonic = process.env.MNEMONIC


// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
//const ROPSTEN_PRIVATE_KEY = "YOUR ROPSTEN PRIVATE KEY";


/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.7.3",
  //networks: {
  //  ropsten: {
  //    url: `https://ropsten.infura.io/v3/${INFURA_PROJECT_ID}`,
  //    accounts: [`0x${ROPSTEN_PRIVATE_KEY}`]
  //  }
  //}
};
