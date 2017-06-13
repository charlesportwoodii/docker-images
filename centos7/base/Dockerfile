FROM centos:centos7
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

# Install EPEL
RUN curl -O https://download-ib01.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install epel-release-latest-7.noarch.rpm -y && \
    rm epel-release-latest-7.noarch.rpm

# Upgrade
RUN yum update -y && \
    yum upgrade -y

# Install Erianna RPM Repo and necessary extra packages
RUN sh -c 'echo -e "[erianna]\nname=Erianna RPM Repository\nbaseurl=https://rpm.erianna.com/CentOS/7/x86_64\nenabled=1\ngpgcheck=0\nprotect=1\ngpgkey=https://keybase.io/charlesportwood/key.asc" > /etc/yum.repos.d/rpm.erianna.com.repo' && \
    yum --enablerepo=erianna clean metadata && \
    yum clean all && \ 
    ldconfig