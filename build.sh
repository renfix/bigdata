# -- Software Stack Version

# NOTE: 
# spark-3.1.2 uses jetty-9.4.40 - https://spark.apache.org/releases/spark-release-3-1-2.html
# jetty-9.4.x uses Java 8 - https://www.eclipse.org/jetty/
DEBIAN_BUSTER_IMAGE_TAG=8-jre-slim
SHARED_WORKSPACE=/opt/workspace
SPARK_VERSION="3.1.2" #"3.0.0"
HADOOP_VERSION="3.2" #"2.7"
SPARK_MASTER_WEB_UI=8080
SPARK_WORKER_WEB_UI=8081
JUPYTERLAB_VERSION="3.0.16" #"2.1.5"

# -- Building the Images

docker build \
  --build-arg debian_buster_image_tag="${DEBIAN_BUSTER_IMAGE_TAG}" \
  --build-arg shared_workspace="${SHARED_WORKSPACE}" \
  -f cluster-base.Dockerfile -t cluster-base .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f spark-base.Dockerfile -t spark-base .

docker build \
  --build-arg spark_master_web_ui="${SPARK_MASTER_WEB_UI}" \
  -f spark-master.Dockerfile \
  -t spark-master .

docker build \
  --build-arg spark_worker_web_ui="${SPARK_WORKER_WEB_UI}" \
  -f spark-worker.Dockerfile \
  -t spark-worker .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .
