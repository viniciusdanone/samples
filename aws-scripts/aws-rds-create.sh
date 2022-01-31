#!/bin/bash
NEW_VERSION="5-7-01"
RDS_DESTINATION="chatlab-migration-primary"
RDS_SOURCE="chatlab-stg-read"
RDS_SNAPSHOT="rds:chatlab-stg-2022-01-30-23-07"
RDS_SIZE="db.t2.small"

aws rds restore-db-instance-from-db-snapshot \
    --db-instance-identifier $RDS_DESTINATION \
    --db-snapshot-identifier $RDS_SNAPSHOT \
    --publicly-accessible \
    --db-instance-class $RDS_SIZE --dry-run


#aws rds describe-db-snapshots --db-snapshot-identifier rds:chatlab-stg-2022-01-30-23-07 