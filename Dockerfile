FROM ubuntu:16.04

ENV SPARK_HOME=/usr/local/spark
ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_WEBUI_PORT=8080
ENV SPARK_WORKER_PORT=5000
ENV SPARK_WORKER_WEBUI_PORT=8081

RUN apt-get update -q \
    && apt-get install -q -y \
    default-jdk \
    scala \
    wget

RUN wget http://www-us.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz

RUN tar -xvf spark-2.3.1-bin-hadoop2.7.tgz

RUN mv spark-2.3.1-bin-hadoop2.7 /usr/local/
RUN ln -s /usr/local/spark-2.3.1-bin-hadoop2.7/ /usr/local/spark
RUN cd /usr/local/spark

##RUN mkdir $LOG_DIR

COPY runner.sh /usr/local/bin/runner

RUN chmod +x /usr/local/bin/runner

CMD ["runner"]
