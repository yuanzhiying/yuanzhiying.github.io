#!/bin/bash

echo "\033[1;32m 开始创建hexo文章，输入文章标题： \033[0m"

read title

hexo new "$title"
hexo clean
hexo d -g
