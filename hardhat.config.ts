import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    defichain: {
      url: "https://dmc.mydefichain.com/testnet" as string,
      accounts: [process.env.PRIVATE_KEY as string],
      chainId: 1131,
      gasPrice: 12500000000,
    },
  },
};

export default config;
