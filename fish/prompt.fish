#!/usr/bin/fish

# Git glyphs
set branch_glyph            ''
set detached_glyph          "➦"
set pull_pending_glyph      '⬇'
set push_pending_glyph      '⇧'

# Other glyphs
set prompt_finisher_glyph   '❱ '


# ===========================
# String Helper methods
# ===========================

function __g2_color_print -a text color
  set_color $color $argv[2..-1]
  echo -ne $text
  set_color normal
end

function __g2_enclose_in_brackets
  __g2_debug_log "enclose_in_brackets| argv: $argv"
  echo -ne "⦗"$argv"⦘"
end


# ===========================
# Path Helper methods
# ===========================

function __g2_pretty_path -a path
  echo -n (string replace "$HOME" "~" $path | string replace --all --regex "(?'short'\.?[^/])[^/]*/" "\$short/")
end


# ===========================
# Git Helper methods
# ===========================

function __g2_prompt_project_dir -d 'Print the current git project base directory'
  command git rev-parse --show-toplevel ^/dev/null
end

function __g2_prompt_getBranchOp
  set -l base_dir
  set -l git_dir (command git rev-parse --git-dir ^/dev/null)
  test ! -d $git_dir; and return 1

  # get repo status & branch name
  set -l op ''
  set -l branch ''

  command git ls-tree HEAD > /dev/null ^ /dev/null

  if test $status -eq 128
    set op 'init'
  else
    set -l step
    set -l total

    if test -d "$git_dir/rebase-merge"
      set step (cat "$git_dir/rebase-merge/msgnum")
      set total (cat "$git_dir/rebase-merge/end")
      set branch (cat "$git_dir/rebase-merge/head-name")" $step/$total"

      if test -f "$git_dir/rebase-merge/interactive"
        set op 'rebase -i'
      else
        set op 'rebase -m'
      end
    else
      if test -d "$git_dir/rebase-apply"
        set step (cat "$git_dir/rebase-apply/next")
        set total (cat "$git_dir/rebase-apply/last")

        if test -f "$git_dir/rebase-apply/rebasing"
          set op 'rebase'
        else if test -f "$git_dir/rebase-apply/applying"
          set op 'am'
        else
          set op 'am/rebase'
        end
      else
        if test -f "$git_dir/MERGE_HEAD"
          set op 'merge'
        else if test -f "$git_dir/CHERRY_PICK_HEAD"
          set op 'cherrypick'
        else if test -f "$git_dir/REVERT_HEAD"
          set op 'revert'
        else if test -f "$git_dir/BISECT_LOG"
          set op 'bisect'
        end
      end
      if not set branch (command git symbolic-ref HEAD ^/dev/null)
        test ! "$op"; and set op 'detached'
        if not set branch (command git describe --tags --exact-match HEAD ^/dev/null)
          if not set branch (cut -c 1-7 "$git_dir/HEAD" ^/dev/null)
            set branch 'unknown'
          end
        end

        if test "$step" -a "$total"
          set branch "[$branch $step/$total]"
        else
          set branch "[$branch]"
        end
      end
    end
  end

  __g2_debug_log "getBranchOp| branch: $branch"
  echo (string replace --all "refs/heads/" "" $branch)
  echo $op
end


# ===========================
# Segment functions
# ===========================

function __g2_prompt_path_segment -d 'Display a shortened form of a directory'
  __g2_color_print (__g2_enclose_in_brackets (prompt_pwd))" " $custom_color_medium_blue
end

function __g2_prompt_finish_segments -d 'Close open segments'
  __g2_color_print $prompt_finisher_glyph green --bold
end


# ===========================
# Theme components
# ===========================


function __g2_prompt_status -d 'the symbols for a non zero exit status, root and background jobs'
  # Print non-zero exit status
  if test $PROMPT_LAST_STATUS -ne 0
    __g2_color_print (__g2_enclose_in_brackets "⚡") $custom_color_red --bold #--background red
  end

  # Print super-user glyph
  if test (id -u $USER) -eq 0
    __g2_color_print (__g2_enclose_in_brackets "SU") red --bold
  end

  # Print background-jobs glyph
  if test (jobs -l | wc -l) -gt 0
    __g2_color_print (__g2_enclose_in_brackets "BG") $custom_color_yellow --bold
  end
