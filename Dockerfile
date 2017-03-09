FROM alpine:3.3
RUN apk add --no-cache curl openssl jq bash git

RUN adduser -D -u 1001 letsencrypt

WORKDIR /home/letsencrypt

RUN git clone https://github.com/Neilpang/acme.sh.git

COPY bin /home/letsencrypt/bin
RUN chown -R 1001:0 /home/letsencrypt && chmod -R 770 /home/letsencrypt
ENV PATH "$PATH:/home/letsencrypt/bin"

#AWS ROUTE 53 Secrets
ENV ACME_DNS dns_aws
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""

# LETS ENCRYPT SETUP
ENV ACCOUNT_NAME ""

USER 1001
ENV HOME /home/letsencrypt

CMD ["acme"]
