#!/bin/bash

if [ $# -ne 1 ]; then
   echo "  argument error "
   echo "  ex) $0  schema.table"
   exit 1
fi

DBNAME="adi"
USERNAME="scott"

schema=`echo $1 | cut -d '.' -f1`
table=`echo $1  | cut -d '.' -f2`
echo " "
echo " schema : $schema "
echo " table  : $table  "
echo " "

asql -U $USERNAME -d $DBNAME -c " UPDATE pg_class   \
                                  SET    reloptions = NULL   \
                                  WHERE  relname  like '$table' and relnamespace::regnamespace::varchar like '$schema'  "

asql -U $USERNAME -d $DBNAME -c "SELECT trim(relname) AS TABLE, trim(reloptions::varchar) AS SETTING  \
                                 FROM   pg_class  \
				 WHERE  relname  like '$table' and relnamespace::regnamespace::varchar like '$schema'  "

