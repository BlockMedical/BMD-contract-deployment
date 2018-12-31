FROM blcksync/docker-solidity-development-framework:latest

LABEL maintainer="al-blockmed"

RUN cd /go/deploy ; \
    git clone https://github.com/BlockMedical/BMD-smartcontract.git ; \
    cd BMD-smartcontract ; \
    npm install && \
    rm -rf ./build; truffle compile && \
    cd .. ; \
    git clone -b v0.3.0 https://github.com/BlockMedical/BMV-ventureasset.git ; \
    cd BMV-ventureasset ; \
    npm install && \
    rm -rf ./build; truffle compile && \
    cd ..

CMD ["bash"]
