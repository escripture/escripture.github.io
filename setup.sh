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
#       the 2023-06-06 version (changelog has it as 2023-06-07)
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
# 1. run setup.sh (this file) in clean directory that also has eng-web_usfm.zip
# 2. (optional) copy all html files to a subdirectory named "book"
# 3. (optional) make sure index.html, style.css, and caslon.ttf, are
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
unzip -q 'eng-web_usfm.zip'
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

# remove book written by same person who wrote acts
rm *LUK*.usfm

# remove text perhaps by barnabas, paul's associate
rm *HEB*.usfm

# remove text considered pseudopigraphical
rm *2PE*.usfm

# remove text written by silvanus, companion of paul
# see https://www.the-iconoclast.org/reference/saul-of-tarsus.php#id.10
rm *1PE*.usfm

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



# ------------------------------------------------------------------------------
# avoid two spaces

# reduce two adjacent spaces to just one space
sed -i 's/  / /g' *.usfm






# ------------------------------------------------------------------------------
# UNOFFICIAL TYPO CORRECTIONS
# fix issues upstream should fix
# depends on single character (nbsp) inserted between quotes
# ------------------------------------------------------------------------------



# 2ch 32:11
sed -i 's/king of Assyria?’/king of Assyria’?/' 2chronicles.usfm
# NOT implemented upstream

# jer 26:9
sed -i 's/without inhabitant?’.”/without inhabitant’?”/' jeremiah.usfm
# NOT implemented

# SAME ISSUE AS OTHERS PLUS SPECIAL CASE OF WRONG NESTING.
# FOR HTML: REMEMBER TO USE NBSP (NON-BREAKING SPACE) BETWEEN QUOTE MARKS!
# OTHER VERSES IN THIS PARAGRAPH AGREE WITH THE CORRECTED FORM (NOT CURRENT FORM)
# jer 36:29
sed -i 's/“Why have you written therein, saying, ‘The king of Babylon will certainly come and destroy this land, and will cause to cease from there man and animal?’.”.’/‘Why have you written therein, saying, “The king of Babylon will certainly come and destroy this land, and will cause to cease from there man and animal”?’ ”/' jeremiah.usfm
# NOT implemented

# job 6:22 (1 of 2)
sed -i 's/Give to me?’/Give to me’?/' job.usfm
# NOT implemented

# job 6:22 (2 of 2)
sed -i 's/from your substance?’/from your substance’?/' job.usfm
# NOT implemented

# joh 12:34
sed -i 's/must be lifted up?’/must be lifted up’?/' john.usfm
# NOT implemented

# SHOULD BE JUST A PERIOD, NOT A QUESTION MARK
# mat 23:18
#sed -i 's/he is obligated?’/he is obligated\.’/' matthew.usfm
# NOT implemented, but changed to another error, so fix:
sed -i 's/he is obligated’?/he is obligated\.’/' matthew.usfm



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









# ------------------------------------------------------------------------------
# בעל (baal) - full treatment
# every occurrence will be reviewed and revised if necessary
# this includes every inflection of בעל
# in general, the term owner will be used, except for some idioms

# the main purpose for retranslating this hebrew word is to address issues
# that are a byproduct of translating איש (man) as man, 
# and אישה (woman) as woman,
# instead of translating איש as man sometimes, and husband other times,
# and instead of translating אישה as woman sometimes, and wife other times.
# husband and wife are english terms which obfuscate the translation,
# because hebrew generally has simply man or woman. however, sometimes the term
# "owner" is used to refer to a man who possesses a woman, so that must be
# addressed. but to do that fairly in a balanced way, every occurrence of the
# root word בעל (owner, or master) must be addressed.



# sources where the word בעל means MASTER
#   webp: hosea 2:16 husband (איש) vs master (בעל)
#   https://www.mechanical-translation.org/mtt/D22.html
#   https://en.wiktionary.org/wiki/%D7%91%D7%A2%D7%9C
#   https://www.biblehub.com/jeremiah/3-14.htm

# sources where the word בעל means OWNER
#   https://www.biblehub.com/hebrew/1167.htm
#   https://en.wikipedia.org/wiki/Baal
#   https://dictionary.reverso.net/hebrew-english/%D7%91%D7%A2%D7%9C
#   Gesenius "to have dominion over, to possess"



# (part 1 of 2)
# H1166 בָּעַל
# a primitive root
# occurs 16 times in 14 verses in WLC according to blueletterbible.org

# gen 20:3
sed -i 's/she is a man’s wife/she is owned by an owner/' genesis.usfm

# deu 21:13
sed -i 's/and be her husband/and be her owner/' deuteronomy.usfm

# deu 22:22
sed -i 's/woman married to a husband/woman owned by an owner/' deuteronomy.usfm

# deu 24:1
sed -i 's/takes a wife and marries her/takes a wife and owns her/' genesis.usfm

# 1ch 4:22
# had the dominion

# pro 30:23
sed -i 's/when she is married/when she is owned/' genesis.usfm

# isa 26:13
# have had dominion over us

# isa 54:1
sed -i 's/children of the married/children of the owned/' isaiah.usfm

