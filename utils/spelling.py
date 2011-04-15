#!/usr/bin/python
# -*- coding: utf-8 -*-

import re
import glob
import codecs
 
def replace_words(text, word_dic):
    """
    take a text and <strong class="highlight">replace</strong> words
    that match a key in a dictionary with the associated value, 
    return the changed text
    """
    rc = re.compile('|'.join(map(re.escape, word_dic)))
    def translate(match):
        return word_dic[match.group(0)]
    return rc.sub(translate, text)
 
# the dictionary has target_word:replacement_word pairs
word_dic = {
#oe inclusion
"coeur": "cœur",
"boeuf": "bœuf",
"oeuvre": "œuvre",
"soeur": "sœur",
"noeud": "nœud",
"oeil": "œil",
"oe{}": "œ",
#punctuation
"’": "'",
"Ca ": "Ça ",
"...": "\\dots ",
"…": "\\dots",
"	": "  ",
"multirésolution":"multi-résolution",
"multiéchelle":"multi-échelle",
"linel ":"lignel ",
#
}
 
# Process tex files
files = glob.glob('tex/*.tex')
for file in files:
    tex = codecs.open(file, "r", "utf-8")
    data = tex.read().encode("utf-8")
    data = replace_words(data, word_dic)
    tex.close()
    tex = open(file, "w")
    tex.write(data)
    tex.close()
 

