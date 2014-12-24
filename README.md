chef-ssh-config-update
================
If you require to jump through different hosts to reach your destination, this script can query your chef server and update your ~/.ssh/config file to jump through a specific host to reach separate environments.

Requirements
------------
bash, cut, tr

Usage
-----
./sshConfigUpdate.sh

 - Update the variables at the top of the script.
 - Update the name of your chef-environment as needed (it is probably different).