# isa 54:5
sed -i 's/For your Maker is your husband/For your Maker is your owner/' isaiah.usfm

# isa 62:4 (1 of 2)
# "Beulah". A transliteration is awkward and not transparent. but it is out of
# scope to revise this. the proper scope to change this is to translate,
# instead of transliterate, every name, not just this one.

# isa 62:4 (2 of 2)
sed -i 's/land will be married/land will be owned/' isaiah.usfm

# isa 62:5 (1 of 2)
sed -i 's/young man marries a virgin/young man owns a virgin/' isaiah.usfm

# isa 62:5 (2 of 2)
sed -i 's/your sons will marry you/your sons will own you/' isaiah.usfm

# jer 3:14
sed -i 's/am a husband to you/am an owner to you/' jeremiah.usfm

# jer 31:32
sed -i 's/was a husband to them/was an owner to them/' jeremiah.usfm

# mal 2:11
sed -i 's/has married the daughter/has owned the daughter/' malachi.usfm



# (part 2 of 2)
# H1167 בַּעַל
# from H1166
# occurs 83 times in 79 verses in WLC according to blueletterbible.org

# gen 14:13
# allies of (owners of covenant)

# gen 20:3
# see part 1: H1166

# gen 37:19
# dreamer (owner of dreams)

# gen 49:23
# archers (owner of arrows)

# exo 21:3
sed -i 's/If he is married/If he is the owner of a woman/' exodus.usfm

# exo 21:22
sed -i 's/woman’s husband demands/woman’s owner demands/' exodus.usfm

# exo 21:28, 21:29 2x, 21:34 x2, 21:36
# owner

# exo 22:8
sed -i 's/then the master of the house/then the owner of the house/' exodus.usfm

# exo 22:11, 22:12, 22:14, 22:15
# owner

# benner's mechanical translation:
#   'The phrase “master of words” apparently means “one with a dispute.”'
#   but there is no explanation why, and no further reference
#   smith's literal translation at least has 'words'
# exo 24:14
# involved in a dispute (an owner of words)

# lev 21:4
sed -i 's/being a chief man/being an owner/' leviticus.usfm

# num 21:28
sed -i 's/lords of the high places/owners of the high places/' numbers.usfm

# deu 15:2
sed -i s'/every creditor shall/every owner of a loan shall/' deuteronomy.usfm

# deu 22:22
# see part 1: H1166

# deu 24:4
sed -i 's/her former husband/her former owner/' deuteronomy.usfm

# jos 24:11
sed -i 's/The men of Jericho fought against you/The owners of Jericho fought against you/' joshua.usfm

# jud 9:2
sed -i 's/Please speak in the ears of all the men of Shechem/Please speak in the ears of all the owners of Shechem/' judges.usfm

# jud 9:3
sed -i 's/spoke of him in the ears of all the men of Shechem/spoke of him in the ears of all the owners of Shechem/' judges.usfm

# jud 9:6
sed -i 's/the men of Shechem assembled/the owners of Shechem assembled/' judges.usfm

# jud 9:7
sed -i 's/listen to me, you men of Shechem/listen to me, you owners of Shechem/' judges.usfm

# jud 9:18
sed -i 's/king over the men of Shechem/king over the owners of Shechem/' judges.usfm

# jud 9:20 (1 of 2)
sed -i 's/devour the men of Shechem/devour the owners of Shechem/' judges.usfm

# jud 9:20 (2 of 2)
sed -i 's/fire come out from the men of Shechem/fire come out from the owners of Shechem/' judges.usfm

# jud 9:23 (1 of 2)
sed -i 's/Abimelech and the men of Shechem/Abimelech and the owners of Shechem/' judges.usfm

# jud 9:23 (2 of 2)
sed -i 's/the men of Shechem dealt/the owners of Shechem dealt/' judges.usfm

# jud 9:24
sed -i 's/on the men of Shechem/on the owners of Shechem/' judges.usfm

# jud 9:25
sed -i 's/The men of Shechem set/The owners of Shechem set/' judges.usfm

# jud 9:26
sed -i 's/the men of Shechem put/the owners of Shechem put/' judges.usfm

# jud 9:39
sed -i 's/Gaal went out before the men of Shechem/Gaal went out before the owners of Shechem/' judges.usfm

# jud 9:46
sed -i 's/When all the men of the tower/When all the owners of the tower/' judges.usfm

# jud 9:47
sed -i 's/that all the men/that all the owners/' judges.usfm

# jud 9:51
sed -i 's/all the men and women of the city fled there, and shut/all the men and women and all the owners of the city fled there, and shut/' judges.usfm

# jud 19:22
sed -i 's/to the master of the house/to the owner of the house/' judges.usfm

# jud 19:23
sed -i 's/man, the master of the house/man, the owner of the house/' judges.usfm

# jud 20:5
sed -i 's/the men of Gibeah/the owners of Gibeah/' judges.usfm

# 1sa 23:11
sed -i 's/the men of Keilah deliver me up/the owners of Keilah deliver me up/' 1samuel.usfm

