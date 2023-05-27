#!/bin/bash
set -e

# ------------------------------------------------------------------------------
# SCRIPTURE PROGRAM
# revise the world english bible (web)
# convert USFM formatted scripture files into HTML
#
# stages:
#   * book selection & renaming
#     usfm format editing
#     usfm whitespace cleanup
#     unofficial typo corrections
#   * specific translation revisions
#   * bulk translation revisions
#     convert usfm to html
#
# * stages which truly change the text, not just minor corrections like typos
# ------------------------------------------------------------------------------

# program information
# ------------------------------------------------------------------------------
# REQUIREMENTS:
#   FILES:
#     eng-web_usfm.zip (scripture source file)
#       the 2023-04-28 version generated from source files dated 2023-04-27
#       version info found on the copr.htm page from the zip
#       source info page: https://ebible.org/find/details.php?id=eng-web
#       source file: https://ebible.org/Scriptures/eng-web_usfm.zip
#       changelog: https://ebible.org/Scriptures/changelog.txt
#     setup.sh (this file)
#     index.html (optional)
#     style.css (optional)
#     caslon.ttf (optional)

#   ENVIRONMENT:
#     a linux bash shell with GNU coreutils:
#       GNU bash 5.2.2
#       UnZip 6.00
#       perl v5.36.0
#       sed 4.8
#       grep 3.8
#       cut 9.1
#       xargs 4.9.0
#       cat 9.1
#     an http server (optional)

# INSTRUCTIONS
# 1. rename eng-web_usfm.zip to eng-web_usfm-source2023-04-27.zip
#      (or edit that line just below).
# 2. run setup.sh (this file) in clean directory that also has eng-web_usfm.zip
# 3. (optional) copy all html files to a subdirectory named "book"
# 4. (optional) make sure index.html, style.css, and caslon.ttf, are
#      in the parent directory of the "book" directory
# the site should now be ready. use an http server to view the site.



# ------------------------------------------------------------------------------
# BOOK SELECTION & RENAMING
# books will be selected, the collection name changed, and books renamed
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# extract

printf 'Processing'

# unzip and discard unnecessary files
unzip -q 'eng-web_usfm-source2023-04-27.zip'
rm copr.htm gentiumplus.css keys.asc signature.txt.asc
printf .



# ------------------------------------------------------------------------------
# remove books

# remove preface and glossary
rm -f 00*.usfm 106*.usfm

# remove paul's letters
rm *ROM*.usfm *1CO*.usfm *2CO*.usfm *GAL*.usfm *EPH*.usfm *PHP*.usfm *COL*.usfm *1TH*.usfm *2TH*.usfm *1TI*.usfm *2TI*.usfm *TIT*.usfm *PHM*.usfm

# remove book that conveys paul's sayings
rm *ACT*.usfm

# remove book by author of acts, written to same person
rm *LUK*.usfm

# remove text perhaps by barnabas, paul's associate
rm *HEB*.usfm

# remove text considered pseudopigraphical
rm *2PE*.usfm

# remove book that appears loosely associated with paul, perhaps from rome.
# the decision to remove this book might be undone if it is proven trustworthy.
rm *MRK*.usfm

# remove apocrypha
# a critical examination of the apocrypha is outside the scope of this project
rm -f 41*.usfm 42*.usfm 43*.usfm 45*.usfm 46*.usfm 47*.usfm
rm -f 5*.usfm 6*.usfm
printf .



# ------------------------------------------------------------------------------
# developer option


# # remove unlisted books for faster testing
# rm *PRO*.usfm
# rm *SNG*.usfm
# rm *RUT*.usfm
# rm *LAM*.usfm
# rm *ECC*.usfm
# rm *EST*.usfm
# rm *EZR*.usfm
# rm *NEH*.usfm
# rm *1CH*.usfm
# rm *2CH*.usfm

# rm *JAS*.usfm
# rm *1PE*.usfm
# rm *1JN*.usfm
# rm *2JN*.usfm
# rm *3JN*.usfm
# rm *JUD*.usfm



# ------------------------------------------------------------------------------
# rename collection

# rename this collection of books
sed -i 's/\\id \(...\).*/\\id \1 World English Scripture (WES)/' *.usfm
printf .



# ------------------------------------------------------------------------------
# rename files

# use full book name, all lowecase, to be used as html page name later
mv 02-GENeng-web.usfm genesis.usfm
mv 03-EXOeng-web.usfm exodus.usfm
mv 04-LEVeng-web.usfm leviticus.usfm
mv 05-NUMeng-web.usfm numbers.usfm
mv 06-DEUeng-web.usfm deuteronomy.usfm

mv 07-JOSeng-web.usfm joshua.usfm
mv 08-JDGeng-web.usfm judges.usfm
mv 10-1SAeng-web.usfm 1samuel.usfm
mv 11-2SAeng-web.usfm 2samuel.usfm
mv 12-1KIeng-web.usfm 1kings.usfm
mv 13-2KIeng-web.usfm 2kings.usfm

mv 24-ISAeng-web.usfm isaiah.usfm
mv 25-JEReng-web.usfm jeremiah.usfm
mv 27-EZKeng-web.usfm ezekiel.usfm

mv 28-DANeng-web.usfm daniel.usfm
mv 29-HOSeng-web.usfm hosea.usfm
mv 30-JOLeng-web.usfm joel.usfm
mv 31-AMOeng-web.usfm amos.usfm
mv 32-OBAeng-web.usfm obadiah.usfm
mv 33-JONeng-web.usfm jonah.usfm
mv 34-MICeng-web.usfm micah.usfm
mv 35-NAMeng-web.usfm nahum.usfm
mv 36-HABeng-web.usfm habakkuk.usfm
mv 37-ZEPeng-web.usfm zephaniah.usfm
mv 38-HAGeng-web.usfm haggai.usfm
mv 39-ZECeng-web.usfm zechariah.usfm
mv 40-MALeng-web.usfm malachi.usfm

mv 20-PSAeng-web.usfm psalms.usfm
mv 19-JOBeng-web.usfm job.usfm

mv 70-MATeng-web.usfm matthew.usfm
mv 73-JHNeng-web.usfm john.usfm
mv 96-REVeng-web.usfm revelation.usfm
printf .

# rename extra books not necessarily listed, but maybe available
mv 09-RUTeng-web.usfm ruth.usfm
mv 14-1CHeng-web.usfm 1chronicles.usfm
mv 15-2CHeng-web.usfm 2chronicles.usfm
mv 16-EZReng-web.usfm ezra.usfm
mv 17-NEHeng-web.usfm nehemiah.usfm
mv 18-ESTeng-web.usfm esther.usfm
mv 21-PROeng-web.usfm proverbs.usfm
mv 22-ECCeng-web.usfm ecclesiastes.usfm
mv 23-SNGeng-web.usfm songofsolomon.usfm
mv 26-LAMeng-web.usfm lamentations.usfm

mv 89-JASeng-web.usfm james.usfm
mv 90-1PEeng-web.usfm 1peter.usfm
mv 92-1JNeng-web.usfm 1john.usfm
mv 93-2JNeng-web.usfm 2john.usfm
mv 94-3JNeng-web.usfm 3john.usfm
mv 95-JUDeng-web.usfm jude.usfm
printf .



# ------------------------------------------------------------------------------
# rename books

# use classic name "Song of Songs" instead of "Song of Solomon"
mv songofsolomon.usfm songofsongs.usfm
sed -i 's/Song of Solomon/Song of Songs/' songofsongs.usfm

# since "2 Peter" is out, use title "Peter" instead of "1 Peter"
mv 1peter.usfm peter.usfm
sed -i 's/\\id 1PE/\\id PET/' peter.usfm
sed -i 's/\\h 1 Peter/\\h Peter/' peter.usfm
sed -i 's/\\toc1 Peter’s First Letter/\\toc1 The Letter from Peter/' peter.usfm
sed -i 's/\\toc2 1 Peter/\\toc2 Peter/' peter.usfm
sed -i 's/\\toc3 1 Peter/\\toc3 Peter/' peter.usfm
sed -i 's/\\mt1 Peter’s First Letter/\\mt1 The Letter from Peter/' peter.usfm
printf .



# ------------------------------------------------------------------------------
# USFM FORMAT EDITING
# formatting will be changed. the main text should not be edited here
# ------------------------------------------------------------------------------

# strip strongs numbering
# as of 2023-05-05, the strongs numbers provided are WAY off, like random
sed -i 's/\\w //g' *.usfm
sed -i 's/\\+w //g' *.usfm
sed -i 's/|strong="....."\\w\*//g' *.usfm
sed -i 's/|strong="....."\\+w\*//g' *.usfm
printf .

# strip blank lines. an optional aspect of formatting.
# the \b is not in all the places it should be, like right before gen49.28
# and they are somewhat unconventional for books but do appear in some bibles.
# the different paragraph styles may provide for this kind of spacing anyway.
#sed -i '/\\b/d' *.usfm

