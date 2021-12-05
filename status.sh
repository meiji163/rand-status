#!/bin/bash
adj_file="english-adjectives.txt"
words_file="words_alpha.txt"

if [[ ! -e "$adj_file" ]]; then
    wget https://gist.githubusercontent.com/hugsy/8910dc78d208e40de42deb29e62df913/raw/eec99c5597a73f6a9240cab26965a8609fa0f6ea/english-adjectives.txt 
fi 
if [[ ! -e "$words_file" ]]; then
    wget https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt
fi 

rand_words(){
    # no i wont do it in bash tyvm 
    n=100
    words="$( python -c "from random import choice
with open(\"$words_file\",'r') as f: 
    words = [w.strip(\"\n\") for w in f.readlines()]
with open(\"$adj_file\",'r') as f: 
    adjs = [w.strip(\"\n\") for w in f.readlines()]
for _ in range($n):
    print(f\"{choice(adjs)} {choice(words)}\" )")"

    fzf --ansi <<< "$words"
}

post_status(){
    local status
    read status
    if [[ -z "$status" ]]; then
        exit 1
    fi

    curl https://discord.com/api/v9/users/@me/settings \
    -X 'PATCH' \
    -H "authorization: $DISCORD_TOKEN" \
    -H 'content-type: application/json' \
    -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36' \
    -H 'accept: */*' \
    --data-raw "{\"custom_status\":{\"text\":\"$status\"}}" \
    --silent \
    --write-out '%{http_code}'
}

rand_words | post_status
