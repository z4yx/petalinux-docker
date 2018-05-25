#!/usr/bin/env expect
set timeout -1
set install_dir [lindex $argv 1]
set installer [lindex $argv 0]

spawn $installer $install_dir
expect "Press Enter to display the license agreements"
send "\r"
set timeout 4

expect {
    "* >*" {send "y\r"}
    timeout { send "q"; exp_continue}
}
expect {
    "* >*" {send "y\r"}
    timeout { send "q"; exp_continue}
}
expect {
    "* >*" {send "y\r"}
    timeout { send "q"; exp_continue}
}
interact
