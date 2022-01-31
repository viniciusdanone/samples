#!/bin/bash
ENGINE_VERSION="5.7.36"
RDS_DESTINATION="chatlab-migration-primary"
RDS_SOURCE="chatlab-stg"
RDS_SNAPSHOT="rds:chatlab-stg-2022-01-30-23-07"
RDS_SIZE="db.t2.small"

fn_snapshot_restore (){
echo "Starting restore from snampshot $RDS_SNAPSHOT, wait and take a coffe..."    
time aws rds restore-db-instance-from-db-snapshot \
    --engine mysql \
    --no-multi-az \
    --publicly-accessible \
    --db-instance-identifier $RDS_DESTINATION \
    --db-snapshot-identifier $RDS_SNAPSHOT \
    --db-instance-class $RDS_SIZE \
    --wait
}

fn_instance_upgrade(){
echo "Starting upgrade of instance $RDS_DESTINATION"
time aws rds modify-db-instance \
    --db-instance-identifier $RDS_DESTINATION \
    --backup-retention-period 7 \
    --engine-version $ENGINE_VERSION \
    --apply-immediately \
    --wait
}

fn_instance_list(){
raws ds describe-db-instances \
    --db-instance-identifier $RDS_DESTINATION
}

case "$1" in
 'restore')
   fn_snapshot_restore;;
 'upgrade')
   fn_instance_upgrade;;
 'describe')
   fn_instance_list;;
 *)
       echo "Usage: $0 {restore|upgrade|describe}"
esac