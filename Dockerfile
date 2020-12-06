ARG SPARK_VERSION
FROM bde2020/spark-base:${SPARK_VERSION}

LABEL maintainer="Emanuele Falzone <emanuele.falzone@polimi.it>"

COPY wait-for.sh /
COPY start.sh /

RUN chmod +x /wait-for.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]