# this isn't just a blank line but is used as a container like paragraph
# it gives a half-height blank line above it, depending on css
#sed -i '/\\nb/d' *.usfm

# strip footnotes and cross-references
#perl -i -pe 's/\\f .*?\\f\*//g' *.usfm
#perl -i -pe 's/\\x .*?\\x\*//g' *.usfm
#printf .

# strip wj markers
#sed -i 's/\\wj //g' *.usfm
#sed -i 's/\\wj\*//g' *.usfm
#printf .



# strip extra titles
sed -i '/\\toc1/d' *.usfm
sed -i '/\\toc2/d' *.usfm
sed -i '/\\toc3/d' *.usfm
sed -i '/\\mt1/d' *.usfm
sed -i '/\\mt2/d' *.usfm
sed -i '/\\mt3/d' *.usfm
printf .









# ------------------------------------------------------------------------------
# USFM WHITESPACE CLEANUP
# in this section, usfm code will be cleaned to improve usfm quality.
# no editing decisions (format or text) should be done here.
# this is done to fix formatting problems when omitting verse numbers,
# and other reasons noted below.
# it is also done just to have cleaner usfm and html code.
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# heading and chapter spacing

# clean whitespace around heading name
# also works if it has spaces such as "Song of Songs" or "2 Kings"
for f in *.usfm; do
# xargs trims whitespace, leaving multiple words separated by 1 space
h=$(grep '\\h ' $f | cut -c 4- | xargs)
# use shell expansion for variable only, or \\ becomes \
sed -i 's/\\h .*/\\h '"$h"'/' $f
done

# clean whitespace around chapter number
# match \c and 1 or more spaces, number, etc. return \c number
sed -i 's/\\c \+\([0-9]\+\).*/\\c \1/' *.usfm
printf .



# ------------------------------------------------------------------------------
# em dash spacing
# for books, em dashes should not have spaces next to them
# this makes that rule more consistent
# this is difficult to enforce. more testing might be good.

# remove space at end of line when next verse starts with em dash
# only known occurrence is lev 4:11-4:12
perl -i -p0e 's/ \n\\v ([0-9]+) —/\\v \1 —/gs' *.usfm

# remove any space and newline after em dash. newline is space when viewed
perl -i -p0e 's/— *\n/—/gs' *.usfm

# remove space next to em dash, for when it occurs mid-line
sed -i 's/— /—/g' *.usfm



# remove any spaces and linebreaks after Selah— at end of line,
# in case it's put in-line

# only known occurrence is psa 68:32

# part 1
perl -i -p0e 's/—\\qs\* *\n/—\\qs\*/' *.usfm

# part 2: this fixes the last check because there were 2 linebreaks
perl -i -p0e 's/—\\qs\*\\q1\n/—\\qs\*\\q1 /' *.usfm






# alternative: place spaces around em dashes
# this format is much easier to implement
# insert a space after each em dash, if there isn't one already
#sed -i 's/—\([^ ]\)/— \1/g' *.usfm
# insert a space before each em dash, if there isn't one already
#sed -i 's/\([^ ]\)—/\1 —/g' *.usfm



# ------------------------------------------------------------------------------
# psalm book cleanup

sed -i 's/\\ms1 \([A-Za-z]* [0-9]\+\) *$/\\ms1 \1/g' psalms.usfm


# ------------------------------------------------------------------------------
# quote spacing

# space-out apostrophes with non-breaking space. USFM COMPATIBILITY UNTESTED.
# opens
sed -i 's/“‘/“ ‘/g' *.usfm
sed -i 's/‘“/‘ “/g' *.usfm
# closes
sed -i 's/’”/’ ”/g' *.usfm
sed -i 's/”’/” ’/g' *.usfm
# fix one occurrence
sed -i 's/’\\wj\*”/’\\wj\* ”/' *.usfm



# ------------------------------------------------------------------------------
# avoid two spaces

# reduce two adjacent spaces to just one space
sed -i 's/  / /g' *.usfm






# ------------------------------------------------------------------------------
# UNOFFICIAL TYPO CORRECTIONS
# fix issues upstream should fix
# depends on single character (nbsp) inserted between quotes
# ------------------------------------------------------------------------------



# misplaced quotation mark in matthew 19:5 and many other places
# the question mark is inside the inner quote, but i think it should be outside the inner quote in this case, because the inner quotation itself is not a question, but rather the question is the messiah's.
# i expect this issue to be resolved in the WEB distribution soon, but until then, this will fix it. after it's fixed, this code should be harmless.

# question mark placement before curly close single quote
# (40 sed's. 2 sed's fix 2 verses, and 2 verses have 2 sed's each)

# 1ki 1:24
sed -i 's/sit on my throne?’/sit on my throne’?/' 1kings.usfm

# 1ki 2:42
sed -i 's/shall surely die?’/shall surely die’?/' 1kings.usfm

# 1ki 12:9 and 2ch 10:9
sed -i 's/on us lighter?’.”/on us lighter’?”/g' *.usfm

# 1sa 21:11, 29:5
sed -i 's/David his ten thousands?’.”/David his ten thousands’?”/g' 1samuel.usfm

# 1sa 24:9
sed -i 's/David seeks to harm you?’/David seeks to harm you’?/' 1samuel.usfm

# 2ch 32:11
sed -i 's/king of Assyria?’/king of Assyria’?/' 2chronicles.usfm

# 2ch 32:12
sed -i 's/incense on it?’/incense on it’?/' 2chronicles.usfm

# 2ki 2:18
sed -i 's/Didn’t I tell you, ‘Don’t go?’./Didn’t I tell you, ‘Don’t go’?/' 2kings.usfm

# 2ki 5:13
sed -i 's/Wash, and be clean?’./Wash, and be clean’?/' 2kings.usfm

# 2ki 18:22
sed -i 's/altar in Jerusalem?’/altar in Jerusalem’?/' 2kings.usfm

# exo 14:12
sed -i 's/serve the Egyptians?’/serve the Egyptians’?/' exodus.usfm

# exo 32:12
sed -i 's/surface of the earth?’/surface of the earth’?/' exodus.usfm

# eze 12:22
sed -i 's/every vision fails?’/every vision fails’?/' ezekiel.usfm

# gen 26:9
sed -i 's/She is my sister?’.”/She is my sister’?”/' genesis.usfm

# gen 43:7
sed -i 's/Bring your brother down?’.”/Bring your brother down’?”/' genesis.usfm

# isa 36:7
sed -i 's/before this altar?’.”/before this altar’?”/' isaiah.usfm

# isa 41:26
sed -i 's/He is right?’/He is right’?/' isaiah.usfm

# jer 26:9
sed -i 's/without inhabitant?’.”/without inhabitant’?”/' jeremiah.usfm

# SAME ISSUE AS OTHERS PLUS SPECIAL CASE OF WRONG NESTING.
# FOR HTML: REMEMBER TO USE NBSP (NON-BREAKING SPACE) BETWEEN QUOTE MARKS!
# OTHER VERSES IN THIS PARAGRAPH AGREE WITH THE CORRECTED FORM (NOT CURRENT FORM)
# jer 36:29
sed -i 's/“Why have you written therein, saying, ‘The king of Babylon will certainly come and destroy this land, and will cause to cease from there man and animal?’.”.’/‘Why have you written therein, saying, “The king of Babylon will certainly come and destroy this land, and will cause to cease from there man and animal”?’ ”/' jeremiah.usfm

# jer 37:19
sed -i 's/against this land?’/against this land’?/' jeremiah.usfm

# job 6:22 (1 of 2)
sed -i 's/Give to me?’/Give to me’?/' job.usfm

# job 6:22 (2 of 2)
sed -i 's/from your substance?’/from your substance’?/' job.usfm

# job 6:23 (1 of 2)
sed -i 's/adversary’s hand?’/adversary’s hand’?/' job.usfm

# job 6:23 (2 of 2)
sed -i 's/of the oppressors?’/of the oppressors’?/' job.usfm

# job 36:23
sed -i 's/have committed unrighteousness?’/have committed unrighteousness’?/' job.usfm

# joh 4:35
sed -i 's/until the harvest?’/until the harvest’?/' john.usfm

# joh 6:42
sed -i 's/out of heaven?’./out of heaven’?/' john.usfm

# joh 10:34
sed -i 's/you are gods?’/you are gods’?/' john.usfm

# joh 10:36
sed -i 's/am the Son of God?’/am the Son of God’?/' john.usfm

# joh 12:27
sed -i 's/save me from this time?’/save me from this time’?/' john.usfm

# joh 12:34
sed -i 's/must be lifted up?’/must be lifted up’?/' john.usfm

# joh 14:9
sed -i 's/Show us the Father?’/Show us the Father’?/' john.usfm

# joh 16:19
sed -i 's/you will see me?’/you will see me’?/' john.usfm

# mat 9:5
sed -i 's/Get up, and walk?’/Get up, and walk’?/' matthew.usfm

# matthew 19:5
sed -i 's/become one flesh?’/become one flesh’?/' matthew.usfm

