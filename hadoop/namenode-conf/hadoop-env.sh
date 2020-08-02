export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export HADOOP_HOME=/hadoop
export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true -Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_OS_TYPE=${HADOOP_OS_TYPE:-$(uname -s)}
export HADOOP_USER_CLASSPATH_FIRST="yes"
export HADOOP_SSH_OPTS="-o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=10s"
export HADOOP_PID_DIR=$HADOOP_HOME/run
export HADOOP_GC_SETTINGS="-verbose:gc"
export HDFS_NAMENODE_OPTS="${HADOOP_GC_SETTINGS}"
