+++
title = 'How to use Hugo for static web sites'
date = 2024-08-09T15:47:01+04:00
draft = false
+++


## Introduction

Hugo is popular open-source framework for building static websites. If you want to create own blog or landing page, and want to avoid overheads with blog engines like WordPress, then Hugo is a good option for you. As a benefit Hugo uses Markdown syntax for content, supports multi-languages and many different themes to cover your needs.

### To make this page I did the following:

- installed `hugo` 

```
sudo pacman -Sy hugo
```

- created new hugo project

```
hugo new site blog
```

- cloned theme for blog

```
cd blog
git submodule add https://github.com/athul/archie.git themes/archie
```

- updated hugo config to apply *archie* theme

```
echo "theme = 'archie'" >> hugo.toml
```

- added **this** page to blog content

```
hugo new content content/posts/how-to-use-hugo.md
nvim content/posts/how-to-use-hugo.md
```

- verified all work as expected

```
hugo server -D
```

In the next post I'm going to cover process of deployment of your site.