# 1sa 23:12
sed -i 's/the men of Keilah deliver me and/the owners of Keilah deliver me and/' 1samuel.usfm

# 2sa 1:6
# horsemen (owners of horses)

# 2sa 11:26
sed -i 's/she mourned for her husband/she mourned for her owner/' 2samuel.usfm

# 2sa 21:12
sed -i 's/son from the men of Jabesh/son from the owners of Jabesh/' 2samuel.usfm

# 2ki 1:8
# "hairy man" -> "man, an owner of hair"
# Smith's Literal Translation
#   And they will say to him, A man possessing hair
# perhaps he was hairy, perhaps he had a fur coat. let the reader decide
sed -i 's/He was a hairy man, and wearing/He was a man, an owner of hair, and wearing/' 2kings.usfm

# neh 6:18
# sworn (owners of an oath)

# Esther 1:17
sed -i 's/contempt for their husbands/contempt for their owners/' esther.usfm

# Esther 1:20
sed -i 's/give their husbands honor/give their owners honor/' esther.usfm

# job 31:39
# owners

# pro 1:17
# bird (owner of wings)

# pro 1:19
# owners

# pro 3:27
# from those to whom it is due (from he who owns)

# pro 12:4
sed -i 's/crown of her husband/crown of her owner/' proverbs.usfm

# pro 16:22
# to one who has it (to one who owns it)

# pro 17:8
# him who gives it (him who owns it)
# ***** alternative translation, not relevant to scope of בעל *****
sed -i 's/A bribe is a precious stone/A gift is a precious stone/' proverbs.usfm

# pro 18:9
# a master of destruction (an owner of destruction)

# pro 22:24
# angry man (owner of anger)

# pro 23:2
# man given to appetite (owner of appetite)

# pro 24:8
# schemer (owner of mischief)

# pro 29:22
# wrathful man (owner of fury)

# pro 31:11
sed -i 's/her husband trusts/her owner trusts/' proverbs.usfm

# pro 31:23
sed -i 's/Her husband is respected/Her owner is respected/' proverbs.usfm

# pro 31:28
sed -i 's/Her husband also praises her/Her owner also praises her/' proverbs.usfm

# ecc 5:11
# owner

# ecc 5:13
# owner

# ecc 7:12
# him who has it

# ecc 8:8
# those who practice it (owners of it)

# ecc 10:11
# charmer's tongue (owner of the tongue)

# ecc 10:20
# and that which has wings (and owner of the wings)

# ecc 12:11
# the masters of assemblies (owners of assemblies)

# isa 1:3
# his master's (his owners)
# The ox knows his owner (buyer), and the donkey his master’s crib

# isa 16:8
sed -i 's/The lords of the nations/The owners of the nations/' isaiah.usfm

# isa 41:15
# with teeth (owner of teeth)

# isa 50:8
# my adversary (owner of judgement)

# jer 37:13
# a captain of the guard (owner of the ward)

# dan 8:6
# ram that had the two horns (ram owner of dual horns)

# dan 8:20
# that had the two horns (owner of dual horns)

# Joel 1:8
sed -i 's/for the husband of her youth/for the owner of her youth/' joel.usfm

# nah 1:2
# and is full of wrath (owner of fury)



# H1168 H1170 H1171 H1173 H1174 H1175 H1176 H1177 H1178 H1179 H1182
# H1183 H1184 H1185 H1186 H1187 H1188 H1189 H1190 H1191 H1192 H1193
# these instances in KJV are always transliterated as a proper name

# H1169
# ezr 4:8 4:9 and 4:17
# Rehum the chancellor (Rehum the owner of taste)



# H1172
# 1sa 28:7
# woman who has a familiar spirit (woman owner of familiar spirit)

# 1ki 17:17 and nah 3:4
# mistress (owner of house)



# H1180
# hos 2:16
sed -i 's/call me ‘my master/call me ‘my owner/' hosea.usfm

# H1181
# "no occurrences in WLC" (actually same as numbers 21:28)



# ------------------------------------------------------------------------------
# check all remaining instances of husband(s)
# change to lord(s) when root is adonai (occurs 1 time) (אדני)



# HUSBANDS PLURAL
# cases where the translation "husbands" is not based on אִישׁ (men)
# but based on בעל ("lords" or "owners")

# webp
# adonim, lords
# Amos 4:1
sed -i 's/who tell their husbands/who tell their lords/' amos.usfm



# HUSBAND SINGULAR
# (one occurrence per verse unless noted)

# "man" 8x
# gen 3:6 3:16 16:3 29:32 29:34 30:15 30:18 30:20

# "brother-in-law"
# gen 38:8
# it is the style of web/webp to use "in-law"
sed -i 's/husband’s brother/brother-in-law/' genesis.usfm
#sed -i 's/and perform the duty of a husband’s brother to her/and husband’s brother/' genesis.usfm

# "man" x17
# lev 21:3 21:7
# num 5:13 5:19 5:20 5:27 5:29 30:6 30:7 30:8 30:10 30:11 30:12x2 30:13x2 30:14

# "man" x3
# deu 22:23 24:3x2

