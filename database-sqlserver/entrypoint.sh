#!/bin/bash
set -eu

# Start the script to create the DB and user
/config/configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr