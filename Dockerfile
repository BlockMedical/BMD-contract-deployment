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

FROM blcksync/alpine-node:latest

LABEL maintainer="al-blockmed"

RUN apk update && apk upgrade && \
    apk add --no-cache ca-certificates bash git busybox-extras && \
    rm -rf /var/cache/apk/* ;

COPY --from=builder /usr/lib/node_modules /usr/lib/node_modules
COPY --from=builder /root/deploy /root/deploy

RUN cd /usr/bin/; \
    ln -s ../lib/node_modules/node-gyp/bin/node-gyp.js node-gyp ; \
    ln -s ../lib/node_modules/solc/solcjs solcjs ; \
    ln -s ../lib/node_modules/truffle/build/cli.bundled.js truffle ; \
    cd /root/deploy ; \
    cd BMD-smartcontract ; \
    rm -rf ./build; truffle compile && \
    cd .. ; \
    cd BMV-ventureasset ; \
    rm -rf ./build; truffle compile && \
    cd ..

CMD ["bash"]