# "brother-in-law"
# deu 25:5x2 25:7x2
sed -i 's/husband’s brother/brother-in-law/g' deuteronomy.usfm

# "man" 34x
# from איש and in proverbs 6:34 גבר
# deu 25:11 28:56
# jud 13:6 13:9 13:10 14:15 19:3 20:4
# rut 1:3 1:5 1:9 1:12x2 2:1 2:11
# 1sa 1:8 1:22 1:23 2:19 4:19 4:21 25:19
# 2sa 3:15 3:16 11:26 14:5 14:7
# 2ki 4:1 4:9 4:14 4:22 4:26
# pro 6:34 7:19

# friend not owner
# Jeremiah 3:20
sed -i 's/treacherously departs from her husband/treacherously departs from her friend/' jeremiah.usfm

# "man" 1x
# jer 6:11

# "man" 6x
# eze 16:32 16:45 44:25
# hos 2:2 2:7 2:16



# ------------------------------------------------------------------------------
# marry vs take
# TO DO: review all occurrences and implement
# marry is a modern word which obscures the meaning

# OVERVIEW

# marr: 48 lines (50 instances?)
#   27  married
#   10  marry
#    6  marriage & marriages
#    4  marries
#    2  marrow (will not be changed, obviously)
#    1  marred (will not be changed, obviously)

# marital: 1 line


# CHANGES

# married: 27 lines
# marital: 1 line (exo 21:10)

# 1ch 2:19
sed -i 's/Caleb married Ephrath/Caleb took to himself Ephrath/' 1chronicles.usfm

# 2ki 8:18
sed -i 's/for he married Ahab’s daughter/for he took to himself Ahab’s daughter/' 2kings.usfm

# deu 20:7
sed -i 's/who has pledged to be married to a wife/who has requested and been granted a wife/' deuteronomy.usfm

# deu 22:23
sed -i 's/virgin pledged to be married to a husband/virgin, who was requested and granted to a husband/' deuteronomy.usfm

# deu 22:25
sed -i 's/lady who is pledged to be married in the field/lady, who was requested and granted, in the field/' deuteronomy.usfm

# deu 22:27
sed -i 's/the pledged to be married lady cried/the lady who was requested and granted cried/' deuteronomy.usfm

# deu 22:28
sed -i 's/virgin, who is not pledged to be married, grabs/virgin, who was not requested and granted, grabs/' deuteronomy.usfm

# deu 25:5
sed -i 's/not be married outside to a stranger/not go outside to a man who is a stranger/' deuteronomy.usfm

# exo 21:8
sed -i 's/If she doesn’t please her master, who has married her to himself, then/If she is dysfunctional in the eyes of her master, who didn’t join together with her, then/' exodus.usfm

# exo 21:9
sed -i 's/If he marries her to his son/If he joins her to his son/' exodus.usfm

# exo 21:10
sed -i 's/her clothing, and her marital rights/her clothing, and her shelter/' exodus.usfm

# exo 22:16
sed -i 's/virgin who isn’t pledged to be married, and lies/virgin who wasn’t requested and granted, and lies/' exodus.usfm


# ezra 10:2
# ezra 10:10
# ezra 10:14
# ezra 10:17
# ezra 10:18
sed -i 's/married/taken/' ezra.usfm


# gen 11:29
sed -i 's/Abram and Nahor married wives/Abram and Nahor took wives/' genesis.usfm

# isa 62:4 footnote
sed -i 's/Beulah means “married”/Beulah means “owned”/' isaiah.usfm

# lev 19:20
sed -i 's/slave girl, pledged to be married to another man/slave girl, pierced to another man/' leviticus.usfm

# lev 22:12
sed -i 's/daughter is married to an outsider/daughter becomes the woman of a man who is an outsider/' leviticus.usfm

# matthew 22:25
sed -i 's/The first married and died/The first took a woman and died/' matthew.usfm

# nehemiah 13:23
sed -i 's/married/taken/' nehemiah.usfm

# numbers 12:1
sed -i 's/woman whom he had married; for he had married a Cushite/woman whom he had taken; for he had taken a Cushite/' numbers.usfm

# numbers 36:3
sed -i 's/they are married to any of the sons/they are women to any of the sons/' numbers.usfm

# numbers 36:6
sed -i 's/them be married to whom/them be women to whom/' numbers.usfm

# numbers 36:11
sed -i 's/Zelophehad, were married to their/Zelophehad, were women to their/' numbers.usfm

# numbers 36:12
sed -i 's/They were married into/They were women into/' numbers.usfm

# proverbs 30:23
sed -i 's/unloved woman when she is married/unloved woman when she becomes owned/' proverbs.usfm



# marry: 10 lines

# 2sa 3:14
sed -i 's/whom I was given to marry for one/whom I requested and was granted to me for one/' 2samuel.usfm

# gen 19:14
sed -i 's/who were pledged to marry his daughters/who took his daughters/' genesis.usfm

