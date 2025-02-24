const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
    },
    private: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, process.env.BLOCKCHAIN_URL),
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.26",
    },
  },
};