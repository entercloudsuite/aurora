FROM ubuntu:latest

RUN apt-get update && apt-get install -y python python-pip libssl-dev libffi-dev rsync openssh-client zip curl jq python-openstackclient python-cinderclient tree git
RUN pip install --upgrade pip && pip install ansible==2.2.1.0 molecule docker-py
RUN pip install shade
RUN apt-get clean && rm -rf /var/lib/apt/lists

ENTRYPOINT ["/bin/bash"]