# NOTE: changing "profane" or "defiled" to pierced
# it would probably be good to find all instances of the root word and
# change each of them. also: prostitute to whore.
# lev 21:7
sed -i 's/not marry a woman who is a prostitute, or profane\. A priest shall not marry a woman divorced/not take a woman who is a whore, or pierced\. A priest shall not take a woman divorced/' leviticus.usfm

# lev 21:14
sed -i 's/shall not marry a widow, or one divorced, or a woman who has been defiled, or a prostitute/shall not take a widow, or one divorced, or a woman who has been pierced, or a whore/' leviticus.usfm

# mat 19:10
sed -i 's/it is not expedient to marry/it is not expedient to take her/' matthew.usfm

# mat 22:24
sed -i 's/his brother shall marry his wife/his brother shall take his wife/' matthew.usfm

# mat 22:30
sed -i 's/they neither marry nor are given in marriage/they neither take nor are taken/' matthew.usfm

# mat 24:38
sed -i 's/they were eating and drinking, marrying and giving in marriage, until/they were eating, drinking, being fruitful, and multiplying until/' matthew.usfm

# neh 13:27
sed -i 's/against our God in marrying foreign women/against our God in dwelling with foreign women/' nehemiah.usfm

# num 36:6
sed -i 's/only they shall marry into the family/only they shall be women into the family/' numbers.usfm




# marriage / marriages

# 1ki 3:1
sed -i 's/Solomon made a marriage alliance with Pharaoh/Solomon made himself a relative of Pharaoh/' 1kings.usfm

# deu 7:3
sed -i 's/You shall not make marriages with them/You shall not make yourself a relative of them/' deuteronomy.usfm

# gen 34:9
sed -i 's/Make marriages with us/Make yourselves relatives of us/' genesis.usfm

# jos 23:12
sed -i 's/and make marriages with them/and you make yourselves relatives of them/' joshua.usfm


# marries

# deu 24:1
sed -i 's/When a man takes a wife and marries her/When a man takes a woman and owns her/' deuteronomy.usfm

# mat 5:32
sed -i 's/and whoever marries her when she is put away commits adultery/and whoever takes her when she is put away commits adultery/' matthew.usfm

# mat 19:9
sed -i 's/and marries another, commits adultery; and he who marries her/and takes another, commits adultery; and he who takes her/' matthew.usfm




# --- unbalanced:
# one or more changes were made that change the following term:
# profane -> pierced
# however, other instances appear in the text and are not changed
# therefore resulting in an imbalance of translation.
# this imbalance is outside the scope of this update, but
# it should probably be addressed in a future update.
# note: even though it may currently be a bit imbalanced, it is the goal
# of this project to make improvements whenever they can be made,
# so it is deemed better to have updated one or more than none.

# another term to reconsider:
# defiled -> unclean




# other terms to reconsider:
# wedding & weddings: 17 lines
# wedlock: 1 line
# bride: 34 lines






# ------------------------------------------------------------------------------
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




# correct matthew 5:39 to reflect the hebrew from shem tov
sed -i 's/But I tell you, don’t resist him who is evil; but whoever strikes you on your right cheek, turn to him the other also\./And I say to you not to pay evil in exchange for evil, but if hit on your right cheek, prepare for a hit to your left!/' matthew.usfm





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






# ------------------------------------------------------------------------------
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
# note that the passage is apparently talking about a jechoniah. is this same jechoniah the one who appears in the matthew chapter 1 geneology? this source says no:
# https://hermeneutics.stackexchange.com/questions/56016/how-can-jesus-inherit-davids-throne-since-hes-a-descendent-of-jehoiakim
# the jechoniah in matthew is not the cursed jechoniah. the jechoniah in matthew is josiah's son (not grandson), and changed his name from johanan to jechoniah, like how his brothers changed their names.



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


# instead of removing matthew 1 completely, attempt to restore

# there is a possibility the curse of jechoniah was reversed

# but most importantly:
# many syriac manuscripts and other witnesses read "joseph begat jesus"
# as pointed out in recent (~5/2023) videos on youtube.com/jesuswordsonly

# restore text in world-english-bible style
sed -i 's/Jacob became the father of Joseph, the husband of Mary, from whom was born Jesus/Jacob became the father of Joseph. This Joseph became the father of Jesus/' matthew.usfm


# remove v18 to chapter 2. too many issues.
perl -i -p0e 's/\\p\n\\v 18 Now the birth of Jesus.*He named him Jesus\.//s' matthew.usfm













# starting with "Now" is awkward. prefer translation that starts with "When",
# as in the CEV, Geneva Bible of 1587, etc.
# remove word "Now"

# actually, web uses Now to start several books, so don't edit

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
# yahushua's prayer
# see: ESV, Berean Literal Bible, Douay-Rheims, etc.

# "the evil one. For yours is the Kingdom, the power, and the glory forever" -> "evil"

# matthew 6:13 (1 of 2)
sed -i 's/deliver us from the evil one/deliver us from evil/' matthew.usfm

# matthew 6:13 (2 of 2)
sed -i '/yours is the Kingdom, the power, and/d' matthew.usfm




# ----------------------------------------------------------
# remove asceticism addition
# see https://bibletranslation.ws/niv-bible-quiz/

