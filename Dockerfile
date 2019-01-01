FROM blcksync/docker-solidity-development-framework:latest as builder

LABEL maintainer="al-blockmed"

RUN mkdir -p /root/deploy; cd /root/deploy ; \
    git clone -b encryption-v0.5.3 https://github.com/BlockMedical/BMD-smartcontract.git ; \
    cd BMD-smartcontract ; \
    npm install && \
    cd .. ; \
    git clone -b v0.3.0 https://github.com/BlockMedical/BMV-ventureasset.git ; \
    cd BMV-ventureasset ; \
    npm install && \
    cd ..

FROM blcksync/docker-solidity-development-framework:latest

LABEL maintainer="al-blockmed"

RUN apk update && apk upgrade && \
    apk add --no-cache ca-certificates bash git busybox-extras && \
    rm -rf /var/cache/apk/* ;

COPY --from=builder /root/deploy /root/ 

RUN cd /root/deploy ; \
    git clone -b encryption-v0.5.3 https://github.com/BlockMedical/BMD-smartcontract.git ; \
    cd BMD-smartcontract ; \
    rm -rf ./build; truffle compile && \
    cd .. ; \
    git clone -b v0.3.0 https://github.com/BlockMedical/BMV-ventureasset.git ; \
    cd BMV-ventureasset ; \
    rm -rf ./build; truffle compile && \
    cd ..

CMD ["bash"]