# mat 21:16
sed -i 's/perfected praise?’.”/perfected praise’?”/' matthew.usfm

# mat 22:32
sed -i 's/the God of Jacob?’/the God of Jacob’?/' matthew.usfm

# SHOULD BE JUST A PERIOD, NOT A QUESTION MARK
# mat 23:18
sed -i 's/he is obligated?’/he is obligated\.’/' matthew.usfm

# num 11:12
sed -i 's/to their fathers?’/to their fathers’?/' numbers.usfm

# num 23:26
sed -i 's/that I must do?’.”/that I must do’?”/' numbers.usfm

printf .


# question mark and close curly double quote (9 ISSUES)
# grep -l ?” *.usfml
# (39 books of 48 with at least 1 occurrence)

# 1ki 1:13
sed -i 's/on my throne?”/on my throne”?/' 1kings.usfm

# ecc 1:10
sed -i 's/this is new?”/this is new”?/' ecclesiastes.usfm

# isa 19:11
sed -i 's/of ancient kings?”/of ancient kings”?/' isaiah.usfm

# isa 29:16
sed -i 's/He has no understanding?”/He has no understanding”?/' isaiah.usfm

# isa 40:27
sed -i 's/disregarded by my God?”/disregarded by my God”?/' isaiah.usfm

# jer 8:8
sed -i 's/law is with us?”/law is with us”?/' jeremiah.usfm

# jer 32:5
sed -i 's/will not prosper?”.’.”/will not prosper” ’?”/' jeremiah.usfm

# pro 20:9
sed -i 's/and without sin?”/and without sin”?/' proverbs.usfm

# psa 10:13
sed -i 's/me into account?”/me into account”?/' psalms.usfm

# add missed quotation marks
# add closing mark
# Jeremiah 21:14
sed -i 's/fruit of your doings, says Yahweh;/fruit of your doings,’ says Yahweh;/' jeremiah.usfm
# add opening mark
sed -i 's/and I will kindle a fire in her forest/‘and I will kindle a fire in her forest/' jeremiah.usfm

printf .



# ------------------------------------------------------------------------------
# TRANSLATION REVISIONS
# attempt to restore scripture and improve translation
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# USE LXX DATES FOR GENESIS 5 and 11 CHRONOLOGY

# See: Henry B. Smith Jr., The case for the Septuagint's chronology in
# Genesis 5 and Genesis 11, 2018.

# edit ages from masoretic to septuagint record, in general.
# follow Henry B. Smith Jr's proposal precisely.

# the following site has a similar method:
# https://www.bible.ca/manuscripts/Bible-chronology-charts-age-of-earth-date-Genesis-5-11-Septuagint-text-LXX-original-autograph-corrupted-Masoretic-MT-primeval-5554BC.htm



# genesis 5:3
sed -i 's/Adam lived one hundred thirty years/Adam lived two hundred thirty years/' genesis.usfm

# genesis 5:4
sed -i 's/Adam after he became the father of Seth were eight hundred years/Adam after he became the father of Seth were seven hundred years/' genesis.usfm



# genesis 5:6
sed -i 's/Seth lived one hundred five years, then became the father of Enosh/Seth lived two hundred five years, then became the father of Enosh/' genesis.usfm

# genesis 5:7
sed -i 's/Seth lived after he became the father of Enosh eight hundred seven years/Seth lived after he became the father of Enosh seven hundred seven years/' genesis.usfm



# genesis 5:9
sed -i 's/Enosh lived ninety years, and became the father of Kenan/Enosh lived one hundred ninety years, and became the father of Kenan/' genesis.usfm

# genesis 5:10
sed -i 's/Enosh lived after he became the father of Kenan eight hundred fifteen years/Enosh lived after he became the father of Kenan seven hundred fifteen years/' genesis.usfm



# genesis 5:12
sed -i 's/Kenan lived seventy years, then became the father of Mahalalel/Kenan lived one hundred seventy years, then became the father of Mahalalel/' genesis.usfm

# genesis 5:13
sed -i 's/Kenan lived after he became the father of Mahalalel eight hundred forty years/Kenan lived after he became the father of Mahalalel seven hundred forty years/' genesis.usfm



# genesis 5:15
sed -i 's/Mahalalel lived sixty-five years, then became the father of Jared/Mahalalel lived one hundred sixty-five years, then became the father of Jared/' genesis.usfm

# genesis 5:16
sed -i 's/Mahalalel lived after he became the father of Jared eight hundred thirty years/Mahalalel lived after he became the father of Jared seven hundred thirty years/' genesis.usfm



# genesis 5:21
sed -i 's/Enoch lived sixty-five years, then became the father of Methuselah/Enoch lived one hundred sixty-five years, then became the father of Methuselah/' genesis.usfm

# genesis 5:22
sed -i 's/After Methuselah’s birth, Enoch walked with God for three hundred years/After Methuselah’s birth, Enoch walked with God for two hundred years/' genesis.usfm





# genesis 5:25
# 187  mt
# 187  lxx vaticanus w/ uncials brooke 1906 cambridge
# 187  lxx interlinear pdf
# 167  lxx nets 2007 based on wevers 1974 & 1993
# 167  lxx brenton 1851

# methuselah's begetting age for lamech is arguably 187, not 167.
# https://www.bible.ca/manuscripts/Book-of-Genesis5-25-Methuselah-begetting-Age-Lamech-187-167-years-Bible-Manuscript-Textual-Variants-Old-Testament-Septuagint-LXX-Masoretic-MT-scribal-gloss-error.htm

# this file shows 187 in lxx:
# https://archive.org/details/InterlinearGreekEnglishSeptuagintOldTestamentPrint/mode/1up

# 167 is attributed to scribal error.
# also(?), if it were 167, then methuselah survived 14 years after the flood.
# (or is this the sole reason they considered there to be a scribal error?)

# no change
# Methuselah lived one hundred eighty-seven years, then became the father of Lamech





# genesis 5:28

# 182  mt
# 188  lxx brenton 1851
# 188  lxx vaticanus brooke 1906
# 188  lxx pdf
# 188  lxx nets

# Lamech’s age when Noah was born is arguably 182, not 188. why?
# only reference is bible.ca noted at the beginning of this section.

# if methuselah was 187 when lamech was born, then:
#   182 would mean methuselah died the year of the flood
#   188 would mean methuselah died 6 years before the flood

# no change
# Lamech lived one hundred eighty-two years, then became the father of a son

# henry smith's paper propses mt here, so no change
# genesis 5:30
# sed -i 's/Lamech lived after he became the father of Noah five hundred ninety-five years/Lamech lived after he became the father of Noah five hundred sixty-five years/' genesis.usfm

# genesis 5:31
# sed -i 's/All the days of Lamech were seven hundred seventy-seven years/All the days of Lamech were seven hundred fifty-three years/' genesis.usfm

printf .




# restoring cainan

# Genesis 10:24
sed -i 's/Arpachshad became the father of Shelah/Arpachshad became the father of Cainan\. Cainan became the father of Shelah/' genesis.usfm





# deprecated logic (henry smith's paper overrules):
# according to the following answer, early lxx manuscripts don't have cainan, son of arpachshad. thus, perhaps cainan was added to conform to luke, which in turn may have been corrupted in order to have groups of 7 generations culminating in jesus being 77th from adam.
# https://hermeneutics.stackexchange.com/questions/26768/are-there-any-manuscripts-that-confirm-genealogy-in-the-septuagints-genesis-5
# also, the ages for cainan are not unique, which supports the above theory: cainan's ages are 130 and 330, identical to shelah's. it seems cainan was injected, and shelah's ages were copied.
# (the ages are unique by henry smith's account)

#sed -i 's/Arpachshad lived thirty-five years and became the father of Shelah/Arpachshad lived one hundred thirty-five years and became the father of Shelah/' genesis.usfm
# genesis 11:12
sed -i 's/Arpachshad lived thirty-five years and became the father of Shelah/Arpachshad lived one hundred thirty-five years and became the father of Cainan/' genesis.usfm





# VERY DIFFICULT: writing in WEB (masoretic) style, recreating this verse from lxx
# masoretic/web uses "then he died", instead if "and he died" like in lxx.
# but.. the list in chapter 11 never uses either phrase, so i will recreate based on that structure.

# do add kainan/cainan son of arpachshad
# genesis 11:13
sed -i 's/Arpachshad lived four hundred three years after he became the father of Shelah, and became the father of more sons and daughters/Arpachshad lived four hundred thirty years after he became the father of Cainan, and became the father of more sons and daughters\. Cainan lived one hundred thirty years, and became the father of Shelah\. Cainan lived three hundred thirty years after he became the father of Shelah, and became the father of more sons and daughters/' genesis.usfm

# do not add cainan (do not recreate anything). easier, but not using this translation because it is easier.
#sed -i 's/Arpachshad lived four hundred three years after he became the father of Shelah/Arpachshad lived four hundred thirty years after he became the father of Shelah/' genesis.usfm


