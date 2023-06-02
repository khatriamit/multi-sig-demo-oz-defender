const { ethers, upgrades } = require("hardhat");
const { defender } = require("hardhat");

async function main() {
  const proxyAddress = "0x5B5E0e1a80aFd3780089114b77712310dfB0433F";

  const BoxV2 = await ethers.getContractFactory("BoxV2");
  console.log(BoxV2.address);
  console.log("Preparing upgrade");

  const boxV2Address = await defender.proposeUpgrade(proxyAddress, BoxV2, {
    kind: "transparent",
  });
  // const boxV2Address = await upgrades.forceImport(proxyAddress, BoxV2);
  console.log("Box V2 at: ", boxV2Address.url);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
