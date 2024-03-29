#!/bin/bash
MYSQL_PASSWORD="S0mereallyR4ndomP4ss"
MYSQL_SVC="localhost"
VAR="0"
MAX="4"

fn_drop_database(){

    mysql -uroot -p$MYSQL_PASSWORD --execute="drop database test2;"
    mysql -uroot -p$MYSQL_PASSWORD --execute="drop database test4;"
    mysql -uroot -p$MYSQL_PASSWORD --execute="drop database test6;"
    mysql -uroot -p$MYSQL_PASSWORD --execute="drop database test8;"
    mysql -uroot -p$MYSQL_PASSWORD --execute="drop database test10;"

}

fn_create_database(){

    mysql -uroot -p"$MYSQL_PASSWORD" --execute="create database test2;"
    mysql -uroot -p"$MYSQL_PASSWORD" --execute="create database test4;"
    mysql -uroot -p"$MYSQL_PASSWORD" --execute="create database test6;"
    mysql -uroot -p"$MYSQL_PASSWORD" --execute="create database test8;"
    mysql -uroot -p"$MYSQL_PASSWORD" --execute="create database test10;"
}

fn_run_test(){
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test2 --mysql-user=root --mysql-password=$MYSQL_PASSWORD prepare
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test2 --mysql-user=root --mysql-password=$MYSQL_PASSWORD --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=50 run >> /tmp/TEST_NUMBER_$VAR.log
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test4 --mysql-user=root --mysql-password=$MYSQL_PASSWORD prepare
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test4 --mysql-user=root --mysql-password=$MYSQL_PASSWORD --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=100 run >> /tmp/TEST_NUMBER_$VAR.log
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test6 --mysql-user=root --mysql-password=$MYSQL_PASSWORD prepare
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test6 --mysql-user=root --mysql-password=$MYSQL_PASSWORD --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=150 run >> /tmp/TEST_NUMBER_$VAR.log
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test8 --mysql-user=root --mysql-password=$MYSQL_PASSWORD prepare
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test8 --mysql-user=root --mysql-password=$MYSQL_PASSWORD --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=200 run >> /tmp/TEST_NUMBER_$VAR.log
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test10 --mysql-user=root --mysql-password=$MYSQL_PASSWORD prepare
    sysbench --test=oltp --oltp-table-size=500 --db-driver=mysql --mysql-db=test10 --mysql-user=root --mysql-password=$MYSQL_PASSWORD --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=200 run >> /tmp/TEST_NUMBER_$VAR.log
}


   
while [ $VAR -le $MAX ]
do
    fn_drop_database;
    fn_create_database;
    fn_run_test;
    echo "=============== CREATE TEST NUMBER $VAR ================" >> /tmp/TEST_NUMBER_$VAR.log ""

    VAR=$(( $VAR + 1 ))
done