# mat 17:21 not in nestle-aland/ubs. not in syriac.
sed -i 's/\\v 21 \\wj But this kind.*//' matthew.usfm




# ----------------------------------------------------------
# should matthew 18:11 be removed, like mat 17:21, because
# of similar manuscript witnesses? is it only in luke?
# yes, and furthermore, upon review, we are given plenty of reasons
# why the messiah was on earth, in various verses.

sed -i 's/\\v 11 \\wj For the Son of Man came to save.*//' matthew.usfm




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
sed -i 's/I tell you that whoever divorces his wife, except for sexual immorality, and takes another, commits adultery; and he who takes her when she is divorced commits adultery/I tell you that whoever puts away his wife, except for sexual immorality, and takes another, commits adultery; and he who takes her when she is put away commits adultery/' matthew.usfm






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
# adonai

# considering changing lord to adonai

# make sure the root of each use is adonai before changing
# and check for all occurrences of the hebrew word adonai

# lord
# lordly
# lords
# lord’s

# adonai
# adonaily (?)
# adonim
# adonai’s






# ----------------------------------------------------------
# our heavenly father's name


# despite book(s) by nehemia gordon (yehovah vowels: sheva cholem qamats),
# see:
# https://nazareneisrael.org/book/nazarene-scripture-studies-vol-4/about-the-pronunciation-yehovah/
# https://eliyah.com/why-the-heavenly-fathers-name-is-pronounced-yahweh/

# compare with "The Pronunciation of the Name" by Nehemiah Gordon:
# www.elyosoy.com/uploads/4/3/2/8/4328985/yhwh_2_nehemia_gordon.pdf

# do not change
# 6885x
#sed -i 's/Yahweh/Yehovah/g' *.usfm

# do not change
# 4x
#sed -i 's/YAHWEH/YEHOVAH/g' *.usfm





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

# continue removing term 'holy'
# 1x
sed -i 's/Holiness/Set-Apartness/g' *.usfm

# 11x
sed -i 's/holiness/set-apartness/g' *.usfm

# 1x
sed -i 's/holier/more set-apart/g' *.usfm

# 5x (one of these is 'holidays')
sed -i 's/holiday/set-apart day/g' *.usfm

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
# yahushua, yahshua, yeshua, yehoshua, iesou, iesous, iesus, jesus

# the names joshua, jacob, and joseph, for example, could also use fresh
# transliterations, so then where should a line be drawn, if anywhere?

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

# the strongest transliterations seem to me to be "yahushua" and "yahshua".

# articles in support of "yahushua"
# https://wylh.org/hebrew/proving-shua-in-yahushua.php
# https://eliyah.com/yahushua-is-the-true-name-of-the-messiah/
# https://walksetapart.com/2011/06/23/the-truth-the-name-of-yahushua-the-meaning-of-the-name/

# articles in support of "yahshua"
# https://yrm.org/yahushua-or-yahshua/
# https://christogenea.org/essays/yahshua-jesus-evolution-name
# https://www.servantsofyahshua.com/yahshua-or-yahushua,-not-yeshua.html

# perhaps the vav in "יהושע" is silent, but whynot display it?
# also, i've seen "yehoshua" but never "yehshua"

# so at the moment, i think "yahushua" may be the most respectful.

# edit "jesus" to "yahushua"
# no instances of "jesus" all-lowercase were found on last check
# 511x
sed -i 's/Jesus/Yahushua/g' *.usfm

# 2x
sed -i 's/JESUS/YAHUSHUA/g' *.usfm

# fix apostrophe issue.
# 13x
sed -i 's/Yahushua’ /Yahushua’s /g' *.usfm

# do not edit "christ" to "messiah"

# editing "christ" to "messiah" would create a confusing translation.
# the term "messiah" is already used in john, distinct from the word "christ"





# ----------------------------------------------------------
# brought forth

# the hebrew term used means brought forth, not 'became the father of'
# and using the phrase 'became the father of' has problematic doctrinal issues.

sed -i 's/became the father of/brought forth/g' *.usfm

printf .



# ------------------------------------------------------------------------------
# CONVERT USFM TO HTML
# only usfm markers used in the web version are considered
# (this is not a universal converter for any usfm file)
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
<style>
sup {
  display: none;
}
.p, .p1, .q1, .q2, .qs, .sp, .m, .mi, .pi1, .li1, .d, .nb {
  text-indent: 2em;
}
.p1 {
  text-indent: 0;
}
.d {
  text-indent: 0;
}
.li1 {
  display: list-item;
  list-style-type: none;
}
.sp {
  margin-top: 0.5em;
  font-style: italic;
}
.pi1 {
  margin-left: 2em;
}
html[dir=ltr] .q1 {
  text-indent: -2em;
  margin-left: 2em;
}
html[dir=ltr] .q2 {
  text-indent: -1em;
  margin-left: 2em;
}
.q1 {
  text-indent: -2em;
  margin-left: 2em;
}
.q2 {
  text-indent: -2em;
  margin-left: 2em;
}
</style>
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
echo '</div></div><script src="../main.js"></script></body></html>' >> $n
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


