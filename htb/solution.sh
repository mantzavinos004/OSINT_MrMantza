#!/bin/bash

#step 1 
exiftool card_postal.jpg
# you found: clueless in command session and gps cords from Athens

#step 2
steghide extract -sf card_postal.jpg -p clueless
# and you get a secret.txt

#step 3
cat secret.txt
#you found a big keyphrase

#step 4
cat logs.txt| grep -A 5 -B 1 "MrMantza" logs.txt | grep -A 5 -B 5 "Athens"
# You found a secret path in a log: /SUN/S3CR3T_D1R/secret.html

#step 5: submit the key to the field and get the flag:)
