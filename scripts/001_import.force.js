const { ethers, upgrades } = require("hardhat");

async function main() {
  const proxyAddress = "0x5B5E0e1a80aFd3780089114b77712310dfB0433F";

  const Box = await ethers.getContractFactory("Box");
  console.log("Start Import");

  await upgrades.forceImport(proxyAddress, Box);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
