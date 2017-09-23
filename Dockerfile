FROM docker.elastic.co/logstash/logstash:5.6.1

COPY logstash.yml /usr/share/logstash/config/logstash.yml
COPY pipeline.conf /usr/share/logstash/pipeline/logstash.conf
