#!/bin/bash

USER=$(whoami)
SSHUSER="yourname"
HOME="/home/$USER"
CHEFREPO="$HOME/src/chef-repo"
CONFIG="$HOME/.ssh/config"
SCRIPTS="$HOME/scripts"
PCIJUMP="pcijump"
JUMP="jump"

cd $CHEFREPO
PCILIST=$(knife search node "chef_environment:pabet_pciprod" | grep Name | cut -d " " -f 5 | cut -d "." -f 1 | tr '\n' ' ')
NONPCILIST=$(knife search node "NOT chef_environment:pabet_pciprod" | grep Name | cut -d " " -f 5 | cut -d "." -f 1 | tr '\n' ' ')

cat > $CONFIG << EOF
#Default all hosts to use $SSHUSER@$JUMP
Host *
  User $SSHUSER
EOF

echo "" >> $CONFIG
echo "#Hostlist to ssh through pci jumpbox" >> $CONFIG

for HOST in $PCILIST
do
  echo "Host $HOST" >> $CONFIG
  echo "  ProxyCommand ssh $PCIJUMP nc %h 22" >> $CONFIG
#  echo "" >> $CONFIG
done

echo "" >> $CONFIG
echo "#Hostlist to ssh through non-pci jumpbox" >> $CONFIG

for HOST in $NONPCILIST
do
  echo "Host $HOST" >> $CONFIG
  echo "  ProxyCommand ssh $JUMP nc %h 22" >> $CONFIG
#  echo "" >> $CONFIG
done
