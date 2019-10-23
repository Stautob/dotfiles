function util.prependToPath -a dir -d 'Prepends the given directory to the beginning of the PATH'
  if test -n $dir -a -d $dir
    set dir (realpath $dir)

    # If this path is already contained in the PATH array, remove all occurrences and add it to the beginning
    for i in (seq (count $PATH) 1)
      if test $PATH[$i] = $dir
        set -e PATH[$i]
      end
    end
    set PATH $dir $PATH
  else
    echo "Dir $dir does not exist!"
  end
end
