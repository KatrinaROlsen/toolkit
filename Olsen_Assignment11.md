# Assignment 11
### Katrina Olsen

# Question 1
### Find the changes I made in the big project (files: big_poject1.zip vs big_poject2.zip) → I didn’t compile it so the PDF will look the same.
I first unzipped the zip files, then ran:
```diff -r big_project_1 big_project_2```

This shows:
- the main.tex files differ in version 1 having `\backmatter` and version 2 `\blackmatter`
- the mypreamble.sty in version 1 uses English and German for babel, version 2 uses English and French
- the title.tex in version 1 has `Prysłopska` whereas version 2 has `Pryslopska` in the title
- only version 1 has a chapter3.aux file 
- verion 1's chapter1.tex had double spaces `conspiracy  theory` in the second line, version 2 has one space
- the third line in version 1's chapter2.tex has `341,755` whereas version 2 uses `341.755`
- the fifth line of version 1's chapter2.tex uses `three questions` whereas version 2 uses `3 questions`
- the fifth line of version 1's chapter3.tex has `tenth` whereas version 2 uses `10th`

# Question 2
### How many times does the word "Tagblatt" appear in the files corpus1.txt, corpus2.txt, and corpus3.txt? Count only the lines.
Running the command `grep -wc "Tagblatt" corpus?.txt` results in:
```
corpus1.txt:41
corpus2.txt:34
corpus3.txt:34
```
Thus, corpus1.txt has 41 lines with Tagblatt, and corpus2.txt and corpus3.txt both have 34 lines of instances.

# Question 3
### Count all the lines and instances where the whole article "die" appears in these 3 files. Capitalization is not important, i.e. Die OK, Dieser not OK

#### Line Counts
Running the command `grep -wci "die" corpus?.txt` results in:
```
corpus1.txt:325
corpus2.txt:466
corpus3.txt:466
```
Thus, corpus1.txt has 325 lines with case-insensitive 'die' in it, corpus2.txt and corpus3.txt both have 466 lines of instances.

#### Instance Counts
To count the number of instances, I like to use `grep -o "word" file | wc -l`, which outputs every instance of the word found, and then counts the lines of those outputs. I used this method for the below, bc I don't know how the `grep -c -i -w Winter * | wc` command on the slides could work since it's counting the count output from grep?

So, using `grep -owi "die" corpus1.txt | wc -l` for each corpus, I get:
- 623 instances in corpus1.txt
- 923 instances in corpus2.txt
- 926 instances in corpus3.txt


# Question 4
### What are the differences between corpus2.txt and corpus3.txt?
Running `diff corpus2.txt corpus3.txt` shows the following differences:
- on line 77, corpus3.txt has `Eisbär-Baby` hyphenated while corpus2.txt instead has `Eisbärbaby`
- after line 429, corpus3.txt has the following lines, which are not in corpus2.txt:
```
Dabei nutzen in Ägypten heute 17 Millionen Menschen das Internet, und fast ein Drittel von ihnen - 5 Millionen - ist bei Facebook angemeldet.
Heute werden die Demonstrationen über das Internet nicht nur organisiert, sondern auch orchestriert. Kaum war die Internetsperre aufgehoben, kursierten schon wieder E-Mails mit Ratschlägen, wie man sich auf Demonstrationen <B>verhalten sollte, um</> keine Eskalation zu provozieren. Und auch wenn sich der Protest längst verselbstständigt hat, bleibt etwa Facebook doch ein wichtiger Gradmesser für die weitere Entwicklung. An der Popularität seines Profils lässt sich ablesen, wie beliebt der Oppositionspolitiker Mohammed al-Baradei derzeit ist. (T11/FEB.00754 die tageszeitung, 05.02.2011, S. 10; Wir sind alle Khaled Said)
```
- corpus3.txt has the following lines that corpus2.txt doesn't (around the 580 line range, the line numbers are harder to compare now some are missing/extra):
```


Die ganzen "Skandälchen" rund um den Sturz des Bundespräsidenten Wulff ließen es vermuten: da reitet einer jeden halblegal hinkenden Gaul, um sich zu bereichern. Mit den Vorgängen bei der Vorstellung des Buches seiner Frau wird diese Vermutung jetzt zur Gewissheit: Jeder miese Trick ist recht, um das Hartz-IV-Präsidentengehalt aufzubessern. Besonders verwerflich ist die mediengerechte Aufbereitung der Nuttenvermutung: Da <B>verhält</> sich jemand <B>nuttig, um</> genau diesen Netzblödsinn zu widerlegen. Am Ende bleibt das Wissen: Die Wulffs waren und sind kleinhäuslerische, auch etwas kurzsichtige und daher unbeliebte Egomanen. Michael Maresch, München (HMP12/SEP.01555 Hamburger Morgenpost, 18.09.2012, S. 23; LESERBRIEFE)
``` 
- on line 623, corpus2.txt has `Bagnčres` whereas corpus3.txt has `Bagnères`
- this same difference can be found on line 635 as well
- on line 740, corpus2.txt has `Bohčme` whereas corpus3.txt has `Bohème`
- on line 916, corpus2.txt has `30.11.2013` whereas corpus3.txt has `30.12.2013`

