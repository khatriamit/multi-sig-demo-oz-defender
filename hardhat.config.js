require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");
require("@openzeppelin/hardhat-defender");
require("hardhat-deploy");

/** @type import('hardhat/config').HardhatUserConfig */

const deployerPublic = process.env.DEPLOYER_PUBLIC_KEY;
const deployerPrivate = process.env.DEPLOYER_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.18",
  namedAccounts: {
    deployer: deployerPublic,
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.ETHERSCAN_API_KEY,
    },
  },
  defender: {
    apiKey: process.env.DEFENDER_TEAM_API_KEY,
    apiSecret: process.env.DEFENDER_TEAM_API_SECRET_KEY,
  },
  networks: {
    mumbai: {
      url: process.env.RPC_MUMBAI,
      accounts: [deployerPrivate],
    },
  },
};
