#!/bin/bash
#!/bin/bash
echo "-------------------------------------------------------------------------------------------------------------"
echo
if [ `id -u` -eq 0 ]; then
 clear
  echo
  echo "This script needs to be executed without 'su' privileges."
  echo "Login as normal user!"
  echo "Speed-to-fritz must be run as normal user as well!" 
  echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  sleep 10
  exit 0
fi
rm -fdr ./W920/speed-to-fritz
#sudo apt-get -y install subversion 
svn co https://freetzlinux.svn.sourceforge.net/svnroot/freetzlinux/trunk/W920/speed-to-fritz trunk/W920/speed-to-fritz
#cd trunk/speed-to-fritz
#./install-start
sleep 5
