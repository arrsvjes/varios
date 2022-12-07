#!/bin/bash
RNULL=/dev/null
TEMPUSERS=$(mktemp)
sudo groupadd techdocs 2>$RNULL
sudo useradd -m -d /home/tech1 -s /bin/bash tech1 2>$RNULL
sudo useradd -m -d /home/tech2 -s /bin/bash tech2 2>$RNULL
echo "tech1:d3b1an2022" > $TEMPUSERS
echo "tech2:d3b1an2022" >> $TEMPUSERS
cat $TEMPUSERS | sudo chpasswd
echo -e "\e[32mLaboratorio aprovisionado exitosamente\e[0m"
