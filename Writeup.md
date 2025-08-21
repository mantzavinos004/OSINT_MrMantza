![img](assets/banner.png)

<img src='assets/htb.png' style='zoom: 80%;' align=left /> <font size='10'><Challenge_Name></font>

1<sup>st</sup> August 2023

Prepared By: `athleticKid`

Challenge Author(s): `athleticKid`

Difficulty: <font color='orange'>Medium</font>

<br><br>

***





.
***

# Synopsis (!)

Players must enumerate a photograph and some logs in a file to find hidden files and directories in a static website, ultimately finding a secret path that contains sensitive information (or a flag).

## Description (!)

Players get a .jpg file (with hidden information embed) and logs.txt (a "large" fake logs) file. I addition, they get access to a static website. They have to use the .jpg file to find some information, maybe geo or some stenography, so they can use it to search in efficient way the logs. There they will find some clues about a hidden path to the website. Once they get there, they need to insert a secret key. They got it from the .jpg file. If its wrong, it should give them back some garbages, but if the key was correct, it should give them back the correct flag (i wanted something simple for this flag-key testing, so i just XOR it with a very big key (difficult to break it with brute-force). I also thought that a server-client configuration would be an overkill for this simple OSINT challenge).

## Skills Required (!)

- Basic web enumeration skills
- Researching Skills
- Basic logs analysis
- Know how to use steganographic tools

## Skills Learned (!)

- Learn Basic-Moderate OSINT techniques
- Learn how to analyze logs files

# Enumeration (!)


Analyze the source files as much as you can so it is clear what the challenge is about.
When a player unzips the .zip file, gets a photo .jpg and a logs.txt file.
Player has to analyze the photo for metadata and hidden steganographic informations. There are a lot of clues the player needs.

After gather some information the player needs to find the correct log to gather some more secrets! Someone could start with this, but as soos as he reach the hidden path in the website, he should have found the key from the photo steganography first.


# Solution (!)

1. First we need to search the photograph for metadata information.
   We could use the exiftool with this command:


   exiftool card_postal.jpg


<SNIP>

    GPS Satellites                  : 8
    Comment                         : clueless
    Image Width                     : 6016
    Image Height                    : 4016
    Encoding Process                : Baseline DCT, Huffman coding
    Bits Per Sample                 : 8
    Color Components                : 3
    Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
    Image Size                      : 6016x4016
    Megapixels                      : 24.2
    GPS Altitude                    : 147 m Above Sea Level
    GPS Latitude                    : 37 deg 59' 15.57" N
    GPS Longitude                   : 23 deg 44' 5.20" E
    GPS Position                    : 37 deg 59' 15.57" N, 23 deg 44' 5.20" E
</SNIP>

From those results we should keep this "Comment  :  clueless"

And the GPS cordinations. With a quick google maps search we can see that those cords are from Athens.

2. At this point we can search the logs.txt.
   It would be smart to use the "grep" to take only results from MrMantza and from Athens

   so we use: cat logs.txt | grep -A 5 -B 1 "MrMantza" logs.txt | grep -A 5 -B 5 "Athens"

   In one of those we can see a strange message:
   "The secret Hypertext Markup Language file is under the SUN and under the S3CR3T_D1R . Sssshh!"

   We could easily find out that in the path /SUN/S3CR3T_D1R is a secret.html file

3. We visit the path /SUN/S3CR3T_D1R/secret.html

   There is a submit field. We could try the clueless from the photo metadata, but we get garbages.

   It is common to use steganography to hide data into photographs!

   So we can use the tool steghide to extract hidden data from photo with password clueless:

   steghide extract -sf card_postal.jpg -p clueless

4. We take a secre.txt and open it:
<SNIP>

       cat secre.txt   --->  ATH3N5_M4NTZ4_2024_S3CR3T_K3Y

6. We insert this key in the submit field and finaly get the flag!

### Getting the flag (!)

A final summary of all that was said above:

1. exiftool card_postal.jpg
2. steghide extract -sf card_postal.jpg -p clueless
3. cat secret.txt
4. cat logs.txt | grep -A 5 -B 1 "MrMantza" logs.txt | grep -A 5 -B 5 "Athens"
5. submit the key and take the flag
