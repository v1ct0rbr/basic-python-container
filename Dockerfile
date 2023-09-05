FROM python:3.8-slim as envs
LABEL maintainer="Victor Queiroga <victorqueiroga.com>"

# Set arguments to be used throughout the image
ARG OPERATOR_HOME="/home/op"
# Bitbucket-pipelines uses docker v18, which doesn't allow variables in COPY with --chown, so it has been statically set where needed.
# If the user is changed here, it also needs to be changed where COPY with --chown appears
ARG OPERATOR_USER="op"
ARG OPERATOR_UID="50000"

# Attach Labels to the image to help identify the image in the future
LABEL com.victorqueirogabr.docker=true
LABEL com.victorqueirogabr.docker.distro="debian"
LABEL com.victorqueirogabr.docker.module="s3fs-envs"
LABEL com.victorqueirogabr.docker.component="victorqueirogabr-s3fs-envs"
LABEL com.victorqueirogabr.docker.uid="${OPERATOR_UID}"

# Add environment variables based on arguments
ENV OPERATOR_HOME ${OPERATOR_HOME}
ENV OPERATOR_USER ${OPERATOR_USER}
ENV OPERATOR_UID ${OPERATOR_UID}
#ENV BUCKET_NAME ${BUCKET_NAME}
#ENV S3_ENDPOINT ${S3_ENDPOINT}

RUN mkdir -p ${OPERATOR_HOME}
RUN echo 'user creation in progress...'
RUN useradd -ms /bin/bash -d ${OPERATOR_HOME} --uid ${OPERATOR_UID} ${OPERATOR_USER}
RUN chown -R ${OPERATOR_USER}:${OPERATOR_USER} ${OPERATOR_HOME}

# Add user for code to be run as (we don't want to be using root)