# restore chronology in chronicles, adding cainan back in

# 1 Chronicles 1:18
sed -i 's/Arpachshad became the father of Shelah/Arpachshad became the father of Cainan, and Cainan became the father of Shelah/' 1chronicles.usfm

# 1 Chronicles 1:24
sed -i 's/Shem, Arpachshad, Shelah/Shem, Arpachshad, Cainan, Shelah/' 1chronicles.usfm




# genesis 11:14
sed -i 's/Shelah lived thirty years, and became the father of Eber/Shelah lived one hundred thirty years, and became the father of Eber/' genesis.usfm


# do not change
# genesis 11:15
#sed -i 's/Shelah lived four hundred three years after he became the father of Eber/Shelah lived three hundred thirty years after he became the father of Eber/' genesis.usfm



# genesis 11:16
sed -i 's/Eber lived thirty-four years, and became the father of Peleg/Eber lived one hundred thirty-four years, and became the father of Peleg/' genesis.usfm



# masoretic says 430.
# lxx2012 says 270.
# bible.ca (see above) site says 370.
# lxx pdf from archive.org says 370. (archive.org ark 13960 t83j67m4m)

# genesis 11:17
sed -i 's/Eber lived four hundred thirty years after he became the father of Peleg/Eber lived three hundred seventy years after he became the father of Peleg/' genesis.usfm



# genesis 11:18
sed -i 's/Peleg lived thirty years, and became the father of Reu/Peleg lived one hundred thirty years, and became the father of Reu/' genesis.usfm



# genesis 11:20
sed -i 's/Reu lived thirty-two years, and became the father of Serug/Reu lived one hundred thirty-two years, and became the father of Serug/' genesis.usfm



# genesis 11:22
sed -i 's/Serug lived thirty years, and became the father of Nahor/Serug lived one hundred thirty years, and became the father of Nahor/' genesis.usfm



# masoretic: 29
# lxx2012: 179
# site bible.ca: 79
# lxx pdf from archive.org (ark 13960 t83j67m4m): 79

# genesis 11:24
sed -i 's/Nahor lived twenty-nine years, and became the father of Terah/Nahor lived seventy-nine years, and became the father of Terah/' genesis.usfm



# masoretic 119
# lxx2012 125
# site 129
# lxx archive 129
# nets 129

# genesis 11:25
sed -i 's/Nahor lived one hundred nineteen years after he became the father of Terah/Nahor lived one hundred twenty-nine years after he became the father of Terah/' genesis.usfm



printf .



# ------------------------------------------------------------------------------
# credit and righteousness

# here are two interpretations:
#   (a) yehovah credited abram's faith to abram as righteousness
#   (b) abram credited yehovah's truth to yehovah as righteousness

# interpretation (a) has a problem:
#   the word ויחשבה indicates a feminine subject,
#   but abram's faith (ויאמן) is masculine.

# interpretation (b) does not neglect the gender.
#   in the last verse, yehovah spoke (אמר) to abram
#   the related word: אמת means truth, and is feminine.

# it should be said that english loses the aspect of gender,
# which i believe is key for understanding this verse.
# it seems a translation should be made which informs the reader of gender.
# in lieu of that, this passage will be translated in a way that uses
# the gender to inform the translation, instead of ignoring it.

# 'for' might seem benign, but it might be interpreted like 'in exchange for',
# which i think would be very, very far from the meaning.
# 'as' is a much more straightforward term. many translations use it.
# it is really just a smoothing-word: it doesn't exist in hebrew, but it
# helps the sentence flow in english. so if a word is used here,
# then it should be a word that doesn't introduce ambiguity.

# note: genesis 15:6 is quoted inaccurately in the nt, based on the lxx.

# see also:

# Michael Peterson: Whose Righteousness - God's or Abraham's?
# https://www.academia.edu/33326228/Whose_Righteousness_Gods_or_Abrams_Another_look_at_Genesis_15_6

# Douglas DelTondo: "#3 Dr. Anthony Buzzard Fighting Back Against Pauline Canon Overeach Ep 3 of JWO Canon Movements"
# https://www.youtube.com/watch?v=EnkfoNGfrnE
# at around 28:00

# genesis 15:6
sed -i 's/He believed in Yahweh, who credited it to him for righteousness/He believed in Yahweh, and credited it to him as righteousness/' genesis.usfm









# ----------------------------------------------------------
# בעל (baal) - full treatment
# every occurrence will be reviewed and corrected if necessary
# this includes every conjugation of בעל


# Genesis 14:13
#sed -i 's/brother of Eshcol and brother of Aner\. They were allies of Abram/brother of Eshcol and brother of Aner\. They were the owners of the covenant of Abram/' genesis.usfm

# ... (unfinished)






# ----------------------------------------------------------
# marry vs take

# TO DO: review all occurances and implement

# marry is a modern word

# Genesis 19:14
#sed -i 's/who were pledged to marry his daughters/who took his daughters/' genesis.usfm



# ----------------------------------------------------------
# restore husband(s) to owner(s) when root is baal (בעל)
# and to lord(s) when root is adonai (אדני)

# sources where the word בעל means MASTER
#   web: hosea 2:16 husband (איש) vs master (בעל)
#   https://www.mechanical-translation.org/mtt/D22.html
#   https://en.wiktionary.org/wiki/%D7%91%D7%A2%D7%9C
#   https://www.biblehub.com/jeremiah/3-14.htm

# sources where the word בעל means OWNER
#   https://www.biblehub.com/hebrew/1167.htm
#   https://en.wikipedia.org/wiki/Baal
#   https://dictionary.reverso.net/hebrew-english/%D7%91%D7%A2%D7%9C





# HUSBANDS PLURAL
# cases where "husbands" is not "men" but "lords" or "owners"

# webp
# adonaim, lords
# Amos 4:1
sed -i 's/Listen to this word, you cows of Bashan, who are on the mountain of Samaria, who oppress the poor, who crush the needy, who tell their husbands, “Bring us drinks!”/Listen to this word, you cows of Bashan, who are on the mountain of Samaria, who oppress the poor, who crush the needy, who tell their lords, “Bring us drinks!”/' amos.usfm

# baal, owners
# Esther 1:17
sed -i 's/causing them to show contempt for their husbands when it is reported/causing them to show contempt for their owners when it is reported/' esther.usfm

# baal, owners
# Esther 1:20
sed -i 's/all the wives will give their husbands honor/all the wives will give their owners honor/' esther.usfm




# HUSBAND SINGULAR
# (one occurrance per verse unless noted)

# "man" 8x
# gen 3:6 3:16 16:3 29:32 29:34 30:15 30:18 30:20

# "brother-in-law"
# gen 38:8
sed -i 's/husband’s brother/brother-in-law/' genesis.usfm

# "owner"
# Exodus 21:22
sed -i 's/he shall be surely fined as much as the woman’s husband demands and the judges allow/he shall be surely fined as much as the woman’s owner demands and the judges allow/' exodus.usfm

# "man" x17
# lev 21:3 21:7
# num 5:13 5:19 5:20 5:27 5:29 30:6 30:7 30:8 30:10 30:11 30:12x2 30:13x2 30:14

# "owner"
# Deuteronomy 21:13
sed -i 's/After that you shall go in to her and be her husband, and she shall be your/After that you shall go in to her and be her owner, and she shall be your/' deuteronomy.usfm

# "married to a husband" -> "owned by an owner"
# בעלב-בעל
# baal-baal
# Deuteronomy 22:22
sed -i 's/If a man is found lying with a woman married to a husband, then they shall both die, the man who lay with the woman and the woman\. So you shall remove the evil from Israel/If a man is found lying with a woman owned by an owner, then they shall both die, the man who lay with the woman and the woman\. So you shall remove the evil from Israel/' deuteronomy.usfm

# "man" x3
# deu 22:23 24:3x2

# owner
# Deuteronomy 24:4
sed -i 's/her former husband, who sent her away, may not take her again to be his wife after she is defiled/her former owner, who sent her away, may not take her again to be his wife after she is defiled/' deuteronomy.usfm

# "brother-in-law"
# deu 25:5x2 25:7x2
sed -i 's/husband’s brother/brother-in-law/g' deuteronomy.usfm

# "man" 34x
#from איש and in proverbs 6:34 גבר
# deu 25:11 28:56
# jud 13:6 13:9 13:10 14:15 19:3 20:4
# rut 1:3 1:5 1:9 1:12x2 2:1 2:11
# 1sa 1:8 1:22 1:23 2:19 4:19 4:21 25:19
# 2sa 3:15 3:16 11:26 14:5 14:7
# 2ki 4:1 4:9 4:14 4:22 4:26
# pro 6:34 7:19

# owner
# Proverbs 12:4
sed -i 's/A worthy woman is the crown of her husband/A worthy woman is the crown of her owner/' proverbs.usfm

# owner
# Proverbs 31:11
sed -i 's/The heart of her husband trusts in her/The heart of her owner trusts in her/' proverbs.usfm

