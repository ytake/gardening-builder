#!/usr/bin/env bash

sudo yum install -y expect
# for MSSQL
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo

expect -c "
spawn yum install -y mssql-tools unixODBC-devel
expect \"Do you accept the license terms? (Enter YES or NO)\" {
    send \"YES\n\"
    expect \"Do you accept the license terms? (Enter YES or NO)\"
    send \"YES\n\"
}
interact
"
