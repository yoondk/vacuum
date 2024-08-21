1) vacuum_config_set.sh
실행 방법
sh vacuum_config_set.sh  file_list

file_list에 vacuum 관련 파라메터 설정 테이블을 schema.table 형태로 입력한다.


file_list 내용
===============
scott.emp

scott.sallary



2) recover.sh
실행 방법

sh recover.sh schema.table

해당 테이블의 autovacuum 관련 설정을 없앤다.

