#!/bin/bash


# Transforming the World English Bible into scriptures for reading
# ----------------------------------------------------------------
# REQUIREMENTS:
#   FILES:
#     engwebp_html.zip (scripture source file)
#       source: https://ebible.org/Scriptures/engwebp_html.zip
#       (known to work with the 2023-02-20 version)
#     setup.sh (this file)
#     style.css (or any style.css you choose)
#     caslon.ttf (any fonts specified in style.css)
#     index.html (custom index is preferable to default index)

#  ENVIRONMENT:
#    a linux bash shell (i.e. GNU bash 5.2.2, perl v5.36.0, sed 4.8)
#    an http server or way to view html files

# INSTRUCTIONS
# 1. run setup.sh (this file) in a clean directory that has engwebp_html.zip
# 2. copy all html files to a subdirectory named "book"
# 3. make sure index.html, style.css, and caslon.ttf, are in the parent
#      directory of the "book" directory
# website is ready to run. use http server or software to view site.


# NOTES:
# lines with just "# ..." indicate planned but unwritten code



# ----------------------------------------------------------
# --- FULL PROCEDURE ---

# ----------------------------------------------------------
# prepare files

# inform the person running this script that it is now running
printf Processing

# extract quietly
unzip -q 'engwebp_html.zip'

# delete unnecessary files
rm index.htm copr.htm copyright.htm FRT*.htm GLO*.htm gentiumplus.css
rm engwebp-VernacularParms.xml home_sm.png keys.asc
rm -r fonts/

# output dots throughout processing as a progress indicator
printf .



# ----------------------------------------------------------
# REMOVE BOOKS

# remove texts according to revelation 2:2
rm ROM*.htm 1CO*.htm 2CO*.htm GAL*.htm EPH*.htm PHP*.htm COL*.htm 1TH*.htm 2TH*.htm 1TI*.htm 2TI*.htm TIT*.htm PHM*.htm HEB*.htm ACT*.htm

# remove text associated with acts
rm LUK*.htm

# remove text associated with luke
rm MRK*.htm

# remove text which has indications of being a forgery
rm 2PE*.htm

printf .

# ----------------------------------------------------------
# change stylesheet link
sed -i 's/gentiumplus.css/\.\.\/style.css/g' *.htm
printf .

# ----------------------------------------------------------
# HTML BATCH CHANGES to remove clutter
# this process eliminates some parts in individual steps,
# which could be re-scripted to be done at once, but
# this is how the script developed.

# perl is much simpler than sed for multiline searches
# -i: in place
# -0: set record separator to null character (instead of new line)

# remove name
perl -i -p0e 's/World English Bible //igs' *.htm
perl -i -p0e 's/World English Bible//igs' *.htm
printf .

# remove meta tag (and new line)
perl -i -p0e 's/<meta name=.*</head>/</head>/igs' *.htm
printf .

# remove top nav (and new line)
perl -i -p0e 's/<ul.*<div class="main">/<div class="main">/s' *.htm
printf .

# remove bottom nav (and new line)
perl -i -p0e 's/<ul.*<div class="footnote">/<div class="footnote">/s' *.htm
printf .

# remove copyright
perl -i -p0e 's/<div class="copyright">.*<\/div>//s' *.htm
printf .


# ----------------------------------------------------------
# COMBINE CHAPTERS

# list all .htm files
# starting with unique 3 letter codes
# not longer than 3 letters (menu pages)
# remove the .htm part
# save as file books.txt
ls -1 *.htm | uniq -w 3 | grep -vE '\w{4,}' | sed 's/\.htm//' > books.txt
printf .

# now it's safe to remove all menu pages
rm ???.htm
rm PSA000.htm

# rename file of psalms chapter 1 so it matches the format of other books
mv PSA001.htm PSA01.htm

# make chapter 1 the main book file
# like if this were a valid command: mv ???01.htm ???.htm
while read; do mv "${REPLY}"01.htm "${REPLY}".htm; done < books.txt


# for each ???.htm
#   match </title>
#   delete the 2 (always 2) characters before it
sed -i -e 's/..<\/title>/<\/title>/g' ???.htm
printf .

# remove all end-of-page footnotes
# for each *.htm
#   match <div class="footnote">
#   delete everything after it, then delete it
sed -i '0,/<div class="footnote">/I!d' *.htm
sed -i 's/<div class="footnote">//' *.htm
printf .

