#!/bin/sh
# remove every existing rule, one at a time
for i in $(seq "$(bspc rule -l | wc -l)"); do
  bspc rule -r tail
done

# load the rules fresh from the file
~/.config/bspwm/rules

# show the result
bspc rule -l
