#!/usr/bin/env bash

this_dir=$(cd $(dirname $0);pwd)
ext_dir=$HOME/.urxvt/ext

## install to urxvt extensions
[ ! -d $ext_dir ] && mkdir -p $ext_dir
[ ! -r $ext_dir/resize-font  ] && ln -s $this_dir/resize-font $ext_dir/

## set .Xresources to use it

# .Xdefaults or .Xresources? if neither use .Xresources
Xrc=($(find $HOME -maxdepth 1 -iname .Xdefaults -or -iname .Xresources))
[ -z "$Xrc" ] && Xrc=$HOME/.Xresources

# do we already have a line for urxvt
g=$(grep -ni urxvt.perl-ext-common ${Xrc[@]} 2>/dev/null)

# have no xres file or have no perl-ext line
[ -z "$g" ] && echo "consider:
echo 'urxvt.perl-ext-common: default,tabbed,matcher,resize-font,-tabbed' >> $Xrc" && exit

# maybe have perl-ext but not resize-font
echo $g | grep resize-font >/dev/null || echo "consider adding 'resize-font' to $g (${Xrc[@]})"