# owner
# Proverbs 31:23
sed -i 's/Her husband is respected in the gates/Her owner is respected in the gates/' proverbs.usfm

# owner
# Proverbs 31:28
sed -i 's/Her husband also praises her/Her owner also praises her/' proverbs.usfm

# owner
# Isaiah 54:5
sed -i 's/For your Maker is your husband/For your Maker is your owner/' isaiah.usfm

# a husband -> an owner
# Jeremiah 3:14
sed -i 's/Return, backsliding children,” says Yahweh, “for I am a husband to you/Return, backsliding children,” says Yahweh, “for I am an owner to you/' jeremiah.usfm

# friend not owner
# (wife in this verse should be woman)
# Jeremiah 3:20
sed -i 's/treacherously departs from her husband/treacherously departs from her friend/' jeremiah.usfm

# "man" 1x
# jer 6:11

# owner
# Jeremiah 31:32
sed -i 's/although I was a husband to them/although I was an owner to them/' jeremiah.usfm

# "man"6x
# eze 16:32 16:45 44:25
# hos 2:2 2:7 2:16

# owner
# Joel 1:8
sed -i 's/for the husband of her youth/for the owner of her youth/' joel.usfm





# ----------------------------------------------------------------------
# restore many instances of baal meaning owner (i.e. not just a name)
# restore man to owner when root is baal
# searched hebModern bible in "and" bible for בעל, and here are matches:
# TO DO: define exact process

# "a man's wife" -> "owned by an owner"
# בעלב-בעל
# baal-baal
# Genesis 20:3
#sed -i 's/Behold, you are a dead man, because of the woman whom you have taken; for she is a man’s wife/Behold, you are a dead man, because of the woman whom you have taken; for she is an owner’s wife/' genesis.usfm
sed -i 's/Behold, you are a dead man, because of the woman whom you have taken; for she is a man’s wife/Behold, you are a dead man, because of the woman whom you have taken; for she is owned by an owner/' genesis.usfm

# baal
# gen 36:38 36:39

# "dreamer" -> "owner of dreams"
# Genesis 37:19
sed -i 's/They said to one another, “Behold, this dreamer comes/They said to one another, “Behold, this owner of dreams comes/' genesis.usfm

# baal
# exo 14:2 14:9

# "married" -> "the owner of a woman"
# Exodus 21:3
sed -i 's/If he comes in by himself, he shall go out by himself\. If he is married, then his wife shall go out with him/If he comes in by himself, he shall go out by himself\. If he is the owner of a woman, then his wife shall go out with him/' exodus.usfm

# husband (will have already been changed to man)
# exo 21:22

# already owner
# Exodus 21:34
#sed -i 's/the owner of the pit shall make it good\. He shall give money to its owner, and the dead animal shall be his/the owner of the pit shall make it good\. He shall give money to its owner, and the dead animal shall be his/' exodus.usfm

# "master" -> "owner"
# Exodus 22:8
sed -i 's/then the master of the house shall come near to God/then the owner of the house shall come near to God/' exodus.usfm

# "involved in a dispute" -> "an owner of words"
# mechanical translation says:
#   'The phrase “master of words” apparently means “one with a dispute.”'
#   but there is no explanation why, and no further reference
#   smith's literal translation at least has 'words'
# Exodus 24:14
sed -i 's/Behold, Aaron and Hur are with you\. Whoever is involved in a dispute can go to them/Behold, Aaron and Hur are with you\. Whoever is an owner of words can go to them/' exodus.usfm

# "a chief man" -> "an owner"
# Leviticus 21:4
sed -i 's/He shall not defile himself, being a chief man among his people, to profane himself/He shall not defile himself, being an owner among his people, to profane himself/' leviticus.usfm

# baal
# num 22:41 32:38 33:7
# deu 4:3

# "creditor" -> "owner of a loan"
# Deuteronomy 15:2
sed -i s'/This is the way it shall be done: every creditor shall release that which he has lent to his neighbor/This is the way it shall be done: every owner of a loan shall release that which he has lent to his neighbor/' deuteronomy.usfm

# yoke
# deu 21:3

# husband
# deu 22:22

# baal
# jos 11:17 13:17 15:60 18:14
# jud 3:3 8:33 9:4

# "master" -> "owner"
# Judges 19:22
sed -i 's/and they spoke to the master of the house, the old man/and they spoke to the owner of the house, the old man/' judges.usfm

# "master" -> "owner"
# Judges 19:23
sed -i 's/The man, the master of the house, went out to them, and said to them/The man, the owner of the house, went out to them, and said to them/' judges.usfm

# baal
# 2sa 5:20

# "hairy man" -> "man, an owner of hair"
# Smith's Literal Translation
#   And they will say to him, A man possessing hair
# 2 Kings 1:8
sed -i 's/They answered him, “He was a hairy man, and wearing a leather belt around his waist/They answered him, “He was a man, an owner of hair, and wearing a leather belt around his waist/' 2kings.usfm

# baal
# 1ch 1:49 1:50 4:33 5:5 5:23 8:34 9:40 14:11 27:28
# 2ch 26:7

# "chancellor" -> "owner of taste"
# ezra 4:8 4:9 and 4:17
sed -i 's/Rehum the chancellor/Rehum the owner of taste/g' ezra.usfm

# "bird" -> "owner of wings"
# Proverbs 1:17
sed -i 's/For the net is spread in vain in the sight of any bird/For the net is spread in vain in the sight of any owner of wings/' proverbs.usfm

# "man" -> "owner"
# Proverbs 22:24
sed -i 's/Don’t befriend a hot-tempered man/Don’t befriend a hot-tempered owner/' proverbs.usfm

# "a man" -> "an owner"
# Proverbs 23:2
sed -i 's/put a knife to your throat if you are a man given to appetite/put a knife to your throat if you are an owner given to appetite/' proverbs.usfm

# "schemer" -> "owner of wicked thoughts"
# Proverbs 24:8
sed -i 's/One who plots to do evil will be called a schemer/One who plots to do evil will be called an owner of wicked thoughts/' proverbs.usfm

# with teeth (owner of teeth)
# Isaiah 41:15
#Behold, I have made you into a new sharp threshing instrument with teeth.  You will thresh the mountains,  and beat them small,  and will make the hills like chaff.  

# my
# Isaiah 50:8
#He who justifies me is near.  Who will bring charges against me?  Let us stand up together.  Who is my adversary?  Let him come near to me.  

# yoke בְּעֹל
#Jeremiah 27:8
#“‘“‘It will happen that I will punish the nation and the kingdom which will not serve the same Nebuchadnezzar king of Babylon, and that will not put their neck under the yoke of the king of Babylon,’ says Yahweh, ‘with the sword, with famine, and with pestilence, until I have consumed them by his hand.

# yoke
# Jeremiah 27:11
#But the nation that brings their neck under the yoke of the king of Babylon and serves him, that nation I will let remain in their own land,’ says Yahweh; ‘and they will till it and dwell in it.’”’”  

# yoke
# Jeremiah 27:12
#I spoke to Zedekiah king of Judah according to all these words, saying, “Bring your necks under the yoke of the king of Babylon, and serve him and his people, and live.

# captain
# Jeremiah 37:13
#When he was in Benjamin’s gate, a captain of the guard was there, whose name was Irijah, the son of Shelemiah, the son of Hananiah; and he seized Jeremiah the prophet, saying, “You are defecting to the Chaldeans!”  

# baal
# eze 25:9

# had
# Daniel 8:6
#He came to the ram that had the two horns, which I saw standing before the river, and ran on him in the fury of his power.  

# had
# dan 8:20

# baal
# his 9:10

# husband
# joe 1:8

# if hebModern is used, occurrances are found in NT. not addressing those.




# ---------------------------------
# word בעלי is owners

# this would be a natural progression of the work done to replace husband with
# owner instead of man. but it's out of the scope of this project to keep
# digging into every conjugation of ba'al and replacing it. so this section
# will not be implemented, which may be inconsistent, but i believe it is still
# helpful that i have done the work on this matter up to this point.


# Joshua 24:11
#sed -i 's/The men of Jericho fought against you/The owners of Jericho fought against you/' joshua.usfm

# Judges 9:2
#sed -i 's/Please speak in the ears of all the men of Shechem/Please speak in the ears of all the owners of Shechem/' judges.usfm







# ----------------------------------------------------------
# remove trinity bias
# TO DO: review in hebrew

# fix bad grammar and capitalization that attempts to prove trinity

# whole series of edits needs more references
# https://www.youtube.com/watch?v=KqPagPOlU7M

# exodus 3:14
sed -i 's/I AM WHO I AM/I will be who I will be/' exodus.usfm
sed -i 's/I AM/I will be/' exodus.usfm




