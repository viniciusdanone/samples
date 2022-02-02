#!/bin/bash
DATE=$(date +'%H-%M')
ENGINE_VERSION="5.7.36"
RDS_DESTINATION="chatlab-snapshot-primary"
RDS_SOURCE="chatlab-stg"
RDS_SNAPSHOT="upgrade-chatlab-stg"
RDS_SIZE="db.t2.small"

fn_snapshot_create (){
echo "Starting RDS snapshot $RDS_SNAPSHOT, wait and take a coffe..."    
time aws rds create-db-snapshot \
    --db-instance-identifier $RDS_SOURCE \
    --db-snapshot-identifier $RDS_SNAPSHOT
}

fn_snapshot_restore (){
echo "Starting restore from snampshot $RDS_SNAPSHOT, wait and take a coffe..."    
time aws rds restore-db-instance-from-db-snapshot \
    --engine mysql \
    --no-multi-az \
    --publicly-accessible \
    --db-instance-identifier $RDS_DESTINATION \
    --db-snapshot-identifier $RDS_SNAPSHOT \
    --db-instance-class $RDS_SIZE 
}

fn_instance_upgrade(){
echo "Starting upgrade and promotion instance $RDS_DESTINATION"
time aws rds modify-db-instance \
    --db-instance-identifier $RDS_DESTINATION \
    --backup-retention-period 7 \
    --allow-major-version-upgrade \
    --engine-version $ENGINE_VERSION \
    --apply-immediately
}

fn_instance_list(){
raws ds describe-db-instances \
    --db-instance-identifier $RDS_DESTINATION
}

case "$1" in
 'snapshot')
   fn_snapshot_create;;
 'restore')
   fn_snapshot_restore;;
 'upgrade')
   fn_instance_upgrade;;
 'describe')
   fn_instance_list;;
 *)
       echo "Usage: $0 {snapshot|restore|upgrade|describe}"
esac