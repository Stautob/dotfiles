#!/usr/bin/fish

#-------------------------#
# Abbreviations           #
#-------------------------#

if test (abbr --list | wc -l) -eq 0
  abbr --add gst git status
  abbr --add ip ip -c
  abbr --add vi nvim
end

#-------------------------#
