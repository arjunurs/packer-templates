#!/bin/bash -x

echo "Running: useradd -m -d /home/$NEWUSERLOGIN -c $NEWUSERFULLNAME -s /bin/bash -r -U $NEWUSERLOGIN"
useradd -m -d /home/$NEWUSERLOGIN -c "$NEWUSERFULLNAME" -s /bin/bash -U $NEWUSERLOGIN
echo "Done.."

echo "Running: usermod -g $NEWUSERLOGIN $NEWUSERLOGIN"
usermod -g $NEWUSERLOGIN $NEWUSERLOGIN
echo "Done.."

echo "Setting up passwordless sudo for $NEWUSERLOGIN"
echo "$NEWUSERLOGIN ALL=(ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/$NEWUSERLOGIN" &>/dev/null
echo "Done.."

echo "Setting password for $NEWUSERLOGIN"
echo "$NEWUSERLOGIN:vagrant" | chpasswd
echo "Done.."

echo "Doing echo $AWS_ACCESS_KEY_ID > /home/$NEWUSERLOGIN/.awssecret"
echo $AWS_ACCESS_KEY_ID > /home/$NEWUSERLOGIN/.awssecret
echo "Done.."

echo "Doing $AWS_SECRET_ACCESS_KEY >> /home/$NEWUSERLOGIN/.awssecret"
echo $AWS_SECRET_ACCESS_KEY >> /home/$NEWUSERLOGIN/.awssecret # note >> for append
echo "Done.."

echo "Doing echo -ne $AZURE_SECRET > /home/$NEWUSERLOGIN/.azuresecret"
echo -ne $AZURE_SECRET > /home/$NEWUSERLOGIN/.azuresecret
echo "Done.."

echo "Doing chmod 600 /home/$NEWUSERLOGIN/.azuresecret"
chmod 600 /home/$NEWUSERLOGIN/.azuresecret
echo "Done.."

echo "Doing chown $NEWUSERLOGIN:$NEWUSERLOGIN /home/$NEWUSERLOGIN/.azuresecret"
chown $NEWUSERLOGIN:$NEWUSERLOGIN /home/$NEWUSERLOGIN/.azuresecret
echo "Done.."

echo "Doing chown $NEWUSERLOGIN:$NEWUSERLOGIN /home/$NEWUSERLOGIN/.awssecret"
chown $NEWUSERLOGIN:$NEWUSERLOGIN /home/$NEWUSERLOGIN/.awssecret
echo "Done.."

echo "Creating ssh keys for $NEWUSERLOGIN"
su -l $NEWUSERLOGIN -c 'ssh-keygen -f ~/.ssh/id_rsa -N ""'
echo "Done.."

echo "Setting up ~/.ssh/config for $NEWUSERLOGIN"
echo -e "\nHost $SVN_SERVER_URL svn1 svn\n  User=$NEWUSERLOGIN" >> /home/$NEWUSERLOGIN/.ssh/config
echo "Done.."

echo "Set up Publickey based ssh login to self"
cat /home/$NEWUSERLOGIN/.ssh/id_rsa.pub >> /home/$NEWUSERLOGIN/.ssh/authorized_keys
echo "Done.."


echo "User \"$NEWUSERLOGIN\" with full name \"$NEWUSERFULLNAME\" created successfully"
