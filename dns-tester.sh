#!/bin/bash

servers='google.com facebook.com youtube.com yahoo.com baidu.com wikipedia.org amazon.com twitter.com taobao.com qq.com google.co.in live.com linkedin.com sina.com.cn weibo.com yahoo.co.jp tmall.com yandex.ru blogspot.com ebay.com google.co.jp google.de hao123.com vk.com instagram.com bing.com reddit.com google.co.uk sohu.com pinterest.com tumblr.com amazon.co.jp wordpress.com google.com.br msn.com google.fr imgur.com paypal.com microsoft.com aliexpress.com apple.com alibaba.com'


red="\e[31m"
green="\e[32m"
for server in $servers; do
    start_time=$(date +%s%3N)
    dig $server >/dev/null 2>&1
    end_time=$(date +%s%3N)
    elapsed_time=$(echo "scale=3; $end_time - $start_time" | bc)
    echo "$server: take $elapsed_time seconds to resolve "
    if [[ $elapsed_time > 50 ]];then
        weak=0
    else
        true
    fi
done

if [[ $weak == 0 ]];then
    echo -e $red'weak dns , need to change now !'
else
    echo -e $green'powerfull dns'
fi
