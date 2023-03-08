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
# trinity

# fix bad grammar and capitalization that attempts to prove trinity

# whole series of edits needs more references
# https://www.youtube.com/watch?v=KqPagPOlU7M

sed -i 's/I AM WHO I AM/I will be what I will be/' exodus.htm

sed -i 's/I AM/I will be/' exodus.htm




# "I was" also supported by Lamsa Bible and Anderson New Testament
# https://www.biblehub.com/parallel/john/8-58.htm

# john 8:58
sed -i 's/before Abraham came into existence, I AM/before Abraham came into existence, I was/' john.htm







# ----------------------------------------------------------
# virgin birth

# after the bible was written,
# the text was corrupted to create a virgin birth story.
# see youtube.com/@jesuswordsonly and search videos for "virgin"

# jesus must be a real descendant of david if he is to fulfill 2sam7:15,
# not just a symbolic descendant.

# what is the point of the geneology in matthew if there is no real connection?
# this indicates in favor of there being a real connection.

# also, matthew 1:1 testifies that jesus is the son of david, and son of
# abraham. without using strange doctrine, this plainly indicates that jesus
# was a natural descendant of david and abraham.



# edit isaiah 7:14, which should not be taken as prophecy about jesus anyway
# the word in isaiah 7:14 means young woman, not virgin, which is
# also supported in translations: GNT, JPS, NAB, NET, NRSV
# and ISR reads: maiden

# isaiah 7:14
sed -i 's/Behold, the virgin will conceive, and bear a son, and shall call his name Immanuel/Behold, the young woman will conceive, and bear a son, and shall call his name Immanuel/' isaiah.htm




# jechoniah problem. see jeremiah 22:30

# the ebionites had scripture that didn't have a geneology.
# without a geneology, the jechoniah problem would effectively not exist.
# perhaps yahweh reversed the curse with zerubbabel

# jechoniah problem 1 of 2
# matthew 1:11
# Josiah became the father of Jechoniah and his brothers at the time of the exile to Babylon.  
# ...

# jechoniah problem 2 of 2
# matthew 1:12
# After the exile to Babylon, Jechoniah became the father of Shealtiel. Shealtiel became the father of Zerubbabel.  
# ...




# matthew 1:16

# could use verification on manner of restoration. see jwo videos on "virgin"

# without the phrase "who is called christ", the next passage that refers to christ seems awkward. however, i am going by the indication that there is a statement very plain that, when translated, reads "joseph begat jesus." period.

# editing this is a bit tricky because there is a footnote in the middle of the verse, and there are 3 places with the text "who is called Christ". only 1 ends in a period, so that will be used to identify this instance.
sed -i 's/Jacob became the father of Joseph, the husband of Mary, from whom was born Jesus,.* who is called Christ\./Jacob became the father of Joseph\. Joseph became the father of Jesus\./' matthew.htm




# matthew 1:18-24
# this virgin birth story needs to be removed entirely, including verse numbers.
# the combination '"'"' represents a single quote. alternatively, use \x27
sed -i 's/<div class='"'"'p'"'"'> <span class="verse" id="V18">.*until she had given birth to her firstborn son\. He named him Jesus\. <\/div>//' matthew.htm














# ----------------------------------------------------------
# do not swear

# not sure this makes sense to edit

# matthew 5:34 edit "do not swear" to "do not swear in vain"
# see hebrew gospel of matthew, george howard
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
# by nehemiah gordon, pg 48.
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

sed -i 's/God/Elohim/g' *.htm
sed -i 's/god/elohim/g' *.htm

# no instances of "GOD" all-uppercase were found on last check

printf .




# ----------------------------------------------------------
# set-apart

# the term "holy" does not seem to convey the meaning of קדש

# edit "holy", a word associated with the sun, and sun worship,
# to "set-apart", which is the meaning of קדש

sed -i 's/holy/set-apart/g' *.htm

# capitalize "apart" because it may be in a title mid-sentence, and because
# it is difficult to differentiate between when it is at the beginning of a
# sentence vs mid-sentence.
sed -i 's/Holy/Set-Apart/g' *.htm

sed -i 's/HOLY/SET-APART/g' *.htm


printf .



# ----------------------------------------------------------
# husband and wife

# there is no "wife" or "husband" in hebrew or greek, just man and woman
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

# in light of all this, this is an english language translation, so for the
# purposes of this edition, the familiar form is retained.

# edit "jesus" to "yahshua"
#sed -i 's/Jesus/Yahshua/g' *.htm
#sed -i 's/JESUS/YAHSHUA/g' *.htm

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
