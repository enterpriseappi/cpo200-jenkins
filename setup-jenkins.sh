#! /bin/bash
#
# File: setup-jenkins.sh
#
# Purpose: Install and configure Jenkins


cd



wget -qO jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar


UPDATE_LIST=$( java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ list-plugins | grep -e ')$' | awk '{ print $1 }' );
if [ ! -z "${UPDATE_LIST}" ]; then
    echo Updating Jenkins Plugins: ${UPDATE_LIST};
    java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin ${UPDATE_LIST};
    java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ safe-restart;
fi

echo "Installing required plugins"
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin git
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin google-storage-plugin
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin google-source-plugin
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin swarm -restart

#java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ restart
