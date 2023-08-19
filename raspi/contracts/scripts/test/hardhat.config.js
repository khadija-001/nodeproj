import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.19",
  };

  module.exports = {
    defaultNetwork: "sepolia",
    networks: {
      localhost: {
        url: "http://127.0.0.1:8545", // Replace with your desired RPC URL
        chainId: 31337,
      },
      hardhat: {
      },
      sepolia: {
        url: "https://eth-sepolia.g.alchemy.com/v2/<key>",
        accounts: [privateKey1, privateKey2, ...]
      }
    },
    solidity: {
      version: "0.8.19",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    },
    paths: {
      sources: "./contracts",
      tests: "./test",
      cache: "./cache",
      artifacts: "./artifacts"
    },
    mocha: {
      timeout: 40000
    }
  }
  export default config;