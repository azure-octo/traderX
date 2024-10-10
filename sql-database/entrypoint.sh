#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Start the script to create the DB and user
$SCRIPT_DIR/configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr