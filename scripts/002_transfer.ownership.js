const { upgrades } = require("hardhat");

async function main() {
  const gnosisSafe = "0xB481Fce38720e0A784Bf7a9193FE3EeB8516C60C";
  console.log("Transferring the ownership ...");

  await upgrades.admin.transferProxyAdminOwnership(gnosisSafe);
  console.log("Ownership transferred to multisig: ", gnosisSafe);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