# restore matt 3:17 which apparently originally said "today i have begotten thee", which was removed because it disproves the trinity doctrine.
# see jesus' words only videos and/or site for supporting references,
# especially https://www.youtube.com/watch?v=cfRzYqpXchM
# also note: psalms 2:7 (WEB version)
# I will tell of the decree: Yahweh said to me, “You are my son. Today I have become your father.
# if yehovah said "today i have begotten thee" about yehoshua during his baptism, then that seems to contradict yehovah begetting yehoshua at yehoshua's birth.
# also see isaiah 11:1-5 and 42:1-4 for context

# see "Gospel Parallels" edited by Burton H. Throckmorton, Jr., 2nd edition, 1949, 1957, page 11.
#   "Thou art my son; today I have begotten thee"
# Attested to in manuscripts:
# Codex Bezae Cantabrigiensis (6th cent., perhaps 5th), Itala (the Old Latin version, as reconstructed by Adolf Jülicher), Justin, Clement, Origen, Augustine, Gospel of the Ebionites.
# This reading is only footnoted for Luke 3:22. Shouldn't it also apply to Matthew?
# At least the Gospel of the Ebionites has this reading in Matthew, according to "Gospel Parallels"

#  + " Today I have become his father."
# work toward restoring. use "his" not "you" (or thee) to match sentence

# matthew 3:17
sed -i 's/This is my beloved Son, with whom I am well pleased/This is my beloved Son, with whom I am well pleased\. Today I have become his father/' matthew.usfm




# restore "the father" to matthew 19:17

# Still further also He plainly says, "None is good, but My Father, who is in heaven."
# http://earlychristianwritings.com/text/clement-instructor-book1.html

# There still remains to them, however, that saying of the Lord in the Gospel, which they think is given them in a special manner as a shield, viz., "There is none good but one, God the Father."
# http://earlychristianwritings.com/text/origen123.html

# also note that the words "that is" were inserted by translators, and do not reflect the greek.

# "that is, God" -> "God the Father"

# matthew 19:17
sed -i 's/No one is good but one, that is, God/No one is good but one, God the Father/' matthew.usfm






# see: Shem Tov
# for additional witness of lack of the trinitarian style formula, see also: Eusebius of Caesarea, Historia ecclesiastica, 3.5.2.
#   Kirsopp Lake, J.E.L. Oulton, H.J. Lawlor, Ed.
#   available online at tufts.edu

# matthew 28:19
sed -i 's/and make disciples of all nations, baptizing them in the name of the Father and of the Son and of the Holy Spirit,//' matthew.usfm

# see: Shem Tov

# matthew 28:20
sed -i 's/teaching them to observe all things that I commanded you\. Behold, I am with you always, even to the end of the age\.”\\wj\* Amen\./and teach them to carry out all the things which I have commanded you forever\.”\\wj\*/' matthew.usfm






# "God" -> "a god"
# this revision of the translation of john 1:1 is based on the scripture of the greek (nestle-aland 27) with the knowledge of the difference between having a definite article (the "τον" in "και ο λογος ην προς τον θεον") and having an absense of a definite article ("θεος" is not preceded by a definite article such as "ο" or "τον" in "και θεος ην ο λογος").
# the restorative phrasing for the 3rd clause matches the New World Translation 1984

# john 1:1
sed -i 's/In the beginning was the Word, and the Word was with God, and the Word was God/In the beginning was the Word, and the Word was with God, and a god was the Word/' john.usfm





# "I AM" -> "I was"
# "I was" also supported by Lamsa Bible and Anderson New Testament
# https://www.biblehub.com/parallel/john/8-58.htm

# john 8:58
sed -i 's/before Abraham came into existence, I AM/before Abraham came into existence, I was/' john.usfm






# ----------------------------------------------------------
# messiah's birth
# TO DO: cite manuscript witnesses

# it seems most likely that after text such as matthew was written,
# the text was corrupted to create a virgin birth story, possibly by theodotian
# in cooperation with marcion.

# it has also been said that the ebionites had scripture that didn't have a
# geneology.

# see youtube.com/@jesuswordsonly and search videos for "virgin",
# especially this video:
# https://www.youtube.com/watch?v=cfRzYqpXchM

# relevant verses:

# 2 samuel 7:12-14
# When your days are fulfilled and you sleep with your fathers, I will set up your offspring after you, who will proceed out of your body, and I will establish his kingdom.  He will build a house for my name, and I will establish the throne of his kingdom forever.  I will be his father, and he will be my son. If he commits iniquity, I will chasten him with the rod of men and with the stripes of the children of men;
# note that it says birth 'out of your body' (i.e., not by holy spirit), and 'i will be his father' (at the baptism this is fulfilled, see psalm 2:7 and matthew 3:17 as it is restored)

# jeremiah 22:30
# Yahweh says, “Record this man as childless, a man who will not prosper in his days; for no more will a man of his offspring prosper, sitting on David’s throne and ruling in Judah.”
# note that the passage is apparently talking about jechoniah, and that this same jechoniah appears in the matthew chapter 1 geneology.



# edit isaiah 7:14, which should not be taken as prophecy about jesus anyway
# the word in isaiah 7:14 means young woman, not virgin, which is
# also supported in translations: GNT, JPS, NAB, NET, NRSV
# and ISR reads: maiden

# "virgin" -> "young woman"
# isaiah 7:14
sed -i 's/Behold, the virgin will conceive, and bear a son, and shall call his name Immanuel/Behold, the young woman will conceive, and bear a son, and shall call his name Immanuel/' isaiah.usfm


# Matthew chapter 1 may be an addition to the original.
# the "Gospel of the Ebionites" as quoted by Epiphanius, late 2nd century A.D.
# see https://www.earlychristianwritings.com/text/gospelebionites-panarion.html
# "And the beginning of their Gospel runs:
# It came to pass in the days of Herod the king of Judaea"
# this text, however, quotes christ as saying "I am come to do away with sacrifices", which seems to me to be incompatible with a true gospel from christ.
# still, there do seem to be problems with the geneology: jechoniah is named, which seems incompatible with prophecy, and the geneology disagrees with luke, and there may be an internal issue of counting 14, 14, and 14 generations.
# moreover, there is the issue of a virgin birth account. there is motive to have injected it to prove a trinity doctrine, which has been a theological war at least as early as 325 A.D., which continues to this day.
# however, there are (are there not?) prophecies from tanakh that specify that one (the messiah) will be a descendent, "of the seed"(need citation) of david, as in, a fleshly descendent, in the male line, not a symbolic descendent. and in one of john's letters he emphasizes yehoshua as having come in the flesh.
# currently, this version opts for trusting the ebionite account: that there was no matthew chapter 1 when matthew was written, because there is reason to believe it isn't original to the text of matthew, and because of the issues with it.
# also noteworthy is that the ebionite text seems to get matthew 3:17 right ("today i have become your father"), especially because it seems corroborated by psalm 2:7.

# remove matthew 1 completely
#perl -i -p0e 's/\\c 1\n.*?\\c 2\n/\\c 2\n/s' matthew.usfm


# restore text.
sed -i 's/Jacob became the father of Joseph, the husband of Mary, from whom was born Jesus/Jacob became the father of Joseph. This Joseph became the father of Jesus/' matthew.usfm


# remove v18 to chapter 2. too many issues.
perl -i -p0e 's/\\p\n\\v 18 Now the birth of Jesus.*He named him Jesus\.//s' matthew.usfm













# starting with "Now" is awkward. prefer translation that starts with "When",
# as in the CEV, Geneva Bible of 1587, etc.
# remove word "Now"

# matthew 2:1
#sed -i 's/Now when Jesus was born/When Jesus was born/' matthew.usfm


# see also the matthew 3:17 restoration in the "trinity" section here







# ----------------------------------------------------------
# do not swear falsely

# in torah it is written that you can, and should swear, and by yehovah's name.
# deu 6:13, 10:20 say you "shall swear by his name"
# however, in english bibles jesus seems to say don't swear, without exception.
# mat 5:34

# this problem is resolved by the hebrew gospel of matthew (shem tov):
# see hebrew gospel of matthew, george howard
# matthew 5:34 "do not swear in vain"

# there is also an article at jesuswordsonly.github.io that talks about this

# edit "do not swear" to "do not swear in vain"

# matthew 5:33
sed -i 's/You shall not make false vows, but shall perform/You shall not make false vows by my name, but shall perform/' matthew.usfm

# matthew 5:34
sed -i 's/but I tell you, don’t swear at all: neither by heaven/but I tell you, don’t swear falsely at all: neither by heaven/' matthew.usfm

# i currently do not have manuscript support for this edit except that it
# should match what yehoshua was actually saying, and should be
# compatible with torah. NEEDS MORE RESEARCH!
# james
#sed -i 's/But above all things, my brothers, don’t swear/But above all things, my brothers, don’t swear falsely/' james.usfm






# ----------------------------------------------------------
# lord's prayer
# see: ESV, Berean Literal Bible, Douay-Rheims, etc.

# "the evil one. For yours is the Kingdom, the power, and the glory forever" -> "evil"

# matthew 6:13 (1 of 2)
sed -i 's/deliver us from the evil one/deliver us from evil/' matthew.usfm

