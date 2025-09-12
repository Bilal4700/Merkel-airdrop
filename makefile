
foundry-install:;curl -L https://foundry.paradigm.xyz | bash

install:;forge install openzeppelin/openzeppelin-contracts dmfxyz/murky cyfrin/foundry-devops

initialise-zksync:;foundryup-zksync

build-zksync:;forge build --zksync