#!/bin/bash

echo "Démarrage des services Hadoop..."


service ssh restart
/usr/local/hadoop/sbin/stop-all.sh
rm -Rf /app/hadoop/tmp/*
rm -Rf /usr/local/hadoop/yarn_data/hdfs/namenode/*
rm -Rf /usr/local/hadoop/yarn_data/hdfs/datanode/*

/usr/local/hadoop/bin/hdfs namenode -format -force
/usr/local/hadoop/sbin/start-all.sh

/usr/local/hadoop/bin/hdfs dfs -chmod -R 1777 /


# Vérifier les processus
echo "Processus Java démarrés :"
jps


