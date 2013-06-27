#!/bin/bash

if [ -z $1 ];then
    echo "USAGE: $0 user@hostname"
    exit
fi


KEY="$HOME/.ssh/id_rsa.pub"

# Create keys if they don't exist
if [ ! -f $KEY ]; then
	echo "private key not found at $KEY"
	echo "creating new keypair"
	ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_rsa -N ""
fi

if [ ! -f $KEY ]; then
        echo "private key STILL not found at $KEY"
        echo "since it should exist by now, we're going to exit"
	exit
fi

echo "Putting your key on $1... "

KEYCODE=`cat $KEY`
ssh -q $1 "mkdir ~/.ssh 2>/dev/null; chmod 700 ~/.ssh; echo "$KEYCODE" >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys"

echo "done!"

