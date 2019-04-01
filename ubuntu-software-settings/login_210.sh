#!/usr/bin/expect
set timeout 3600
spawn ssh zhf@10.214.29.112
expect "*password:"
send "zhf123\r"
expect "*vipa*"
interact