# for each ?????*.htm
#   match <div class="main">
#   delete everything before it
sed -i -n '/<div class="main">/,$p' ?????*.htm
# delete that line
sed -i 's/<div class="main">//' ?????*.htm
printf .

#################
# ASSEMBLE BOOKS

# concatenate all chapters to ???.htm, in order of number
# for each book name...
#   ls ???*.htm | sort > ???-chapters.txt
#     for each in ???-chapters.txt, append it to ???.htm
# make a list of chapters
# ...


while read BOOK; do
  printf " ${BOOK}"
  if [ -f "${BOOK}"02.htm ] || [ -f "${BOOK}"002.htm ]; then
    ls "${BOOK}"?*.htm | sort > "${BOOK}"-chapters.txt &&
    while read CHAPTER; do
      cat "${CHAPTER}" >> "${BOOK}".htm
    done < "${BOOK}"-chapters.txt
  fi
done < books.txt

printf .

# cleanup
rm ????*.htm ; rm *chapters.txt

#################


# attach ending to main pages
while read; do echo "</div></body></html>" >> "${REPLY}".htm; done < books.txt

# cleanup
rm books.txt
printf .



# ----------------------------------------------------------
# expand book filenames

# weird abbreviations
# most book name abbreviations are the first 3 letters.
# not these:
#      first 3
# JDG  JUD
# SNG  SON
# EZK  EZE
# JOL  JOE
# NAM  NAH
# JHN  JOH
# JAS  JAM
# 2JN  2JO
# 3JN  3JO

# use full name, avoid arbitrary abbreviations
mv GEN.htm genesis.htm
mv EXO.htm exodus.htm
mv LEV.htm leviticus.htm
mv NUM.htm numbers.htm
mv DEU.htm deuteronomy.htm

mv JOS.htm joshua.htm
mv JDG.htm judges.htm
mv 1SA.htm 1samuel.htm
mv 2SA.htm 2samuel.htm
mv 1KI.htm 1kings.htm
mv 2KI.htm 2kings.htm
mv ISA.htm isaiah.htm
mv JER.htm jeremiah.htm
mv EZK.htm ezekiel.htm
mv HOS.htm hosea.htm
mv JOL.htm joel.htm
mv AMO.htm amos.htm
mv OBA.htm obadiah.htm
mv JON.htm jonah.htm
mv MIC.htm micah.htm
mv NAM.htm nahum.htm
mv HAB.htm habakkuk.htm
mv ZEP.htm zephaniah.htm
mv HAG.htm haggai.htm
mv ZEC.htm zechariah.htm
mv MAL.htm malachi.htm

mv PSA.htm psalms.htm
mv PRO.htm proverbs.htm
mv JOB.htm job.htm
mv SNG.htm songofsolomon.htm
mv RUT.htm ruth.htm
mv LAM.htm lamentations.htm
mv ECC.htm ecclesiastes.htm
mv EST.htm esther.htm
mv DAN.htm daniel.htm
mv EZR.htm ezra.htm
mv NEH.htm nehemiah.htm
mv 1CH.htm 1chronicles.htm
mv 2CH.htm 2chronicles.htm

mv MAT.htm matthew.htm
mv JHN.htm john.htm
mv REV.htm revelation.htm

mv JAS.htm james.htm
mv 1PE.htm peter.htm
mv 1JN.htm 1john.htm
mv 2JN.htm 2john.htm
mv 3JN.htm 3john.htm
mv JUD.htm jude.htm
printf .



# ----------------------------------------------------------
# remove longform titles

# remove any preceding "The "
sed -i "s/<div class='mt'>The /<div class='mt'>/" *.htm

# after removing "The ", replace "First Book of" with "1", and for 2
sed -i "s/<div class='mt'>First Book of/<div class='mt'>1/" *.htm
sed -i "s/<div class='mt'>Second Book of/<div class='mt'>2/" *.htm

# after removing "The ", remove "Letter from" (James, Jude)
sed -i "s/<div class='mt'>Letter from/<div class='mt'>/" *.htm

# since 2 peter is out, use "peter" instead of "1 peter"
sed -i "s/Peter’s First Letter/Peter/" peter.htm

# john 1 2 3
sed -i "s/<div class='mt'>John’s First Letter/<div class='mt'>1 John/" 1john.htm
sed -i "s/<div class='mt'>John’s Second Letter/<div class='mt'>2 John/" 2john.htm
sed -i "s/<div class='mt'>John’s Third Letter/<div class='mt'>3 John/" 3john.htm

# revelation
sed -i "s/<div class='mt'>Revelation to John/<div class='mt'>Revelation/" revelation.htm
printf .

