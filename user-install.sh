#!/usr/bin/env bash

this_dir=$(cd $(dirname $0);pwd)
ext_dir=$HOME/.urxvt/ext

## install to urxvt extensions
[ ! -d $ext_dir ] && mkdir -p $ext_dir
[ ! -r $ext_dir/resize-font  ] && ln -s $this_dir/resize-font $ext_dir/

## set .Xresources to use it
Xrc=$HOME/.Xresources
g=$(grep -n urxvt.perl-ext-common $Xrc 2>/dev/null)

# have no xres file or have no perl-ext line
[ ! -r $Xrc -o -z "$g" ] && echo "consider:
echo 'urxvt.perl-ext-common: default,tabbed,matcher,resize-font,-tabbed' >> $Xrc" && exit

# maybe have perl-ext but not resize-font
echo $g | grep resize-font >/dev/null || echo "consider adding resize-font to $Xrc:$g"


