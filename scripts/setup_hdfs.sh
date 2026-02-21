#!/bin/bash
# ============================================================
# setup_hdfs.sh
# Étape 1 : Création de l'arborescence HDFS du projet
# ============================================================

echo "=== Création de l'arborescence HDFS ==="

/opt/hadoop/bin/hdfs dfs -mkdir -p /user/hadoopuser/project/logs
/opt/hadoop/bin/hdfs dfs -mkdir -p /user/hadoopuser/project/db_data
/opt/hadoop/bin/hdfs dfs -mkdir -p /user/hadoopuser/project/input
/opt/hadoop/bin/hdfs dfs -mkdir -p /user/hadoopuser/project/output

/opt/hadoop/bin/hdfs dfs -chmod -R 777 /user/hadoopuser/project

echo ""
echo "=== Arborescence créée ==="
/opt/hadoop/bin/hdfs dfs -ls -R /user/hadoopuser/project

echo ""
echo "=== Vérification de l'espace disque HDFS ==="
/opt/hadoop/bin/hdfs dfs -df -h /