end

function __g2_prompt_user -d 'Display actual user if different from $default_user'
  test "$theme_display_user" = "yes"; and set -l user (whoami)
  test -n "$SSH_CLIENT" -o -n "$SSH_TTY"; and set -l host "@"(promt_hostname)
  test -n "$user" -a -n "$host"; echo -n (__g2_enclose_in_brackets $user$host)
end

function __g2_getremote
  set -l remote (command git rev-parse --symbolic-full-name --abbrev-ref '@{u}' ^/dev/null); and echo $remote
end

function __g2_prompt_aheadbehind -a local
  string match -q "detached:*" $local; and return 1
  set -l cnt (command git rev-list --left-right --count $local...(__g2_getremote) -- ^/dev/null |tr \t \n)
  __g2_debug_log "prompt_aheadbehing| local: $local cnt[1]: $cnt[1] cnt[2]: $cnt[2]"
  if test $cnt[1] -gt 0 -a $cnt[2] -gt 0
    echo -n '±'
  else
    test $cnt[1] -gt 0; and echo -n '+'
    test $cnt[2] -gt 0; and echo -n '-'
  end
end

function __g2_prompt_git -d 'Display the actual git state'

  command git rev-parse --is-inside-work-tree > /dev/null ^ /dev/null; or return 1

  set -l v (__g2_prompt_getBranchOp)
  set -l branch $v[1]
  set -l op $v[2]

  set -l icon "$branch_glyph "
  test "$op" = "detached"; and set icon "$detached_glyph "

  #### PARSE STATUS
  set -l new 0
  set -l staged 0
  set -l dirty 0

  set -l git_status (command git status --porcelain ^/dev/null)

  for line in $git_status
    set -l x (echo $line | cut -c 1)
    set -l y (echo $line | cut -c 2)

    if test $x = '?'
        set new (math $new + 1)
    else
        test "$x" != ' '; and set staged (math $staged + 1)
        test "$y" != ' '; and set dirty (math $dirty + 1)
    end
  end

  if test -n "$op"
    if test "$op" = 'init'
      set local_color_flag white
      set branch $op
    else
      set local_color_flag $custom_color_red
      set branch "$op:$branch"
    end
  else if test $dirty -gt 0 -o $new -gt 0
    set local_color_flag $custom_color_orange
  else if test $staged -gt 0
    set local_color_flag green
  else
    set local_color_flag brblack
  end


  set -l ahead_behind (__g2_prompt_aheadbehind $branch)

  __g2_debug_log "prompt_git| icon: $icon branch: $branch ahead_behind: $ahead_behind"
  __g2_color_print (__g2_enclose_in_brackets "$icon $branch $ahead_behind") $local_color_flag --bold
end

function __g2_debug_log -a text
  if test "$PROMPT_DEBUG" = "true"
    echo "$text" >> /tmp/fish_prompt_debug.log
  end
end



# ===========================
# Apply theme
# ===========================

function fish_prompt -d "Write out left part of prompt"
  set -g PROMPT_LAST_STATUS $status
  set -gx EXPORTEDPWD $PWD

  __g2_debug_log "-----------------------------------"

  __g2_prompt_status
  __g2_prompt_user
  __g2_prompt_path_segment "$PWD"
  __g2_prompt_git
  __g2_prompt_finish_segments
end

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo (__g2_enclose_in_brackets 'N')
    case insert
      set_color --bold green
      echo (__g2_enclose_in_brackets 'I')
    case replace_one
      set_color --bold green
      echo (__g2_enclose_in_brackets 'R')
    case visual
      set_color --bold brmagenta
      echo (__g2_enclose_in_brackets 'V')
    case '*'
      set_color --bold red
      echo (__g2_enclose_in_brackets '?')
  end
  echo " "; set_color normal
end

function fish_right_prompt -d "Write out the right prompt"
  if test "$dirstack[1]"
    test (count $dirstack) -gt 1; and set more " +";
    __g2_color_print (__g2_enclose_in_brackets (__g2_pretty_path "$dirstack[1]$more")) green --bold
  end
end

