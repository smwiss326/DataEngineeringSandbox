DF_SPARK=Dockerfile
SPARK_IMG=spark
DK=docker
MASTER_HOST=master
NET_NAME=spark-cluster

 build:
	@$(DK) build \
	-f $(DF_SPARK) \
	-t $(SPARK_IMG) \
	.

 shell:
	@$(DK) run \
	--rm \
	-it \
	-p 4040:4040 \
	--network=$(NET_NAME) \
	$(SPARK_IMG) \
	runner \
	shell \
	$(MASTER_HOST)

 master:
	@$(DK) run \
	--rm \
	-it \
	-d \
	-p 8080:8080 \
	-p 7077:7077 \
	-p 6066:6066 \
	--name master \
	--network=$(NET_NAME) \
	--hostname $(MASTER_HOST) \
	$(SPARK_IMG) \
	runner \
	master

 worker:
	@$(DK) run \
	--rm \
	-it \
	-d \
	-p 8081:8081 \
	-p 5000 \
	--network=$(NET_NAME) \
	$(SPARK_IMG) \
	runner \
	worker \
	$(MASTER_HOST)

 bash:
	@$(DK) run \
	--rm \
	-it \
	-p 8080 \
	-p 8081 \
	-p 7077 \
	-p 6066 \
	-p 4040 \
	-p 5000 \
	$(SPARK_IMG) \
	bash

 network:
	@$(DK) network create $(NET_NAME)
