SPARK_VERSION="3.4.2"
HADOOP_VERSION="3"
JUPYTERLAB_VERSION="4.1.1"

# -- Building the Images

podman build \
  -f cluster-base.Dockerfile \
  -t cluster-base .

podman build \
  --build-arg spark_version=${SPARK_VERSION} \
  --build-arg hadoop_version=${HADOOP_VERSION} \
  -f spark-base.Dockerfile \
  -t spark-base .

podman build \
  -f spark-master.Dockerfile \
  -t spark-master .

podman build \
  -f spark-worker.Dockerfile \
  -t spark-worker .

podman build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .

# Local copy of Notebooks and job-submit scripts outside Git change tracking
mkdir -p ./local/notebooks
cp -R ./local/notebooks/* ./notebooks

