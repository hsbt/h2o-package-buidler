FROM centos:7
MAINTAINER hsbt@ruby-lang.org

RUN yum -y install --enablerepo=extras epel-release
RUN yum -y groupinstall "Development Tools"
RUN yum -y install zlib-devel ruby rake wget

WORKDIR /opt
RUN wget http://www.cmake.org/files/v3.3/cmake-3.3.1-Linux-x86_64.sh
RUN chmod 755 cmake-3.3.1-Linux-x86_64.sh
RUN yes | ./cmake-3.3.1-Linux-x86_64.sh

WORKDIR /usr/local/src
RUN git clone --depth 1 https://github.com/h2o/h2o.git

WORKDIR /usr/local/src/h2o
RUN /opt/cmake-3.3.1-Linux-x86_64/bin/cmake -DWITH_BUNDLED_SSL=on -DWITH_MRUBY=ON .
RUN make
