# BMD-contract-deployment
A repository to streamline development effort and environment to deploy BMD contracts, etc.
This pulls in a pre-build docker image which already include the tools we need, and utilize them
to compile, migrate, and deploy the Solidity smart contracts to Ethereum public network.

# Launching Docker images

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
