#!/usr/bin/expect
set timeout -1
spawn oxyromon {*}$argv
sleep 2
expect -re ".*Please select a ROM:.*" { send "\r" }
wait
