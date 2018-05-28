FROM golang:1.8
MAINTAINER excessivespeed@126.com

RUN curl -SL http://p1c71d06h.bkt.clouddn.com/kubectl-v1.8.6 -o /usr/bin/kubectl-v1.8.6 && \
    curl -SL http://p1c71d06h.bkt.clouddn.com/kubectl-v1.7.3 -o /usr/bin/kubectl-v1.7.3 && \
    chmod 777 /usr/bin/kubectl-v1.8.6 && \
    chmod 777 /usr/bin/kubectl-v1.7.3 && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY . /go/src/wise-resource-manager
COPY platform/k8s/kubectl/kubeconf.gotmpl /
COPY ./templates /go/bin/templates

WORKDIR /go/src/wise-resource-manager
RUN GOOS=linux GOARCH=amd64 go build -o /go/bin/wise-resource-manager

WORKDIR /go/bin/

ENTRYPOINT ["/go/bin/wise-resource-manager"]
EXPOSE 9000