# matthew 6:13 (2 of 2)
sed -i '/yours is the Kingdom, the power, and/d' matthew.usfm






# ----------------------------------------------------------
# put away vs divorce
# TO DO: study in hebrew matthew and greek

# there is a difference.
# the webp version seems accurate in matthew 5, not matthew 19.
# the kjv seems to be more accurate than other popular translations.
# the kjv seems accurate in mattew 19, but not all of matthew 5.
# the scriptures 1998 by isr seems accurate in all cases (matthew 5 & 19)

# "divorce" -> "put away"
# matthew 19:8
sed -i 's/Moses, because of the hardness of your hearts, allowed you to divorce your wives, but from the beginning it has not been so/Moses, because of the hardness of your hearts, allowed you to put away your wives, but from the beginning it has not been so/' matthew.usfm

# "divorces" -> "puts away"
# "divorced" -> "put away"
# matthew 19:9
sed -i 's/I tell you that whoever divorces his wife, except for sexual immorality, and marries another, commits adultery; and he who marries her when she is divorced commits adultery/I tell you that whoever puts away his wife, except for sexual immorality, and marries another, commits adultery; and he who marries her when she is put away commits adultery/' matthew.usfm






# ----------------------------------------------------------
# seat of moses

# Matthew 23:3
# All things therefore whatever they tell you to observe,
# observe and do, but don’t do their works; for they say,
# and don’t do.
# - WEBP
#
# Therefore all that he says to you, diligently do, but
# according to their reforms and their precedents do not do,
# because they talk, but they do not do.
# - translation from "the hebrew yeshua vs the greek jesus"
# by nehemia gordon, pg 48.
#
# Perhaps instead of "Therefore", "Now" or "And now".
# but just do the minimal change necessary

# "they" -> "he"
# matthew 23:3
sed -i 's/whatever they tell you to observe/whatever he tells you to observe/' matthew.usfm




# ----------------------------------------------------------
# power matthew 26:64

# https://hermeneutics.stackexchange.com/questions/49460/is-it-power-or-the-power-in-matthew-2664
# 'της δυνάμεως—“the power,” is a circumlocution for the Tetragrammaton. It is not referring to merely abstract power, but using the epithet της δυνάμεως as a synecdoche'

# deltondo claims there are many instances of tetragram in meunster version, hebrew matthew...
# for understanding, also see lev. 24 in lxx vs MT, "blasphemy".. speaking the name


# edit to WEB custom name, which will be modified in BULK below
# "Power" -> "Yahweh"
# matthew 26:64
sed -i 's/Nevertheless, I tell you, after this you will see the Son of Man sitting at the right hand of Power, and coming on the clouds of the sky/Nevertheless, I tell you, after this you will see the Son of Man sitting at the right hand of Yahweh, and coming on the clouds of the sky/' matthew.usfm



printf .









# ------------------------------------------------------------------------------
# BULK TRANSLATION REVISIONS
# revisions that change multiple occurrences of a word
# ------------------------------------------------------------------------------





# ----------------------------------------------------------
# word for mighty one or powers

# in nt edit "god" to "theos" or "theon" or "theou"?
# it would require extra work to use each type,
# which is currently outside the scope of this project,
# and not necessarily desirable, because replacing all instances the same
# way is consistent.
# no! theos has a bad etymology according to
# c.j. koster: come out of her my people, 2006

# ...
# edit "god" to "elohim"
# see isaiah 65:11 in hebrew, and also in various english translations
# also dig for info regarding true etymology of "god", and you may find that
# its origin is from the name of a false deity

# since there seems to be no equivalent english word for translation, then
# transliterate from hebrew: "elohim"


# special case in 1kings chapter 11:
# perhaps elohimess? i don't want to start making up new words.
# upon review of biblehub's versions, 4 have just "god", so i'll use that.
# See Smith's Literal Translation, Geneva Bible of 1587,
#   Bishops' Bible of 1568, and Coverdale Bible of 1535
# more info:
# the word is אלהי, and is translated "god" other times, even in 1kings 11:33.
# the gender seems to be in the name, not the title.
# this is perhaps why 4 translations translated it as "god" not "goddess".
# translating it as "god" can be seen as a more literal translation.
# 1ki 11:5, and 1ki 11:33
sed -i 's/goddess/god/g' 1kings.usfm

# mask until changes are complete
# name of a place
# deu 10:7 2x
sed -i 's/Gudgodah/Gudgo-dah/g' deuteronomy.usfm


# 20x
sed -i 's/ a God/ an Elohim/g' *.usfm

# 17x
# also matches " a godless"
sed -i 's/ a god/ an elohim/g' *.usfm

# 3144x (3164 - 20 already replaced = 3144)
sed -i 's/God/Elohim/g' *.usfm

# 325x (342 - 17 already replaced = 325)
# also matches "gods", "ungodliness", "ungodly", "godless", "godly"
sed -i 's/god/elohim/g' *.usfm

# 0 instances of "GOD" all-uppercase were found in 2023-02-20 edition of WEBP

# restore masked name
# deu 10:7 2x
sed -i 's/Gudgo-dah/Gudgodah/g' deuteronomy.usfm




printf .





# ----------------------------------------------------------
# yehovah vowels: sheva cholem qamats

# see book(s) by nehemia gordon

# 6885x
sed -i 's/Yahweh/Yehovah/g' *.usfm

# 4x
sed -i 's/YAHWEH/YEHOVAH/g' *.usfm





# ----------------------------------------------------------
# set-apart

# the term "holy" does not seem to convey the meaning of קדש

# edit "holy", a word associated with the sun, and sun worship,
# to "set-apart", which is a more straightforward meaning of קדש

# 450x
sed -i 's/holy/set-apart/g' *.usfm

# capitalize "apart" because it may be in a title mid-sentence, and because
# it is difficult to differentiate between when it is at the beginning of a
# sentence vs mid-sentence.
# 79x
sed -i 's/Holy/Set-Apart/g' *.usfm

# 3x
sed -i 's/HOLY/SET-APART/g' *.usfm



printf .



# ----------------------------------------------------------
# husband and wife

# there is no "wife" or "husband" in hebrew or greek, just man and woman, etc.
# 9x
sed -i 's/husbands/men/g' *.usfm

# 76x (85 - 9 already changed = 76)
sed -i 's/husband/man/g' *.usfm

# 113x (119 - 6 = 113)
sed -i 's/wives/women/g' *.usfm

# 343x (347 - 4 = 343)
sed -i 's/wife/woman/g' *.usfm

# revert back for terms "midwives" and "midwife"
# 6x
sed -i 's/midwomen/midwives/g' *.usfm

# 4x
sed -i 's/midwoman/midwife/g' *.usfm


printf .


# ----------------------------------------------------------
# the messiah's name

# the messiah's name has been transliterated many ways:
# yahshua, yahushua, yeshua, iesou, iesous, iesus, jesus

# a history of the name can be found here:
# (THIS ANALYSIS IS QUESTIONABLE AND ITS VALUE HERE IS DEPRECATED)
# yahshua to jesus: evolution of a name, by william finck, 2006
# https://christogenea.org/essays/yahshua-jesus-evolution-name

# in general, finck's essay shows how the name evolved slowly as a result of
# the evolution of languages.
# also of note, even though yahshua may be the most accurate transliteration,
# christ was likely most commonly known as iesous during his time on earth.
# also, the story of the tower of babel suggests that varied languages is ok.

# the names joshua, jacob, and joseph, for example, could also use fresh
# transliteration, so then where should a line be drawn, if anywhere?

# see "the hebrew yeshua vs the greek jesus"
# by nehemia gordon, pg 48.
# WHY LOOK HERE? AND WHERE IS THE BOOK AVAILABLE FOR FREE?
# or even where is that page available for free?
# (this reference should possibly be omitted)

# the hebrew gospel of matthew (george howard) has יש״ו in place
# of the messiah's name. that is actually a curse meaning "may his name
# be blotted out". it is eerily similar to the form of the messiah's name
# written has "yeshua". in light of this, i checked the isr version of
# the scriptures, and also the leningrad codex (tanach.us version 1.8)
# and confirmed that there should be a "ho" sound, both in the vowel-less
# matthew 2 place, and joshua 1:1, in the name of joshua son of nun.
# the isr scriptures version transliterates joshua son of nun's name in
# joshua 1:1 exactly this way: "Yehoshua". to the best of my knowledge,
# his name is identical to the messiah's name.
# furthermore, any form starting with "ya" does not seem to be right
# because the vowel pointing indicates a sheva, not a qamats for example,
# and there is no need to try to match the apparently pagan form "yahweh".
# rather, it should be either without vowel, or with an e. however, if
# without an e, then the y and ho of "yhoshua" would be combined in english,
# and the form y'hoshua is novel (i don't recall having seen it elsewhere) and
# is an awkward and difficult transliteration (that does not mean it isn't
# best, but right now i am only trying to make a necessary correction to an
# acceptable form, not intoduce un-vetted ideas)

