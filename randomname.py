from random import choice
import wget
import os

if __name__ == "__main__":
    if not os.path.exists("english-adjectives.txt"):
        wget.download("https://gist.githubusercontent.com/hugsy/8910dc78d208e40de42deb29e62df913/raw/eec99c5597a73f6a9240cab26965a8609fa0f6ea/english-adjectives.txt")
    if not os.path.exists("words_alpha.txt"):
        wget.download("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")

    with open("words_alpha.txt",'r') as f:
        words = [w.strip('\n') for w in f.readlines()]
    with open("english-adjectives.txt",'r') as f:
        adjs = [w.strip('\n') for w in f.readlines()]

    inp=""
    while inp!='q':
        inp = input()
        print(f"{choice(adjs)} {choice(words)}")

