#!/bin/bash

if [ $# -ne 1 ]; then
   echo "   argument error "
   echo "   ex) $0  filename"
   exit 1
fi

DBNAME="adi"
USERNAME="adi"

echo "======================================================================== "
echo " $DBNAME DB table level autovacuum config setting ... "
echo " USER : " $USERNAME
echo " DB   : " $DBNAME
echo "======================================================================== "

for list in `cat $1`;
do
   echo "ALTER TABLE  $list  SET (autovacuum_vacuum_scale_factor   = 0.0);  "
   asql -U $USERNAME -d $DBNAME -c "ALTER TABLE  $list  SET (autovacuum_vacuum_scale_factor   = 0.0);  "

   echo "ALTER TABLE  $list  SET (autovacuum_vacuum_threshold      = 1000); "
   asql -U $USERNAME -d $DBNAME -c "ALTER TABLE  $list  SET (autovacuum_vacuum_threshold      = 1000); "

   echo "ALTER TABLE  $list  SET (autovacuum_analyze_scale_factor  = 0.0);  "
   asql -U $USERNAME -d $DBNAME -c "ALTER TABLE  $list  SET (autovacuum_analyze_scale_factor  = 0.0);  "

   echo "ALTER TABLE  $list  SET (autovacuum_analyze_threshold     = 1000); "
   asql -U $USERNAME -d $DBNAME -c "ALTER TABLE  $list  SET (autovacuum_analyze_threshold     = 1000); "

   echo "ALTER TABLE  $list  SET (autovacuum_vacuum_cost_limit     = 1000); "
   asql -U $USERNAME -d $DBNAME -c "ALTER TABLE  $list  SET (autovacuum_vacuum_cost_limit     = 1000); "
done

for list in `cat $1`;
do
   schema=`echo $list | cut -d '.' -f1`
   table=`echo $list | cut -d '.' -f2`
#  echo " schema : $schema  ,  table : $table "

   asql -U $USERNAME -d $DBNAME -c "SELECT trim(relname) AS TABLE, trim(reloptions::varchar) AS SETTING FROM pg_class where relname in ('$table') and relnamespace::regnamespace::varchar like '$schema'  "
done

### end of file
