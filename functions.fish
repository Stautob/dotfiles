#---------------------#
# FUNCTIONS           #
#---------------------#

function sudop
  sudo -i fish
end

function ll
  ls -alGh --color=auto $argv
end

function ud -d "Opens Unidoc folder"
  if [ (count $argv) = 1 ]
    cd $docfolder$argv[1]
  else
    cd $docfolder
  end
end

complete -f -c ud -a "(ls $docfolder)" -d "Completition for ud"

function mcdir
  if [ (count $argv) > 0 ]
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        mkdir $argv[(count $argv)] -p
        cd $argv[(count $argv)]
        return
    end
  else
    echo "Usage: mcdir <path/to/new/folder>"
  end
end

function g++
  clang++ $argv
end

function mntNAS -d "Mount Tobias-NAS"
  echo "Mounting NAS-Tobias"
  if [ !(mount | grep Volume_1 > /dev/null) ]
    sudo mount -t cifs -o credentials=/home/tstauber/.NAS-Tobias_cred //192.168.1.45/Volume_1/ /media/BU
  else
    echo "Volume_1 allready mounted"
  end
end

function haei -d "Mounts HSR dfs"
  sudo mount -t cifs -o credentials=/home/tstauber/.HSRDFScred //hsr.ch/root/ /media/hsrdfs
end

function -
  cd -
end

#-----------------------#
# HELPERS FOR GREETER   #
#-----------------------#

function greeter_temperature
end
