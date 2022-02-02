#!/usr/bin/expect
set timeout -1
set install_dir [lindex $argv 1]
set installer [lindex $argv 0]

spawn $installer $install_dir
set timeout 2
expect {
    "ERROR: Invalid options:" {spawn $installer -d $install_dir }
    timeout { }
}

set timeout 600
expect "Press Enter to display the license agreements"
send "\r"
set timeout 2

expect {
    "* >*" {send "y\r"}
    timeout { send "q"; sleep 1; exp_continue}
}
expect {
    "* >*" {send "y\r"}
    timeout { send "q"; sleep 1; exp_continue}
}
expect {
    "*Installing PetaLinux...*" {}
    "* >*" {send "y\r"}
    timeout { send "q"; sleep 1; exp_continue}
}

set timeout -1
expect "INFO: Checking PetaLinux installer integrity..."
expect "INFO: PetaLinux SDK has been installed"
#interact
