#!/usr/bin/expect
set timeout -1
spawn oxyromon {*}$argv
sleep 2
while {1} { expect -re { ".*Please select a ROM:.*" { send "\r"; exp_continue } } }
wait
