

if you just want to use the site offline, skip to step 8.



this file explain how to build the "world english scripture" version out of the "world english bible".

the operating system used to build it is android, however, with a few directory name changes in the build files, the instructions should easily be adaptable to any linux distro that has bash and the required utilities (see list of required utilities in setup.sh).




overview:

there are 2 areas to place the files. everything should be in the Documents folder under a directory called "escripture", and the 3 short build files should be copied to a directory in termux. the directory name in termux doesn't matter, as long as the files are actually within termux, not just in normal android internal storage folders. executing "x" in termux does the following:
runs 1, which clears the directory and pulls in setup.sh and the "world english bible" source",
then runs setup.sh, which builds everything
then runs 3, which deletes old built files and copies the new ones

for more info, see:
https://wiki.termux.com/wiki/Internal_and_external_storage





step by step instructions:

1.
to build on android, first install termux from "f-droid.org". make sure to download and install the termux apk, not the f-droid app.


2.
in termux, install dependencies:
pkg install perl

if there are other dependencies that don't come with termux, or you are not using termux, or are having issues check the dependency list and make sure the dependencies are met. for example, i don't remember if termux has "unzip" by default. if it doesn't, install it.


3.
in termux, set up the ability to transfer files between "android internal storage" and "termux" by running:
ls
termux-setup-storage
ls


4.
download the zip of escripture from github (via the green button that says "code"), and extract the files to internal storage in the Documents folder in a folder called "escripture". for example, the path of "setup.sh" should be "Documents/escripture/setup.sh".


5.
note: when typing these directory names, you may type the first few (like 3) characters and press tab for auto-complete.
copy 3 files to termux:
in termux, run:
ls
mkdir word
ls
cd storage
cd shared
cd Documents
cd escripture
cd termux-build
cp 1 3 x ~/word


6.
prepare to execute. in termux, run:
cd
cd word
ls
chmod +x 1 3 x


7.
execute.
in termux, while in the "word" directory run:
./x

if it works, it will finish by saying "3 done". if that message does not appear, the build was not successful! example:
1 done
Processing............................ Done.
3 done

if the build it was successful, then Documents/escripture/book and Documents/escripture/usfm should both be populated with a fresh build of books. if no changes were made to setup.sh, then this will have overwritten exactly the same files as the ones that were there. if you perform this process and compare it with a fresh download (by using "diff", for example), you can verify that the text conforms exactly to the code, and that no undisclosed alterations were made. in this way, you can analyze the difference between this translation and its source text by reviewing the code instead of having to read and compare all of the text.



8.
use the finished product.

for quick and easy access, simply open the html file of the book of your choice in a browser.

on android, i prefer opening index.html with acode 1.4.164, and running it by pressing play, which loads the local site in a browser. later versions of acode require setting up a directory to use (which would be "Documents/escripture"), and then loading the index.html file and running it.

you can browse the full site offline using any web server software you want, such as apache or nginx. each book's html file is designed to be readable without running web server software, or needing any other files, but the experience is best when running web server software (including acode).





additional notes:

the usfm files are intended to be used by a software expert or advanced user. they can be converted into various formats to be used in scripture software such as "and bible" or "e-sword" and many other scripture reading applications.





