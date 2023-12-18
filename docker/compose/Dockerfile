FROM alpine:3.18

RUN apk add --update --no-cache openssh

RUN ssh-keygen -A

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && echo "root:password" | chpasswd

EXPOSE 22

ENTRYPOINT /usr/sbin/sshd -D