# ----------------------------------------------------------
# prepare psalms for formatting

# enable psalm chapter labels even when no chapter labels elsewhere
sed -i 's/chapterlabel/psalmlabel/g' psalms.htm
printf .





# ----------------------------------------------------------
# ----------------------------------------------------------
# ------- BEGIN SCRIPTURE TEXT TRANSLATION REVISIONS -------
# ----------------------------------------------------------
# ----------------------------------------------------------

# order of revisions/edits:
# 1. specific edits, grouped by topic, chronological order
# 2. bulk edits, grouped by topic, chronological order

# some edits rely on previous edits, so order is important.
# for example, the virgin birth edit relies on the word
# "husband", so it must be performed before all instances
# of "husband" are changed to "man".

# this order helps make it clear exactly how the WEB is
# being revised before bulk edits are applied, and so
# modifications to bulk changes can be done quickly and
# easily, without interfering with specific edits. also,
# this way, any edit can be commented out easily,
# whereas if bulk edits were first, then commenting out
# the bulk edit might break a specific edit.






# ----------------------------------------------------------
# ------------------- SPECIFIC EDITS -----------------------
# ----------------------------------------------------------





# ----------------------------------------------------------
# USE LXX DATES FOR GENESIS 5 and 11 CHRONOLOGY

# edit ages from masoretic to septuagint record

# the following site will be the basis for this genesis 5 & 11 chronology
# revision, except cainan, son of arpachshad, will not be added.

# https://www.bible.ca/manuscripts/Bible-chronology-charts-age-of-earth-date-Genesis-5-11-Septuagint-text-LXX-original-autograph-corrupted-Masoretic-MT-primeval-5554BC.htm



# genesis 5:3
sed -i 's/Adam lived one hundred thirty years/Adam lived two hundred thirty years/' genesis.htm

# genesis 5:4
sed -i 's/Adam after he became the father of Seth were eight hundred years/Adam after he became the father of Seth were seven hundred years/' genesis.htm



# genesis 5:6
sed -i 's/Seth lived one hundred five years, then became the father of Enosh/Seth lived two hundred five years, then became the father of Enosh/' genesis.htm

# genesis 5:7
sed -i 's/Seth lived after he became the father of Enosh eight hundred seven years/Seth lived after he became the father of Enosh seven hundred seven years/' genesis.htm



# genesis 5:9
sed -i 's/Enosh lived ninety years, and became the father of Kenan/Enosh lived one hundred ninety years, and became the father of Kenan/' genesis.htm

# genesis 5:10
sed -i 's/Enosh lived after he became the father of Kenan eight hundred fifteen years/Enosh lived after he became the father of Kenan seven hundred fifteen years/' genesis.htm



# genesis 5:12
sed -i 's/Kenan lived seventy years, then became the father of Mahalalel/Kenan lived one hundred seventy years, then became the father of Mahalalel/' genesis.htm

# genesis 5:13
sed -i 's/Kenan lived after he became the father of Mahalalel eight hundred forty years/Kenan lived after he became the father of Mahalalel seven hundred forty years/' genesis.htm



# genesis 5:15
sed -i 's/Mahalalel lived sixty-five years, then became the father of Jared/Mahalalel lived one hundred sixty-five years, then became the father of Jared/' genesis.htm

# genesis 5:16
sed -i 's/Mahalalel lived after he became the father of Jared eight hundred thirty years/Mahalalel lived after he became the father of Jared seven hundred thirty years/' genesis.htm



# genesis 5:21
sed -i 's/Enoch lived sixty-five years, then became the father of Methuselah/Enoch lived one hundred sixty-five years, then became the father of Methuselah/' genesis.htm

# genesis 5:22
sed -i 's/After Methuselah’s birth, Enoch walked with God for three hundred years/After Methuselah’s birth, Enoch walked with God for two hundred years/' genesis.htm





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
# also, if it were 167, then methuselah survived 14 years after the flood.

# no change
# Methuselah lived one hundred eighty-seven years, then became the father of Lamech





# genesis 5:28

# 182 NEEDS VERIFICATION!

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





# genesis 5:30
sed -i 's/Lamech lived after he became the father of Noah five hundred ninety-five years/Lamech lived after he became the father of Noah five hundred sixty-five years/' genesis.htm

# genesis 5:31
sed -i 's/All the days of Lamech were seven hundred seventy-seven years/All the days of Lamech were seven hundred fifty-three years/' genesis.htm

