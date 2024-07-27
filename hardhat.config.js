require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    taiko: {
      url: process.env.TAIKO_RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
    scroll: {
      url: process.env.SCROLL_TESTNET_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
    polygon: {
      url: process.env.POLYGON_TESTNET_URL,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
