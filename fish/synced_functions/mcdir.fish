function mcdir -a path -d "Creates a directory inclusive parents and changes into the new directory"
  if [ -n path ]
      mkdir $path -p; and cd $path
  else
    echo "Usage: mcdir <path/to/new/folder>"
  end
end