printf .




# genesis 11:12

# do not add cainan.

# according to the following answer, early lxx manuscripts don't have cainan, son of arpachshad. thus, perhaps cainan was added to conform to luke, which in turn may have been corrupted in order to have groups of 7 generations culminating in jesus being 77th from adam.
# https://hermeneutics.stackexchange.com/questions/26768/are-there-any-manuscripts-that-confirm-genealogy-in-the-septuagints-genesis-5

# also, the ages for cainan are not unique, which supports the above theory: cainan's ages are 130 and 330, identical to shelah's. it seems cainan was injected, and shelah's ages were copied.

sed -i 's/Arpachshad lived thirty-five years and became the father of Shelah/Arpachshad lived one hundred thirty-five years and became the father of Shelah/' genesis.htm




# genesis 11:13

# VERY DIFFICULT: writing in WEB (masoretic) style, recreating this verse from lxx
# masoretic/web uses "then he died", instead if "and he died" like in lxx.
# but.. the list in chapter 11 never uses either phrase, so i will recreate based on that structure.

#sed -i 's/Arpachshad lived four hundred three years after he became the father of Shelah, and became the father of more sons and daughters/Arpachshad lived four hundred thirty years after he became the father of Cainan, and became the father of more sons and daughters\. Cainan lived one hundred thirty years, and became the father of Shelah\. Cainan lived three hundred thirty years after he became the father of Shelah, and became the father of more sons and daughters/' genesis.htm

# do not add cainan (do not recreate anything). easier, but not using this translation because it is easier.

sed -i 's/Arpachshad lived four hundred three years after he became the father of Shelah/Arpachshad lived four hundred thirty years after he became the father of Shelah/' genesis.htm


# genesis 11:14
sed -i 's/Shelah lived thirty years, and became the father of Eber/Shelah lived one hundred thirty years, and became the father of Eber/' genesis.htm



# genesis 11:15
sed -i 's/Shelah lived four hundred three years after he became the father of Eber/Shelah lived three hundred thirty years after he became the father of Eber/' genesis.htm



# genesis 11:16
sed -i 's/Eber lived thirty-four years, and became the father of Peleg/Eber lived one hundred thirty-four years, and became the father of Peleg/' genesis.htm



# genesis 11:17
# masoretic says 430.
# lxx2012 says 270.
# bible.ca (see above) site says 370.
# lxx pdf from archive.org says 370. (archive.org ark 13960 t83j67m4m)

sed -i 's/Eber lived four hundred thirty years after he became the father of Peleg/Eber lived three hundred seventy years after he became the father of Peleg/' genesis.htm



# genesis 11:18
sed -i 's/Peleg lived thirty years, and became the father of Reu/Peleg lived one hundred thirty years, and became the father of Reu/' genesis.htm



# genesis 11:20
sed -i 's/Reu lived thirty-two years, and became the father of Serug/Reu lived one hundred thirty-two years, and became the father of Serug/' genesis.htm



# genesis 11:22
sed -i 's/Serug lived thirty years, and became the father of Nahor/Serug lived one hundred thirty years, and became the father of Nahor/' genesis.htm



# genesis 11:24
# masoretic: 29
# lxx2012: 179
# site bible.ca: 79
# lxx pdf from archive.org (ark 13960 t83j67m4m): 79

sed -i 's/Nahor lived twenty-nine years, and became the father of Terah/Nahor lived seventy-nine years, and became the father of Terah/' genesis.htm



# genesis 11:25
# masoretic 119
# lxx2012 125
# site 129
# lxx archive 129
# nets 129

sed -i 's/Nahor lived one hundred nineteen years after he became the father of Terah/Nahor lived one hundred twenty-nine years after he became the father of Terah/' genesis.htm


printf .






# ----------------------------------------------------------
# credit for righteousness

# restore the meaning of the hebrew
# moses credited yahweh, not the other way around
# see the video "#3 Dr. Anthony Buzzard Fighting Back Against Pauline Canon Overeach Ep 3 of JWO Canon Movements"
# https://www.youtube.com/watch?v=EnkfoNGfrnE
# at around 28:00

# article by michael peterson:
# https://www.academia.edu/33326228/Whose_Righteousness_Gods_or_Abrams_Another_look_at_Genesis_15_6

# genesis 15:6
sed -i 's/He believed in Yahweh, who credited it to him for righteousness/He believed in Yahweh, and credited it to him for righteousness/' genesis.htm







# ----------------------------------------------------------
# marry vs take