# swap psalm chapter and psalm book order in usfm before converting to html?
# no, usfm awkwardly puts ms1 after chapterlabel, as per usfm docs
# instead, just fix html (see below)

# convert ms1 (psalm books 1-5) (without fixing position)
# (ms1 titles will still be after chapterlabel which is wrong for html)
#sed -i 's/\\ms1 \([A-Za-z]* [0-9]\+\)/<h2 class="ms1">\1<\/h2>/' psalms.html

# remove all major section labels in psalms (psalm books 1-5)
sed -i '/\\ms1 /d' psalms.html
# restore all major section labels, but before psalm number (fixes position)
sed -i '/^\\c 1$/i <\/div><h2 class="ms1">BOOK 1<\/h2>' psalms.html
sed -i '/^\\c 42$/i <\/div><h2 class="ms1">BOOK 2<\/h2>' psalms.html
sed -i '/^\\c 73$/i <\/div><h2 class="ms1">BOOK 3<\/h2>' psalms.html
sed -i '/^\\c 90$/i <\/div><h2 class="ms1">BOOK 4<\/h2>' psalms.html
sed -i '/^\\c 107$/i <\/div><h2 class="ms1">BOOK 5<\/h2>' psalms.html


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
# chapter links

# after booklabel, append opening div for chapnav (chapter links)
sed -i '/booklabel/a <div class="chapterlabel nav chapnav">' *.html

# after chapnav, close the div
# this will be done later by the "close divs" section
#sed -i '/chapnav/a <\/div>' *.html

# add chapter links according to number of chapters
for f in *.html; do
# determine the number of chapters
n=$(grep 'chapterlabel' $f | wc -l)
# subtract one to account for the new links div that was just made
((n--))
# loop through chapter numbers in reverse order
while [ $n -gt 0 ]; do
# insert html chapter link corresponding to chapter number
sed -i "/chapnav/a <a href=\"#$n\">$n</a>" $f
# decrement chapter number
((n--))
done
done

# rename for psalms
sed -i 's/chapterlabel/psalmlabel/' psalms.html

# add psalm links according to number of psalms
# determine the number of psalms
n=$(grep 'psalmlabel' psalms.html | wc -l)
# subtract one to account for the new links div that was just made
((n--))
# loop through chapter numbers in reverse order
while [ $n -gt 0 ]; do
# insert html chapter link corresponding to chapter number
sed -i "/chapnav/a <a href=\"#$n\">$n</a>" psalms.html
# decrement chapter number
((n--))
done






# ------------------------------------------------------------------------------
# basic paragraph (p tags force newlines when copied, so avoid p tag)

# convert paragraphs, otherwise implied quotes are broken.
sed -i 's/\\p /<div class="p">/g' *.html
sed -i 's/\\p$/<div class="p">/g' *.html
# no paragraphs
#sed -i 's/\\p //g' *.html
#sed -i 's/\\p//g' *.html

# set class of first paragraph.
# this only changes the first paragraph in each book.
# the normal thing to do is to change the first paragraph of each chapter.
# but it's really a matter of style.
# it is normal to have the first paragraph of each chapter unindented or
# have it formatted with small caps on the first few words.
# note: chapter divisions in scripture are a later invention superimposed
# on the text. also, switching between no-chapters and chapters is seamless
# if chapter 2+ are all formatted the same way.
sed -i '0,/<div class="p">/{s/<div class="p">/<div class="p1">/}' *.html


# fix nesting by removing the first div close
#sed -i '0,/<\/div><div class="p">/{s/<\/div><div class="p">/<div class="p1">/}' *.html

# will need to remove the first "</div>"
# \qs* makes close



# ------------------------------------------------------------------------------
# alternate paragraphs

# convert quote 1, for poetry
sed -i 's/\\q1 /<div class="q1">/g' *.html
sed -i 's/\\q1/<div class="q1">/g' *.html
# no q1
#sed -i 's/\\q1 //g' *.html
#sed -i 's/\\q1//g' *.html

# convert quote 2, for poetry
sed -i 's/\\q2 /<div class="q2">/g' *.html
sed -i 's/\\q2/<div class="q2">/g' *.html
# no q2
#sed -i 's/\\q2 //g' *.html
#sed -i 's/\\q2//g' *.html

# convert quote selah, for poetry, usually right-aligned
sed -i 's/\\qs /<div class="qs">/g' *.html
sed -i 's/\\qs\*//g' *.html
# run this last or it will match others
sed -i 's/\\qs/<div class="qs">/g' *.html
# no qs
#sed -i 's/\\qs //g' *.html
#sed -i 's/\\qs//g' *.html
#sed -i 's/\\qs\*//g' *.html

# convert speaker, for song of songs
sed -i 's/\\sp /<div class="sp">/g' *.html
sed -i 's/\\sp/<div class="sp">/g' *.html
# no sp
#sed -i 's/\\sp //g' *.html
#sed -i 's/\\sp//g' *.html

