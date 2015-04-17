FROM ruby:slim
MAINTAINER "Lewis Marshall" lewis@techniplusit.co.uk
RUN gem install bundler
CMD ["./server.rb"]
