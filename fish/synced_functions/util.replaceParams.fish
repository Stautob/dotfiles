function util.replaceParams -a command
  for i in (seq 1 (count $argv[2..-1]))
    if string match -q "*{$i}*" $command
      set argvindex (match $i +1)
      set command (string replace "{$i}" $argv[(math $i + 1)] $command)
    else
      echo "No param {$i} found!"
      return 1
    end
  end
  echo $command
end
