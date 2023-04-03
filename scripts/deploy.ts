import hre, { ethers } from "hardhat";
import { fromEpoch } from "./helpers";

const { parseUnits } = ethers.utils;

const min = 100;
const goal = 1_200_000;
const time = Math.round(Date.now() / 1000) * 2;

const goalBig = parseUnits(String(goal));

const params = [goalBig, time, min] as const;

async function main() {
  try {
    const CrowdFunding = await ethers.getContractFactory("CrowdFunding");
    const cf = await CrowdFunding.deploy(...params);

    await cf.deployTransaction.wait(6);

    console.log(
      `Deployed CrowdFunding Contract
      Goal: ${goal}
      Deadline: ${fromEpoch(time)}
      Address: ${cf.address}\n`
    );

    await hre.run("verify:verify", {
      address: cf.address,
      constructorArguments: params,
    });
  } catch (error) {
    throw error;
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