# marry is a modern word

# Genesis 19:14
#sed -i 's/who were pledged to marry his daughters/who took his daughters/' genesis.htm








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
sed -i 's/Listen to this word, you cows of Bashan, who are on the mountain of Samaria, who oppress the poor, who crush the needy, who tell their husbands, “Bring us drinks!”/Listen to this word, you cows of Bashan, who are on the mountain of Samaria, who oppress the poor, who crush the needy, who tell their lords, “Bring us drinks!”/' amos.htm

# baal, owners
# Esther 1:17
sed -i 's/causing them to show contempt for their husbands when it is reported/causing them to show contempt for their owners when it is reported/' esther.htm

# baal, owners
# Esther 1:20
sed -i 's/all the wives will give their husbands honor/all the wives will give their owners honor/' esther.htm




# HUSBAND SINGULAR
# (one occurrance per verse unless noted)

# "man"
# gen 3:6 3:16 16:3 29:32 29:34 30:15 30:18 30:20

# "brother-in-law"
# gen 38:8
sed -i 's/husband’s brother/brother-in-law/' genesis.htm

# Exodus 21:22
sed -i 's/he shall be surely fined as much as the woman’s husband demands and the judges allow/he shall be surely fined as much as the woman’s owner demands and the judges allow/' exodus.htm

# "man"
# lev 21:3 21:7
# num 5:13 5:19 5:20 5:27 5:29 30:6 30:7 30:8 30:10 30:11 30:12x2 30:13x2 30:14

# Deuteronomy 21:13
sed -i 's/After that you shall go in to her and be her husband, and she shall be your/After that you shall go in to her and be her owner, and she shall be your/' deuteronomy.htm

# owned by an owner
# בעלב-בעל
# baal-baal
# Deuteronomy 22:22
sed -i 's/If a man is found lying with a woman married to a husband, then they shall both die, the man who lay with the woman and the woman\. So you shall remove the evil from Israel/If a man is found lying with a woman owned by an owner, then they shall both die, the man who lay with the woman and the woman\. So you shall remove the evil from Israel/' deuteronomy.htm

# "man"
# deu 22:23 24:3x2

# Deuteronomy 24:4
sed -i 's/her former husband, who sent her away, may not take her again to be his wife after she is defiled/her former owner, who sent her away, may not take her again to be his wife after she is defiled/' deuteronomy.htm

# "brother-in-law"
# deu 25:5x2 25:7x2
sed -i 's/husband’s brother/brother-in-law/g' deuteronomy.htm

# "man" from איש and in proverbs 6:34 גבר
# deu 25:11 28:56
# jud 13:6 13:9 13:10 14:15 19:3 20:4
# rut 1:3 1:5 1:9 1:12x2 2:1 2:11
# 1sa 1:8 1:22 1:23 2:19 4:19 4:21 25:19
# 2sa 3:15 3:16 11:26 14:5 14:7
# 2ki 4:1 4:9 4:14 4:22 4:26
# pro 6:34 7:19

# Proverbs 12:4
sed -i 's/A worthy woman is the crown of her husband/A worthy woman is the crown of her owner/' proverbs.htm

# Proverbs 31:11
sed -i 's/The heart of her husband trusts in her/The heart of her owner trusts in her/' proverbs.htm

# Proverbs 31:23
sed -i 's/Her husband is respected in the gates/Her owner is respected in the gates/' proverbs.htm

# Proverbs 31:28
sed -i 's/Her husband also praises her/Her owner also praises her/' proverbs.htm

# Isaiah 54:5
sed -i 's/For your Maker is your husband/For your Maker is your owner/' isaiah.htm

# Jeremiah 3:14
sed -i 's/Return, backsliding children,” says Yahweh, “for I am a husband to you/Return, backsliding children,” says Yahweh, “for I am an owner to you/' jeremiah.htm

# friend not owner
# (wife in this verse should be be woman)
# Jeremiah 3:20
sed -i 's/treacherously departs from her husband/treacherously departs from her friend/' jeremiah.htm

# "man"
# jer 6:11

# Jeremiah 31:32
sed -i 's/although I was a husband to them/although I was an owner to them/' jeremiah.htm

# "man"
# eze 16:32 16:45 44:25
# hos 2:2 2:7 2:16

# Joel 1:8
sed -i 's/for the husband of her youth/for the owner of her youth/' joel.htm





# ----------------------------------------------------------------------
# restore many instances of baal meaning owner (i.e. not just a name)
# restore man to owner when root is baal
# searched hebModern bible in "and" bible for בעל, and here are matches:

