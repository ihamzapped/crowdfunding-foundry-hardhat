# Crowd Funding

A crowd funding solidity project I did as part of [this](https://www.udemy.com/course/master-ethereum-and-solidity-programming-with-real-world-apps/) course. The course covers base contract while I set up this foundry-hardhat project to unit test and deploy the contract

## Setup

**Recommended**

1. Create .env from example file
2. Install [pnpm](https://pnpm.io/installation)
   and [foundry](https://book.getfoundry.sh/getting-started/installation).
3. Run the following command in project root:

```shell
 pnpm deps
```

## Deploy

```shell
 pnpm deploy:<mumbai | fuji>
```

## Test Crowd Funding Contract

```shell
 pnpm test:cf
```

## Compile

```shell
 npx hardhat compile | forge compile
```

P.S: This code is un-audited and not to be used in production