# convert margin, for non-indented lists
sed -i 's/\\m /<div class="m">/g' *.html
sed -i 's/\\m$/<div class="m">/g' *.html
# no m
#sed -i 's/\\m //g' *.html
#sed -i 's/\\m//g' *.html

# convert margin indented, for indented lists
sed -i 's/\\mi /<div class="mi">/g' *.html
sed -i 's/\\mi/<div class="mi">/g' *.html
# no mi
#sed -i 's/\\mi //g' *.html
#sed -i 's/\\mi//g' *.html

# convert paragraph indent 1
sed -i 's/\\pi1 /<div class="pi1">/g' *.html
sed -i 's/\\pi1/<div class="pi1">/g' *.html
# no pi1
#sed -i 's/\\pi1 //g' *.html
#sed -i 's/\\pi1//g' *.html
printf .


# convert li1
sed -i 's/\\li1 /<div class="li1">/g' *.html
sed -i 's/\\li1/<div class="li1">/g' *.html


# convert director
sed -i 's/\\d /<div class="d">/g' *.html
sed -i 's/\\d/<div class="d">/g' *.html

# convert nb
sed -i 's/\\nb /<div class="nb">/g' *.html
sed -i 's/\\nb/<div class="nb">/g' *.html



# ------------------------------------------------------------------------------
# close p or div tags

# close various tags
#sed -i 's/<p/<\/p><p/g' *.html
sed -i 's/<div/<\/div><div/g' *.html

# clean up unintended first two closing tag
#sed -i '0,/<\/p>/{s/<\/p>//}' *.html
sed -i '0,/<\/div>/{s/<\/div>//}' *.html
sed -i '0,/<\/div>/{s/<\/div>//}' *.html

# add final closing tag (deprecated method. see html closing code above)
#sed -i 's/<\/div><\/body>/<\/p><\/div><\/body>/' *.html
#sed -i 's/<\/div><\/body>/<\/div><\/div><\/body>/' *.html



# ------------------------------------------------------------------------------
# span

# convert verse numbers
#sed -i 's/\\v \([0-9]\+\) /<sup class="v" style="display:none">\1\&#160;<\/sup>/g' *.html
sed -i 's/\\v \([0-9]\+\) /<sup>\1\&#160;<\/sup>/g' *.html

# why execute this line? and why is it commented out?
# note: changed "span" to "sup" (superscript) after writing this line
# then replaced span with sup in the line
# run this before wj, so clearing after span doesn't eliminate necessary spaces
#sed -i 's/<\/sup> \+/<\/sup>/g' *.html

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
# remove footnotes
sed -i 's/\\f.*\\f\*//g' *.html

# save footnotes in a span (needs more work with \fr and \ft)
#sed -i 's/\\f /<span class="f">/g' *.html
#sed -i 's/\\f\*/<\/span>/g' *.html


# cross-references
#remove cross-references
sed -i 's/\\x.*\\x\*//g' *.html

# save cross-references in a span
#sed -i 's/\\x /<span class="x">/g' *.html
#sed -i 's/\\x\*/<\/span>/g' *.html

printf .


# ------------------------------------------------------------------------------
# breaks

sed -i 's/\\b /<div class="b"> \&#160; <\/div>/g' *.html
sed -i 's/\\b$/<div class="b"> \&#160; <\/div>/g' *.html



# ------------------------------------------------------------------------------
# fix nesting for p or div tags

# due to chapters
#perl -i -p0e 's/<h2 class="([a-z]*)" id="([0-9]*)">[0-9]*<\/h2>\n<\/p>/<\/p><h2 class="\1" id="\2">\2<\/h2>\n/g' *.html
perl -i -p0e 's/<h2 class="([a-z]*)" id="([0-9]*)">[0-9]*<\/h2>\n<\/div>/<\/div><h2 class="\1" id="\2">\2<\/h2>\n/g' *.html

# remove 5 extra closes due to psalm book labels
sed -i 's/<\/div><h2 class="psalmlabel" id="1"/<h2 class="psalmlabel" id="1"/' psalms.html
sed -i 's/<\/div><h2 class="psalmlabel" id="42"/<h2 class="psalmlabel" id="42"/' psalms.html
sed -i 's/<\/div><h2 class="psalmlabel" id="73"/<h2 class="psalmlabel" id="73"/' psalms.html
sed -i 's/<\/div><h2 class="psalmlabel" id="90"/<h2 class="psalmlabel" id="90"/' psalms.html
sed -i 's/<\/div><h2 class="psalmlabel" id="107"/<h2 class="psalmlabel" id="107"/' psalms.html

# due to breaks
#perl -i -p0e 's/<div class="b"> \&#160; <\/div>\n<\/p>/<\/p><div class="b"> \&#160; <\/div>\n/g' *.html
perl -i -p0e 's/<div class="b"> \&#160; <\/div>\n<\/div>/<\/div><div class="b"> \&#160; <\/div>\n/g' *.html



# ------------------------------------------------------------------------------
# spacing

# swap nbsp character for html code
sed -i 's/ /\&#160;/g' *.html

# remove extra spaces
sed -i 's/  / /g' *.html



echo " Done."
