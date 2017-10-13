FROM 952607548445.dkr.ecr.eu-central-1.amazonaws.com/graebert/fluorine-host:20171013.1
ARG VERSION
ARG STREAM=master
ARG PACKAGE=fluorine
EXPOSE 80 81 443
ENV VERSION ${VERSION}
ENV STREAM ${STREAM}
ENV PACKAGE ${PACKAGE}
ENV DBPARAMS development
ENV TRIAL false
ENV DEBUG_EDITOR false
ENV EDITOR master-xe-latest.dev.graebert.com
ENV AWS_DEFAULT_REGION us-east-1
ENV APIURL ''
ENV SERVICE_80_NAME test
ENV LICENSING test
ENV ACCOUNTID 261943235010
ENV INTERCOM false
COPY runAndInstall.sh /opt/runAndInstall.sh
RUN chmod +x /opt/runAndInstall.sh

CMD ["/bin/bash", "-c", "/opt/runAndInstall.sh ${PACKAGE} ${STREAM} ${VERSION}"]
