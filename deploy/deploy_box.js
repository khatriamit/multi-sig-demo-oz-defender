module.exports = async ({ deployments }) => {
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;
  console.log("deploying contract ...");
  await deploy("Box", {
    from: deployer,
    args: [],
    proxy: {
      proxyContract: "OpenZeppelinTransparentProxy",
      execute: {
        inti: {
          methodName: "store",
          args: ["10"],
        },
      },
    },
    logs: true,
    autoMine: true,
  });
};

// module.exports.tags = ["Box"];
