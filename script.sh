#!/bin/bash

DIR_NAMES="publico adm ven sec"
GRP_NAMES="GRP_ADM GRP_VEN GRP_SEC"
ADM_USER_NAMES="carlos maria"
VEN_USER_NAMES="debora sebastiana"
SEC_USER_NAMES="josefina amanda"

echo "Initializing the process..."

# Create group
echo "Creating the groups"
for group in $GRP_NAMES
do
    groupadd $group
done

# Create directory
echo "Creating the directories"
for dir in $DIR_NAMES
do
    if [ "$dir" = "publico" ]
    then
        mkdir /$dir
        chmod 777 /$dir
    else
        mkdir /$dir
        chmod 770 /$dir
        
        if [ "$dir" == "adm" ]
        then
            chown root:GRP_ADM /$dir
        elif [ "$dir" == "ven" ]
        then 
            chown root:GRP_VEN /$dir
        else
            chown root:GRP_SEC /$dir
        fi
    fi
done

echo "Creating users for each group"
# Create user for adm group
for user in $ADM_USER_NAMES
do
    useradd -m -s /bin/bash -G GRP_ADM -p $(openssl passwd -crypt user1234) $user
done

# Create user for ven group
for user in $VEN_USER_NAMES
do
    useradd -m -s /bin/bash -G GRP_VEN -p $(openssl passwd -crypt user1234) $user
done

# Create user for sec group
for user in $SEC_USER_NAMES
do
    useradd -m -s /bin/bash -G GRP_SEC -p $(openssl passwd -crypt user1234) $user
done

echo "Done!!!"
