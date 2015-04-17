FROM quay.io/aptible/ubuntu:12.04
MAINTAINER "Lewis Marshall" lewis@techniplusit.co.uk

RUN apt-get update
RUN apt-get -y install wget build-essential zlib1g-dev libssl-dev \
    libreadline6-dev libyaml-dev && cd /tmp && \
    wget -q http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.gz && \
    tar xzf ruby-2.2.0.tar.gz && \
    cd ruby-2.2.0 && ./configure --enable-shared --prefix=/usr && \
    make && make install && cd .. && rm -rf ruby-2.2.0*
# RUN gem install bundler

ADD ./ /hod-app/

RUN adduser web --home /home/web --shell /bin/bash --disabled-password --gecos ""
RUN chown -R web:web /hod-app

USER web
ENV HOME /home/web
ENV PATH $PATH:/home/web/.gem/ruby/2.2.0/bin
ENV GEM_HOME /home/web/.gem/ruby/2.2.0
ENV GEM_PATH $GEM_HOME
RUN gem install --user-install bundler
WORKDIR /hod-app/
RUN bundle install
USER root
RUN chown -R web:web /hod-app

EXPOSE 4567
CMD ["/bin/sh", "-c", "su - web -c cd /hod-app && ruby ./server.rb"]