# owned by an owner
# בעלב-בעל
# baal-baal
# Genesis 20:3
#sed -i 's/Behold, you are a dead man, because of the woman whom you have taken; for she is a man’s wife/Behold, you are a dead man, because of the woman whom you have taken; for she is an owner’s wife/' genesis.htm
sed -i 's/Behold, you are a dead man, because of the woman whom you have taken; for she is a man’s wife/Behold, you are a dead man, because of the woman whom you have taken; for she is owned by an owner/' genesis.htm

# baal
# gen 36:38 36:39

# Genesis 37:19
sed -i 's/They said to one another, “Behold, this dreamer comes/They said to one another, “Behold, this owner of dreams comes/' genesis.htm

# baal
# exo 14:2 14:9

# Exodus 21:3
sed -i 's/If he comes in by himself, he shall go out by himself\. If he is married, then his wife shall go out with him/If he comes in by himself, he shall go out by himself\. If he is the owner of a woman, then his wife shall go out with him/' exodus.htm

# husband (will have already been changed to man)
# exo 21:22

# already owner
# Exodus 21:34
#sed -i 's/the owner of the pit shall make it good\. He shall give money to its owner, and the dead animal shall be his/the owner of the pit shall make it good\. He shall give money to its owner, and the dead animal shall be his/' exodus.htm

# Exodus 22:8
sed -i 's/then the master of the house shall come near to God/then the owner of the house shall come near to God/' exodus.htm

# mechanical translation says:
#   'The phrase “master of words” apparently means “one with a dispute.”'
#   but there is no explanation why, and no further reference
#   smith's literal translation at least has 'words'
# Exodus 24:14
sed -i 's/Behold, Aaron and Hur are with you\. Whoever is involved in a dispute can go to them/Behold, Aaron and Hur are with you\. Whoever is an owner of words can go to them/' exodus.htm

# Leviticus 21:4
sed -i 's/He shall not defile himself, being a chief man among his people, to profane himself/He shall not defile himself, being an owner among his people, to profane himself/' leviticus.htm

# baal
# num 22:41 32:38 33:7
# deu 4:3

# Deuteronomy 15:2
sed -i s'/This is the way it shall be done: every creditor shall release that which he has lent to his neighbor/This is the way it shall be done: every owner of a loan shall release that which he has lent to his neighbor/' deuteronomy.htm

# yoke
# deu 21:3

# husband
# deu 22:22

# baal
# jos 11:17 13:17 15:60 18:14
# jud 3:3 8:33 9:4

# Judges 19:22
sed -i 's/and they spoke to the master of the house, the old man/and they spoke to the owner of the house, the old man/' judges.htm

# Judges 19:23
sed -i 's/The man, the master of the house, went out to them, and said to them/The man, the owner of the house, went out to them, and said to them/' judges.htm

# baal
# 2sa 5:20

# Smith's Literal Translation
#   And they will say to him, A man possessing hair
# 2 Kings 1:8
sed -i 's/They answered him, “He was a hairy man, and wearing a leather belt around his waist/They answered him, “He was a man, an owner of hair, and wearing a leather belt around his waist/' 2kings.htm

# baal
# 1ch 1:49 1:50 4:33 5:5 5:23 8:34 9:40 14:11 27:28
# 2ch 26:7

# ezra 4:8 4:9 and 4:17
sed -i 's/Rehum the chancellor/Rehum the owner of taste/g' ezra.htm

# bird (owner of wings)
# Proverbs 1:17
sed -i 's/For the net is spread in vain in the sight of any bird/For the net is spread in vain in the sight of any owner of wings/' proverbs.htm

# Proverbs 22:24
sed -i 's/Don’t befriend a hot-tempered man/Don’t befriend a hot-tempered owner/' proverbs.htm

# Proverbs 23:2
sed -i 's/put a knife to your throat if you are a man given to appetite/put a knife to your throat if you are an owner given to appetite/' proverbs.htm

# Proverbs 24:8
sed -i 's/One who plots to do evil will be called a schemer/One who plots to do evil will be called an owner of wicked thoughts/' proverbs.htm

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
# Joshua 24:11
#sed -i 's/The men of Jericho fought against you/The owners of Jericho fought against you/' joshua.htm

# Judges 9:2
#sed -i 's/Please speak in the ears of all the men of Shechem/Please speak in the ears of all the owners of Shechem/' judges.htm







