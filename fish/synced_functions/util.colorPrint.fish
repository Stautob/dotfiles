function util.colorPrint -a text color
  set_color $color $argv[2..-1]
  echo -ne $text
  set_color normal
end
