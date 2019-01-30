# Internship-2019-project

## hangman
- code in bash script format

**Rule**
  - Can predict each word 
  - Each round include with less 5 iterations
  - File for test include with
  
    1-easy.txt
    
    2-easy.txt
 
**Require preparation**

  no

**How used?**

Start program on Terminal
```
sh hangman.sh
```
Select mode choice (a number) and then <Enter>
```
> 1
```
After, we will found <hint>
Enter a word or char 
  
with a word

```
_ _ _ _ _ _ _ _ _ _ 
> Good
 
```
with char

```
_ _ _ _ _ _ _ _ _ _ 
> d
 
```

If you turn right word or char, score will up belong with number of char that you can get from this round.

The max score for each round is 100 scores.

**Each round can end with 3 choices,**
  - ^C : exit this program 
  - Can predict all word, get 100 scores
  - Can't predict, get 10 mistakes

## weather
