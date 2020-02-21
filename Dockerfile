FROM amazonlinux:latest
LABEL ref "https://github.com/sickp/docker-alpine-sshd"
LABEL maintainer "sawanoboriyu@higanworks.com"

EXPOSE 22

RUN install -d /root/.ssh -m 0700

RUN yum install -y openssh-server aws-cli ec2-utils jq \
  && sed -i s/PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && sed -i s/PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config \
  && sed -i s/#PermitUserEnvironment.*/PermitUserEnvironment\ yes/ /etc/ssh/sshd_config

RUN PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/aws/bin >> /root/.ssh/environment
env > /tmp/env.txt
env | grep AWS_ >> /root/.ssh/environment

RUN echo "root:root_pw" | chpasswd

# generate host keys if not present
RUN ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
CMD exec /usr/sbin/sshd -d -D -e
