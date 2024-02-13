#!/usr/bin/expect
set timeout -1
spawn oxyromon {*}$argv
expect -re ".*Please select a ROM:.*" { sleep 0.5; send "\r" }
