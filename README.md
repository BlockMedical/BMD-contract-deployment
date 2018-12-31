# BMD-contract-deployment
A repository to streamline development effort and environment to deploy BMD contracts, etc.
This pulls in a pre-build docker image which already include the tools we need, and utilize them
to compile, migrate, and deploy the Solidity smart contracts to Ethereum public network.

**Pre-requisite**
You will need Docker installed. To download Docker and get started, visit official [Docker website here](https://www.docker.com/get-started). For a video tutorial, there are plenty of them online, however,
we have found some nice ones on Youtube such as this one https://www.youtube.com/watch?v=K90yOMr8wXo
**NOTE** We are not affiliated with the Youtube video provided, we are only providing it to help users installing
Docker if they are a first time user. For more information, you can reach out to the [Docker community here](https://www.docker.com/docker-community)

# Launching Docker images

## Configuring credentials and private keys for deployment

### `truffle.env`: A local file that contains 2 environment variables to configure.
#### **MNENOMIC**: The 12/16 word phrase to import private keys for deployment inside the docker container.
#### **INFURA_API_KEY**: The Infura API token/key to utilize Infura to relay the signed transaction for you. This is fine because you have already signed your transaction offline in your container environment. The Infura API provides you a convinient proxy to interact with the Ethereum blockchain without you running a full node locally. The signed transaction is protected by your private key and won't be altered during the entire submission.

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

The command you will be using will be the least but not last of the followings:
```
truffle compile
truffle migrate --network=ropstan
# Dry run before submitting to the MAINNET
truffle migrate --network=mainnet --dry-run
# Submit to the MAINNET
truffle migrate --network=mainnet
```

## Stopping Docker containers
```
docker-compose -f bmd.yml stop
```

## Remove container and caches for local cleanup and a fresh start
Make sure you do this. This removes the local cache so others cannot pick it up and re-use them.
```
docker-compose -f bmd.yml rm -f
```
