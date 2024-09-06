#!/bin/bash

servers='google.com facebook.com youtube.com yahoo.com baidu.com wikipedia.org amazon.com twitter.com taobao.com qq.com google.co.in live.com linkedin.com sina.com.cn weibo.com yahoo.co.jp tmall.com yandex.ru blogspot.com ebay.com google.co.jp google.de hao123.com vk.com instagram.com bing.com reddit.com google.co.uk sohu.com pinterest.com tumblr.com amazon.co.jp wordpress.com google.com.br msn.com google.fr imgur.com paypal.com microsoft.com aliexpress.com apple.com alibaba.com'

red="\e[31m"
green="\e[32m"

# Check if bc is installed
if ! command -v bc &> /dev/null; then
  # Install bc using apt
  sudo apt install bc
fi

for server in $servers; do
    start_time=$(date +%S)
    dig $server >/dev/null 2>&1
    end_time=$(date +%S)
    elapsed_time=$(echo "scale=3; $end_time - $start_time" | bc)
    echo "$server: take $elapsed_time seconds to resolve "
    if [[ $elapsed_time < 2 ]];then
        weak=1
    else
        weak=0
    fi
done

if [[ $weak == 1 ]];then
    echo -e $green'powerfull dns'
else
    echo -e $red'weak dns , need to change now !'
fi