# edit "jesus" to "yehoshua"
# no instances of "jesus" all-lowercase were found on last check
# 511x
sed -i 's/Jesus/Yehoshua/g' *.usfm

# 2x
sed -i 's/JESUS/YEHOSHUA/g' *.usfm

# fix apostrophe issue. 12 occurences in 2023-02-20. will be 13 in update.
# 12x
sed -i 's/Yehoshua’ /Yehoshua’s /g' *.usfm

# do not edit "christ" to "messiah"

# editing "christ" to "messiah" would create a confusing translation.
# the term "messiah" is already used in john, distinct from the word "christ"





# GLOBAL!

sed -i 's/became the father of/brought forth/g' *.usfm

printf .



# ------------------------------------------------------------------------------
# CONVERT USFM TO HTML
# only usfm markers used in the web version are considered
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# add html

# save the following html as file, in order to use it to prepend it
cat << EOF > top-tempfile.html
<!DOCTYPE html>
<html lang="en">
<head>
<title>Book</title>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="../style.css" />
<link rel="shortcut icon" type="image/png" href="../book.png" />
<meta name="viewport" content="user-scalable=yes, initial-scale=1, minimum-scale=1, width=device-width" />
<meta name="keywords" content="World English Scripture, Set-Apart Scripture, Messianic Scripture, Yehoshua Scripture, Yeshua Scripture, Yahushua Scripture, Yahshua Scripture, Torah, Neviim, Kethuvim, Messiah, Law, Prophets, Writings" />
</head>
<body>
<div class="main">
EOF

# prepend and append html to usfm files, saving as html
for f in *.usfm; do
n="${f%%.*}".html
cat top-tempfile.html $f > $n
echo '</div></body></html>' >> $n
done

# clean up temporary file
rm top-tempfile.html

# customize book title
for f in *.html; do
h=$(grep '\\h ' $f | cut -c 4- | xargs)
sed -i 's/<title>Book<\/title>/<title>'"${h}"'<\/title>/' $f
done

# convert \h marker into h1 tag, preserving the name of the book
sed -i 's/\\h \(.*\)/<h1 class="booklabel">\1<\/h1>/' *.html

# convert id marker
sed -i 's/\\id \(.*\)/<!-- \1 -->/' *.html
# drop usfm ide marker
sed -i '/\\ide /d' *.html
printf .



# ------------------------------------------------------------------------------
# psalms, chapter, and verse numbering


# swap psalm chapter and psalm book order in usfm before converting to html



# convert ms1 (psalm books 1-5)
sed -i 's/\\ms1 \([A-Za-z]* [0-9]\+\)/<h2 class="ms1">\1<\/h2>/' psalms.html
# no major section (psalm books 1-5)
#sed -i '/\\ms1 /d' psalms.html

# convert psalm number
sed -i 's/\\c \([0-9]*\)/<h2 class="psalmlabel" id="\1">\1<\/h2>/' psalms.html
# convert psalm number with label "Psalm" (like from \cl)
#sed -i 's/\\c \([0-9]*\)/<h2 id="\1">Psalm \1<\/h2>/' psalms.html
# remove chapter label for psalms
sed -i '/\\cl /d' psalms.html

# convert chapter
# STYLE ADVICE: if using chapters, use p1's after each new chapter
sed -i 's/\\c \([0-9]\+\)/<h2 class="chapterlabel" id="\1">\1<\/h2>/' *.html
# no chapters
#sed -i '/\\c /d' *.html


# ------------------------------------------------------------------------------
# basic paragraph (all scripture text will be in various p tags)

# convert paragraphs, otherwise implied quotes are broken.
sed -i 's/\\p /<p>/g' *.html
sed -i 's/\\p$/<p>/g' *.html
# no paragraphs
#sed -i 's/\\p //g' *.html
#sed -i 's/\\p//g' *.html

# set class of first paragraph
sed -i '0,/<p>/{s/<p>/<p class="p1">/}' *.html



# ------------------------------------------------------------------------------
# alternate paragraphs

# convert quote 1, for poetry
sed -i 's/\\q1 /<p class="q1">/g' *.html
sed -i 's/\\q1/<p class="q1">/g' *.html
# no q1
#sed -i 's/\\q1 //g' *.html
#sed -i 's/\\q1//g' *.html

# convert quote 2, for poetry
sed -i 's/\\q2 /<p class="q2">/g' *.html
sed -i 's/\\q2/<p class="q2">/g' *.html
# no q2
#sed -i 's/\\q2 //g' *.html
#sed -i 's/\\q2//g' *.html

# convert quote selah, for poetry, usually right-aligned
sed -i 's/\\qs /<p class="qs">/g' *.html
sed -i 's/\\qs\*/<\/p>/g' *.html
# run this last or it will match others
sed -i 's/\\qs/<p class="qs">/g' *.html
# no qs
#sed -i 's/\\qs //g' *.html
#sed -i 's/\\qs//g' *.html
#sed -i 's/\\qs\*//g' *.html

# convert speaker, for song of songs
sed -i 's/\\sp /<p class="sp">/g' *.html
sed -i 's/\\sp/<p class="sp">/g' *.html
# no sp
#sed -i 's/\\sp //g' *.html
#sed -i 's/\\sp//g' *.html

# convert margin, for non-indented lists
sed -i 's/\\m /<p class="m">/g' *.html
sed -i 's/\\m$/<p class="m">/g' *.html
# no m
#sed -i 's/\\m //g' *.html
#sed -i 's/\\m//g' *.html

# convert margin indented, for indented lists
sed -i 's/\\mi /<p class="mi">/g' *.html
sed -i 's/\\mi/<p class="mi">/g' *.html
# no mi
#sed -i 's/\\mi //g' *.html
#sed -i 's/\\mi//g' *.html

# convert paragraph indent 1
sed -i 's/\\pi1 /<p class="pi1">/g' *.html
sed -i 's/\\pi1/<p class="pi1">/g' *.html
# no pi1
#sed -i 's/\\pi1 //g' *.html
#sed -i 's/\\pi1//g' *.html
printf .


# convert li1
sed -i 's/\\li1 /<p class="li1">/g' *.html
sed -i 's/\\li1/<p class="li1">/g' *.html


# convert director
sed -i 's/\\d /<p class="d">/g' *.html
sed -i 's/\\d/<p class="d">/g' *.html

# convert nb
sed -i 's/\\nb /<p class="nb">/g' *.html
sed -i 's/\\nb/<p class="nb">/g' *.html



# ------------------------------------------------------------------------------
# close paragraph tags

# close various paragraph tags
sed -i 's/<p/<\/p><p/g' *.html
# clean up unintended first closing paragraph tag
sed -i '0,/<\/p>/{s/<\/p>//}' *.html
# add final closing paragraph tag
sed -i 's/<\/div><\/body>/<\/p><\/div><\/body>/' *.html



# ------------------------------------------------------------------------------
# span

# convert verse numbers
sed -i 's/\\v \([0-9]\+\) /<span class="v">\1\&#160;<\/span>/g' *.html
# run this before wj, so clearing after span doesn't eliminate necessary spaces
#sed -i 's/<\/span> \+/<\/span>/g' *.html
# no verse numbers
#sed -i 's/\\v [0-9]* //g' *.html



# convert wj, for having red-letter text
sed -i 's/\\wj /<span class="wj">/g' *.html
sed -i 's/\\wj\*/<\/span>/g' *.html
# run this last or it will match others
sed -i 's/\\wj/<span class="wj">/g' *.html


# bk style num21:14
sed -i 's/\\bk /<span class="bk">/g' *.html
sed -i 's/\\bk\*/<\/span>/g' *.html
# run this last or it will match others
sed -i 's/\\bk/<span class="bk">/g' *.html


# footnotes
sed -i 's/\\f /<span class="f">/g' *.html
sed -i 's/\\f\*/<\/span>/g' *.html

# cross-references
sed -i 's/\\x /<span class="x">/g' *.html
sed -i 's/\\x\*/<\/span>/g' *.html

printf .


# ------------------------------------------------------------------------------
# breaks

sed -i 's/\\b /<div class="b"> \&#160; <\/div>/g' *.html
sed -i 's/\\b$/<div class="b"> \&#160; <\/div>/g' *.html



# ------------------------------------------------------------------------------
# fix nesting for p tags

# due to chapters
perl -i -p0e 's/<h2 class="([a-z]*)" id="([0-9]*)">[0-9]*<\/h2>\n<\/p>/<\/p><h2 class="\1" id="\2">\2<\/h2>\n/g' *.html

# due to breaks
perl -i -p0e 's/<div class="b"> \&#160; <\/div>\n<\/p>/<\/p><div class="b"> \&#160; <\/div>\n/g' *.html



# ------------------------------------------------------------------------------
# spacing

# swap nbsp character for html code
sed -i 's/ /\&#160;/g' *.html

# remove extra spaces
sed -i 's/  / /g' *.html



echo " Done."
