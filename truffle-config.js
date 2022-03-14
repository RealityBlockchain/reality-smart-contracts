const HDWalletProvider = require("truffle-hdwallet-provider");
const fs = require("fs");
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    loc_reality_reality: {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1"
    }
  },
  compilers: {
    solc: {
      version: "0.8.12"
    }
  }
};
