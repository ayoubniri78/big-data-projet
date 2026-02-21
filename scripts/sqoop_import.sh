#!/bin/bash
# ============================================================
# sqoop_import.sh
# Importe la table `ventes` depuis MySQL vers HDFS
# ============================================================

MYSQL_HOST="mysql"
MYSQL_PORT="3306"
MYSQL_DB="bigdata"
MYSQL_USER="bduser"
MYSQL_PASS="bdpass"
HDFS_TARGET="/user/hadoopuser/project/db_data/ventes"

echo "=== Import Sqoop : MySQL → HDFS ==="

# Supprimer le dossier cible si déjà existant
/opt/hadoop/bin/hdfs dfs -rm -r -f ${HDFS_TARGET}

# Import avec :
#  - séparateur personnalisé (\t)
#  - filtre WHERE (quantite >= 5)
#  - 3 mappers
sqoop import \
  --connect "jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DB}" \
  --username "${MYSQL_USER}" \
  --password "${MYSQL_PASS}" \
  --table ventes \
  --where "quantite >= 5" \
  --target-dir "${HDFS_TARGET}" \
  --fields-terminated-by '\t' \
  --lines-terminated-by '\n' \
  --num-mappers 3 \
  --null-string '\\N' \
  --null-non-string '\\N'

echo ""
echo "=== Vérification des fichiers générés dans HDFS ==="
/opt/hadoop/bin/hdfs dfs -ls ${HDFS_TARGET}
echo ""
echo "=== Aperçu des 5 premières lignes ==="
/opt/hadoop/bin/hdfs dfs -cat ${HDFS_TARGET}/part-m-00000 | head -5