# ----------------------------------------------------------
# trinity

# fix bad grammar and capitalization that attempts to prove trinity

# whole series of edits needs more references
# https://www.youtube.com/watch?v=KqPagPOlU7M

# exodus 3:14
sed -i 's/I AM WHO I AM/I will be what I will be/' exodus.htm
sed -i 's/I AM/I will be/' exodus.htm



# restore matt 3:17 which apparently originally said "today i have begotten thee", which was removed because it disproves the trinity doctrine.
# see jesus' words only videos and/or site for supporting references,
# eslecially https://www.youtube.com/watch?v=cfRzYqpXchM
# psalms 2:7
# I will tell of the decree: Yahweh said to me, “You are my son. Today I have become your father.

# work toward restoring. use "his" not "you" to match sentence
# matthew 3:17
sed -i 's/This is my beloved Son, with whom I am well pleased/This is my beloved Son, with whom I am well pleased\. Today I have become his father/' matthew.htm


# restore "the father" to matthew 19:17

# Still further also He plainly says, "None is good, but My Father, who is in heaven."
# http://earlychristianwritings.com/text/clement-instructor-book1.html

# There still remains to them, however, that saying of the Lord in the Gospel, which they think is given them in a special manner as a shield, viz., "There is none good but one, God the Father."
# http://earlychristianwritings.com/text/origen123.html

# also note that the words "that is" were inserted by translators, and do not reflect the greek.

# matthew 19:17
sed -i 's/No one is good but one, that is, God/No one is good but one, God the Father/' matthew.htm


# "I was" also supported by Lamsa Bible and Anderson New Testament
# https://www.biblehub.com/parallel/john/8-58.htm
# john 8:58
sed -i 's/before Abraham came into existence, I AM/before Abraham came into existence, I was/' john.htm














# ----------------------------------------------------------
# virgin birth

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
# note that it says bith 'out of your body' (i.e., not by holy spirit), and 'i will be his father' (at the baptism this is fulfilled, see psalm 2:7 and matthew 3:17 as it is restored)

# jeremiah 22:30
# Yahweh says, “Record this man as childless, a man who will not prosper in his days; for no more will a man of his offspring prosper, sitting on David’s throne and ruling in Judah.”
# note that the passage is apparently talking about jechoniah, and that this same jechoniah appears in the matthew chapter 1 geneology.



# edit isaiah 7:14, which should not be taken as prophecy about jesus anyway
# the word in isaiah 7:14 means young woman, not virgin, which is
# also supported in translations: GNT, JPS, NAB, NET, NRSV
# and ISR reads: maiden

# isaiah 7:14
sed -i 's/Behold, the virgin will conceive, and bear a son, and shall call his name Immanuel/Behold, the young woman will conceive, and bear a son, and shall call his name Immanuel/' isaiah.htm




# remove matthew 1 completely, as it seems to be an addition to the original
sed -i 's/<div class='"'"'chapterlabel'"'"' id="V0"> 1<.*until she had given birth to her firstborn son\. He named him Jesus\. <\/div>//' matthew.htm

# starting with "Now" is awkward. prefer translation that starts with "When",
# as in the CEV, Geneva Bible of 1587, etc.
# remove word "Now"
sed -i 's/Now when Jesus was born in Bethlehem of Judea in the days of King Herod/When Jesus was born in Bethlehem of Judea in the days of King Herod/' matthew.htm






# ----------------------------------------------------------
# put away vs divorce

# there is a difference.
# the webp version seems accurate in matthew 5, not matthew 19.
# the kjv seems to be more accurate than other popular translations.
# the kjv seems accurate in mattew 19, but not all of matthew 5.
# the scriptures 1998 by isr seems accurate in all cases (matthew 5 & 19)

# Matthew 19:8
sed -i 's/Moses, because of the hardness of your hearts, allowed you to divorce your wives, but from the beginning it has not been so/Moses, because of the hardness of your hearts, allowed you to put away your wives, but from the beginning it has not been so/' matthew.htm

# Matthew 19:9
sed -i 's/I tell you that whoever divorces his wife, except for sexual immorality, and marries another, commits adultery; and he who marries her when she is divorced commits adultery/I tell you that whoever puts away his wife, except for sexual immorality, and marries another, commits adultery; and he who marries her when she is put away commits adultery/' matthew.htm





# ----------------------------------------------------------
# do not swear

# it has been said that in matthew 5, the messiah did not say "do not swear",
# but rather "do not swear in vain".

# there is an article at jesuswordsonly.github.io that talks about this

