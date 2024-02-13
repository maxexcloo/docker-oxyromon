#!/usr/bin/expect
set timeout -1
spawn oxyromon {*}$argv
sleep 2
while {1} { expect -re { ".*Please select a ROM:.*" { sleep 0.2; send "\r" } } }
wait
