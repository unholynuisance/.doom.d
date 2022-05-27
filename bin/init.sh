#!/bin/bash
emacs --batch --eval "
(progn
  (require 'org)
  (setq org-confirm-babel-evaluate nil)
  (org-babel-tangle-file \"~/.config/doom/config.org\"))
"

~/.config/doom/bin/install.sh

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs

~/.config/emacs/bin/doom -y install || ~/.config/emacs/bin/doom build
~/.config/doom/bin/setup.sh
