#!/usr/bin/fish


function pivotrandr
  xrandr --auto
  xrandr --output VGA1 --rotate left --mode 1920x1200 --pos 0x0 --output LVDS1 --auto --pos 1200x1021
end

function norandr
  xrandr --auto
  xrandr --output VGA1 --off
end

function lfhdrandr
  lresrandr 1920 1080
end

function rfhdrandr
  rresrandr 1920 1080
end

function disset
  xrandr --auto
  xrandr --output DP-1 --left-of DP-2 --output DP-2 --left-of eDP-1
end

function getResolutionOfInternalDisplay
  xrandr | grep -e 'LVDS\|eDP-1'
  # TODO some more work
end


function lresrandr
  xrandr --auto
  if [ (count $argv) -eq 2 ]
    xrandr --output VGA1 --mode {$argv[1]}x{$argv[2]} --pos 0x0 --output LVDS1 --auto --pos (math {$argv[1]}+1)x(math $argv[2] - 900)
  end
end

function rresrandr
  xrandr --auto
  if [ (count $argv) -eq 2 ]
    xrandr --output VGA1 --mode {$argv[1]}x{$argv[2]} --pos 1601x0 --output LVDS1 --auto --pos 0x(math $argv[2] - 900)
  end
end

