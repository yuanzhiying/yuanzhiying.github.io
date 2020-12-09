---
title: npm、nvm使用国内淘宝源
date: 2020-12-09 10:21:45
tags: 
- hexo
categories:
- hexo
---
- npm：
1. 显示当前的镜像地址：`npm get registry`
2. 更换为淘宝的镜像地址：`npm config set registry http://registry.npm.taobao.org`
3. 再次查看当前的镜像地址：`npm get registry`

- nvm：
1. `.bash_profile`文件中添加：
```
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
export NVM_IOJS_ORG_MIRROR=http://npm.taobao.org/mirrors/iojs
```
2. 执行`source ~/.bash_profile`起效
