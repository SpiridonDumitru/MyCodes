==CODE Notes==
===========
[TOC]

-----------------------------------------------
#### print with **PANDOC**

`pandoc -t pdf eating.txt -o eating.pdf`
`pandoc -t markdown eating.md -o eating.pdf`

------------------------------------------------

#### **VIM** :bufdo

`:bufdo execute "normal! @a" | update` 

`:bufdo %s/a whale/a bowl of petunias/gce`

==OR==

`:bufdo %s/pattern/replace/ge | update :bufdo wq!`

[*LINK: Multiple replacements in Vim*](https://www.freecodecamp.org/news/how-to-search-and-replace-across-multiple-files-in-vim/){style="color: blue;"}

-------------------------------------------------

#### Look around **VIM**

[*LINK: REGex in Vim - Look Around*](https://www.inputoutput.io/lookbehind-lookahead-regex-in-vim/){style="color: blue;"}

--------------------------------------------------

#### Print pdf with **GROFF**  

`groff -ms troff1.md -T pdf > troff1.pdf`

--------------------------------------------------

#### Print with **GROFF** & preview with **ZATHURA**

`groff -ms example.ms -T pdf | zathura -`

--------------------------------------------------

#### Update pdf **LIVE** 

`zathura output.pdf &> /dev/null &`

--------------------------------------------------

#### Update pdf from **VIM** directly 

`!groff -ms output.txt -Tpdf > output.pdf`

![Vim REGex to update LIVE pdf](images/Screenshot%20from%202023-01-03%2014-51-45.png){width="380"}

*NB. this does ++not++ print the long em dash*

--------------------------------------------------

#### settings in ranger 

- set line_numbers
- sert line_numbers relative
- set draw_borders both

---------------------------------------------------

#### delete blank line in **VIM** 

- `:g/^$/d`
- `:g/^\n$/d`

---------------------------------------------------

#### extract a number of lines from one file into another file 

- from within **VIM** `:!awk 'NR>=5926 && NR<=5991' mainFile.txt > outputFile.txt`
- from **ranger** `:awk 'NR>=5926 && NR<=5991' mainFile.txt > outputFile.txt`

------------------------------------------------

#### find multiple words in **VIM** 

- /word1|word2|word3
- /word1\|word2\|word3

------------------------------------------------

#### substitution in **VIM** 

- :%s/findWhatToReplace/replaceWhatYouFound/g

------------------------------------------------

#### push to **github**  

`cd  - into the folder repository

```bash
`git add .
`git commit -m $'My First Commit files'
`git push origin main
`Username for 'https://github.com':    *spiridondumitru@outlook.com*
`Password for 'https://spiridondumitru@outlook.com@github.com': *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*
```

------------------------------------------------

#### prep install **MkDocs Material**  

```bash
`python3 -m venv venv
`source venv/bin/activate
`pip install mkdocs-material
```
