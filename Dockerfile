# Use the OpenShift CLI image as the base
FROM quay.io/openshift-pipeline/openshift4-ose-cli:9a629946

# Install jq and Python
USER root
RUN yum install -y jq python3 && yum clean all

# Switch back to a non-root user
USER 1001
