#!/usr/bin/python
# -*- coding: utf-8 -*-

import glob

# the dictionary has target_word:replacement_word pairs
word_dic = {
#gris clair -> blanc
"#eeeeec": "#ffffff", #blanc
"#d3d7cf": "#ececec", #7.5% gris
"#babdb6": "#cccccc", #20% gris

#jaune -> 7,5% gris
"#fce94f": "#ececec",
"#edd400": "#ececec",
"#c4a000": "#ececec",
      
#orange -> 20% gris
"#fcaf3e": "#cccccc",
"#f57900": "#b3b3b3",
"#ce5c00": "#808080",#50% gris
       
#vert -> 30% gris
"#8ae234": "#b3b3b3",
"#73d216": "#b3b3b3",
"#4e9a06": "#666666",#60% gris

#bleu  -> 40% gris
"#729fcf": "#999999",
"#3465a4": "#999999",
"#204a87": "#333333", #80% gris
       
#violet -> 60% gris
"#ad7fa8": "#666666",
"#75507b": "#666666",
"#5c3566": "#666666",
       
#rouge -> 70% gris
"#ef2929": "#4d4d4d",
"#cc0000": "#4d4d4d",
"#a40000": "#4d4d4d",

#marron -> 80% gris
"#e9b96e": "#333333",
"#c17d11": "#333333",
"#8f5902": "#333333",

#gris foncé -> noir
"#888a85": "#cccccc", #20% gris
"#555753": "#1a1a1a", #80% gris
"#2e3436": "#000000",
}
 
# Process images
songfiles = glob.glob('fig/src/grey/*.svg')
for filename in songfiles:
   with open(filename, 'r+') as songfile:
       data = songfile.read()
       for search, replace in word_dic.items():
             data = data.replace(search, replace)
       songfile.seek(0)
       songfile.write(data)
       songfile.truncate()

