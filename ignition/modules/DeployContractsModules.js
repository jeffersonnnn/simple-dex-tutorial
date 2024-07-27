const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule(DeployContractsModule, (m) => {
    console.log("Deploying contracts to the network:", hre.network.name);
    const tokenSupply = 10000000; // Defining the initial supply for the tokens

    const simpleCoin = m.contract("SimpleCoin", [tokenSupply]);
    const anotherToken = m.contract("AnotherToken", [tokenSupply]);
    const littleDex = m.contract("LittleDex", [])

    return (simpleCoin, anotherToken, littleDex);
});