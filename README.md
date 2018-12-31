# BMD-contract-deployment
A repository to streamline development effort and environment to deploy BMD contracts, etc.
This pulls in a pre-build docker image which already include the tools we need, and utilize them
to compile, migrate, and deploy the Solidity smart contracts to Ethereum public network.

# Launching Docker images

## Configuring credentials and private keys for deployment
* `truffle.env`: A local file that contains 2 environment variables to configure.
** **MNENOMIC**: The 12/16 word phrase to import private keys for deployment inside the docker container.
** **INFURA_API_KEY**: The Infura API token/key to utilize Infura to relay the signed transaction for you. This is fine because you have already signed your transaction offline in your container environment. The Infura API provides you a convinient proxy to interact with the Ethereum blockchain without you running a full node locally. The signed transaction is protected by your private key and won't be altered during the entire submission.

## Starting Docker containers
From the `Terminal`, kick off the following command:
```
docker-compose -f bmd.yml up
```

## Login to our Truffle environment to compile, migrate, and deploy contracts
The following command brings you into the Docker container, and give you a command prompt
to run truffle commands to compile, migrate, and deploy your contracts.
```
docker exec -it $(docker ps | grep 'alblockmed/bmdcontract-deployment:latest' | cut -d " " -f1) bash
```

## Stopping Docker containers
```
docker-compose -f bmd.yml stop
```

## Remove container and caches for local fresh start
```
docker-compose -f bmd.yml rm -f
```
