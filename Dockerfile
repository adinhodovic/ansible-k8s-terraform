FROM python:3.7-alpine

RUN apk add --no-cache gcc musl-dev libffi-dev openssl-dev make git openssh curl

# Install Kubectl
COPY --from=lachlanevenson/k8s-kubectl:v1.15.3 /usr/local/bin/kubectl /usr/local/bin/kubectl

# Install Terraform
COPY --from=hashicorp/terraform:0.12.8 /bin/terraform /bin/terraform

# Install Ansible dependencies
# hadolint ignore=DL3013
RUN apk add postgresql-dev
RUN pip install jmespath docker boto3 botocore netaddr psycopg2==2.8.3 openshift==0.9.2 pyyaml==3.13

# Install Ansible
RUN pip install ansible==2.8.4

RUN pip install ansible-modules-hashivault
