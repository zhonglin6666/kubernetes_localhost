FROM ubuntu:14.04

MAINTAINER zhonglin6666 <zhonglin666@gmail.com>

WORKDIR /root

RUN api-get update
RUN api-get install -y ca-certificates wget iptables vim
RUN update-ca-certificates

RUN cd /tmp

## Download the release file of Kubernetes 1.5.0
RUN wget https://github.com/kubernetes/kubernetes/releases/download/v1.5.0/kubernetes.tar.gz

RUN tar -xzvf kubernetes.tar.gz
RUN tar -xzvf kubernetes/server/kubernetes-server-linux-amd64.tar.gz

## Install the executable binary
RUN cp kubernetes/server/bin/hyperkube /usr/bin/
RUN cp kubernetes/server/bin/kube-apiserver /usr/bin/
RUN cp kubernetes/server/bin/kube-controller-manager /usr/bin/
RUN cp kubernetes/server/bin/kube-scheduler /usr/bin/
RUN cp kubernetes/server/bin/kube-proxy /usr/bin/
RUN cp kubernetes/server/bin/kubelet /usr/bin/

## Delete useless files and packages
RUN rm -rf /tmp/*
RUN apt-get remove -y ca-certificates
RUN apt-get clean -y
RUN apt-get autoremove -y
