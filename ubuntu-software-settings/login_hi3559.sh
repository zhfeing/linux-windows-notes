#!/usr/bin/expect
set timeout 3600
spawn ssh root@10.214.211.29
expect "*password:"
send "hi3559\r"
expect "*#"
interact