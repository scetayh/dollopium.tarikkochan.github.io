#!/bin/bash

set -e

sed -n '1,70p' ./sources/txt/index.html.txt # 头
sed -n '71,72p' ./sources/txt/index.html.txt # 单选题头
# 单选题
sed -n '93,94p' ./sources/txt/index.html.txt # 多选题头
# 多选题
sed -n '115,120p' ./sources/txt/index.html.txt # 尾