# also see hebrew gospel of matthew, george howard, in footnotes

# not sure this makes sense to edit, no change for now.

# matthew 5:34 edit "do not swear" to "do not swear in vain"
# ...





# ----------------------------------------------------------
# seat of moses

# Matthew 23:3
# All things therefore whatever they tell you to observe,
# observe and do, but don’t do their works; for they say,
# and don’t do.
# - WEBP
#
# Matthew 23:3
# Therefore all that he says to you, diligently do, but
# according to their reforms and their precedents do not do,
# because they talk, but they do not do.
# - translation from "the hebrew yeshua vs the greek jesus"
# by nehemia gordon, pg 48.
#
# Perhaps instead of "Therefore", "Now" or "And now".
# but just do the minimal change necessary
#
sed -i 's/whatever they tell you to observe/whatever he tells you to observe/' matthew.htm




printf .










# ----------------------------------------------------------
# ---------------------- BULK EDITS ------------------------
# ----------------------------------------------------------






# ----------------------------------------------------------
# yahweh's title

# in nt edit "god" to "theos" or "theon" or "theou"?
# it would require extra work to use each type,
# which is currently outside the scope of this project,
# and not necessarily desirable, because replacing all instances the same
# way is consistent
# ...
# edit "god" to "elohim"
# see isaiah 65:11 in hebrew, and also in various english translations
# also dig for info regarding true etymology of "god", and you may find that
# its origin is from the name of a false deity

# since there seems to be no equivalent english word for translation, then
# transliterate from hebrew: "elohim"

# 19 instances
sed -i 's/ a God/ an Elohim/g' *.htm

# 11 instances
sed -i 's/ a god/ an elohim/g' *.htm

# 703 instances (722 instances of 'God' minus 19 already replaced above = 703)
sed -i 's/God/Elohim/g' *.htm

# 153 instances (164 instances of 'god' minus 11 already replaced above = 153)
sed -i 's/god/elohim/g' *.htm

# 0 instances of "GOD" all-uppercase were found in 2023-02-20 edition of WEBP

printf .




# ----------------------------------------------------------
# yhwh vowels: sheva cholem qamats

# see book(s) by nehemia gordon

sed -i 's/Yahweh/Yehovah/g' *.htm
sed -i 's/YAHWEH/YEHOVAH/g' *.htm





# ----------------------------------------------------------
# set-apart

# the term "holy" does not seem to convey the meaning of קדש

# edit "holy", a word associated with the sun, and sun worship,
# to "set-apart", which is a more straightforward meaning of קדש

sed -i 's/holy/set-apart/g' *.htm

# capitalize "apart" because it may be in a title mid-sentence, and because
# it is difficult to differentiate between when it is at the beginning of a
# sentence vs mid-sentence.
sed -i 's/Holy/Set-Apart/g' *.htm

sed -i 's/HOLY/SET-APART/g' *.htm


printf .



# ----------------------------------------------------------
# husband and wife

# there is no "wife" or "husband" in hebrew or greek, just man and woman, etc.
sed -i 's/husbands/men/g' *.htm
sed -i 's/husband/man/g' *.htm

sed -i 's/wives/women/g' *.htm
sed -i 's/wife/woman/g' *.htm

# revert back for term 'midwife'
sed -i 's/midwomen/midwives/g' *.htm
sed -i 's/midwoman/midwife/g' *.htm


printf .


# ----------------------------------------------------------
# the messiah's name

# the messiah's name has been transliterated many ways:
# yahshua, yahushua, yeshua, iesou, iesous, iesus, jesus

# a history of the name can be found here:
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

# edit "jesus" to "yeshua"
sed -i 's/Jesus/Yeshua/g' *.htm
sed -i 's/JESUS/YESHUA/g' *.htm

# no instances of "jesus" all-lowercase were found on last check



# do not edit "christ" to "messiah"

# editing "christ" to "messiah" would create a confusing translation.
# the term "messiah" is already used in john, distinct from the word "christ"






# ----------------------------------------------------------
# ---------------- post-translation tasks ------------------
# ----------------------------------------------------------

# ----------------------------------------------------------
# rename .htm files

# the current standard extension for html files is ".html"
# the extension ".htm" is an old standard

# create a list
ls -1 *.htm | sed 's/\.htm//' > books2.txt

# change filenames from .htm to .html
while read; do mv "${REPLY}".htm "${REPLY}".html; done < books2.txt

# cleanup
rm books2.txt






echo " Done."
