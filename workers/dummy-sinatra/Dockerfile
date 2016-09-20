FROM ruby:2.2.1

RUN apt-get update && \
    apt-get install -y net-tools

ENV APP_HOME /app
ENV HOME /root

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install

COPY ./dummy.rb $APP_HOME

ENV PORT 3000

EXPOSE 3000

CMD ["ruby", "dummy.rb"]
