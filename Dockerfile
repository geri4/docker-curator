FROM alpine:3.6

ENV CURATOR_VERSION 5.6.0
ENV ELASTICSEARCH_HOST 127.0.0.1
ENV ELASTICSEARCH_PORT 9200
ENV INDICES_PREFIX logstash-
ENV MAX_INDEX_AGE 30

RUN apk --no-cache add bash gettext python py-setuptools py-pip gcc libffi py-cffi python-dev libffi-dev py-openssl musl-dev linux-headers openssl-dev libssl1.0 && \
    pip install elasticsearch-curator==$CURATOR_VERSION && \
    pip install boto3==1.9.59 && \
    pip install requests-aws4auth==0.9 && \
    pip install cryptography==2.1.3 && \
    apk del py-pip gcc python-dev libffi-dev musl-dev linux-headers openssl-dev && \
    sed -i '/import sys/a urllib3.contrib.pyopenssl.inject_into_urllib3()' /usr/bin/curator && \
    sed -i '/import sys/a import urllib3.contrib.pyopenssl' /usr/bin/curator && \
    sed -i '/import sys/a import urllib3' /usr/bin/curator


ADD docker-entrypoint.sh /
ADD config.yml /etc/curator/
ADD actions.yml /etc/curator/

RUN printf "\n0\t2\t*\t*\t*\tcurator --config /etc/curator/config.yml /etc/curator/actions.yml" >> /etc/crontabs/root


#ADD tasks/optimize-indices.sh /etc/periodic/
#ADD tasks/purge-old-indices.sh /etc/periodic/

#RUN printf "\n0\t2\t*\t*\t*\t/etc/periodic/purge-old-indices.sh" >> /etc/crontabs/root
#RUN printf "\n0\t2\t*\t*\t*\t/etc/periodic/optimize-indices.sh" >> /etc/crontabs/root


ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["crond", "-f", "-l", "8"]
