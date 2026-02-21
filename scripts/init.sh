#!/bin/bash
# ============================================================
# init.sh - Initialisation : HDFS + MySQL + Sqoop
# ============================================================

export HADOOP_HOME=/opt/hadoop
export JAVA_HOME=/opt/jdk8
export PATH=$PATH:/opt/hadoop/bin:/opt/sqoop/bin:/opt/jdk8/bin

echo "============================================"
echo "   Initialisation du Mini-Projet Big Data   "
echo "============================================"

# ── 1. Installer JDK si absent ───────────────────────────
if [ ! -d "/opt/jdk8" ]; then
    echo ">>> Installation du JDK..."
    curl -L "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u392-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u392b08.tar.gz" \
        -o /tmp/jdk8.tar.gz
    tar -xzf /tmp/jdk8.tar.gz -C /opt/
    mv /opt/jdk8u392-b08 /opt/jdk8
    rm /tmp/jdk8.tar.gz
    echo "    JDK installé !"
else
    echo ">>> JDK déjà installé."
fi

# ── 2. Installer Sqoop si absent ─────────────────────────
if [ ! -d "/opt/sqoop" ]; then
    echo ">>> Installation de Sqoop..."
    curl -s https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
        -o /tmp/sqoop.tar.gz
    tar -xzf /tmp/sqoop.tar.gz -C /opt/
    mv /opt/sqoop-1.4.7.bin__hadoop-2.6.0 /opt/sqoop
    rm /tmp/sqoop.tar.gz
    curl -s https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
        -o /opt/sqoop/lib/mysql-connector-java.jar
    curl -s https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar \
        -o /opt/sqoop/lib/commons-lang-2.6.jar
    cp /opt/sqoop/conf/sqoop-env-template.sh /opt/sqoop/conf/sqoop-env.sh
    echo "export HADOOP_COMMON_HOME=/opt/hadoop" >> /opt/sqoop/conf/sqoop-env.sh
    echo "export HADOOP_MAPRED_HOME=/opt/hadoop"  >> /opt/sqoop/conf/sqoop-env.sh
    echo "    Sqoop installé !"
else
    echo ">>> Sqoop déjà installé."
fi

# ── 3. Attendre HDFS ─────────────────────────────────────
echo ""
echo ">>> Attente du démarrage HDFS..."
until /opt/hadoop/bin/hdfs dfs -ls / > /dev/null 2>&1; do
    echo "    HDFS pas encore prêt, attente 5s..."
    sleep 5
done
echo "    HDFS est prêt !"

# ── 4. Créer l'arborescence HDFS ─────────────────────────
echo ""
echo ">>> Étape 1 : Création de l'arborescence HDFS..."
bash /opt/scripts/setup_hdfs.sh

# ── 5. Attendre MySQL ────────────────────────────────────
echo ""
echo ">>> Attente du démarrage MySQL..."
until bash -c "echo > /dev/tcp/mysql/3306" > /dev/null 2>&1; do
    echo "    MySQL pas encore prêt, attente 5s..."
    sleep 5
done
sleep 10
echo "    MySQL est prêt !"

# ── 6. Import Sqoop ──────────────────────────────────────
echo ""
echo ">>> Étape 2 : Import Sqoop MySQL → HDFS..."
bash /opt/scripts/sqoop_import.sh

echo ""
echo "============================================"
echo "   Initialisation terminée avec succès !"
echo "============================================"
/opt/hadoop/bin/hdfs dfs -ls -R /user/hadoopuser/project