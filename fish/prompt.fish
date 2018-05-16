#!/usr/bin/fish

# Git glyphs
set branch_glyph ''
set detached_glyph "➦"
set pull_pending_glyph '⬇'
set push_pending_glyph '⇧'

# Other glyphs
set prompt_finisher_glyph '❱ '


# ===========================
# String Helper methods
# ===========================

function __g2_color_print -a text color
    set_color $color $argv[2..-1]
    echo -ne $text
    set_color normal
end

function __g2_enclose_in_brackets
    emit print_debug "prompt" "enclose_in_brackets| argv: $argv"
    echo -ne "⦗"$argv"⦘"
end


# ===========================
# Git Helper methods
# ===========================

function __g2_prompt_getBranchOp
    set -l git_dir (git_repository_root)
    or return 1

    # get repo status & branch name
    set -l op ''
    set -l branch ''

    command git ls-tree HEAD >/dev/null ^/dev/null

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
                test ! "$op"
                and set op 'detached'
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

    emit print_debug "prompt" "getBranchOp| branch: $branch"
    echo (string replace --all "refs/heads/" "" $branch)
    echo $op
end


# ===========================
# Apply theme
# ===========================

function fish_prompt -d "Write out left part of prompt"
    set -g PROMPT_LAST_STATUS $status

    begin # Prints the status segment
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
    begin # Prints user if sudo is active or user@hostname if shell is in a ssh session
        __g2_enclose_in_brackets (
        if [ "$theme_display_user" = "true" -o -n "$SUDO_USER" ]; or ILTIS_is_remote
          echo -en (whoami)
          if [ -n "$SUDO_USER" ]
            echo -en "($SUDO_USER)"
          end
        end
        if ILTIS_is_remote
          echo -en "@"(prompt_hostname)
        end
        )
    end
    begin # Prints the prettyfied pwd
        __g2_color_print (__g2_enclose_in_brackets (prompt_pwd))" " $custom_color_medium_blue
    end

    begin # Prints some status information about git
        if git_is_repo
            set -l v (__g2_prompt_getBranchOp)
            set -l branch $v[1]
            set -l op $v[2]

            set -l icon "$branch_glyph"
            test "$op" = "detached"
            and set icon "$detached_glyph"


            if test -n "$op"
                if test "$op" = 'init'
                    set local_color_flag white
                    set branch $op
                else
                    set local_color_flag $custom_color_red
                    set branch "$op:$branch"
                end
            else if git_is_touched
                or git_untracked_files >/dev/null
                set local_color_flag $custom_color_orange
            else if git_is_staged
                set local_color_flag green
            else
                set local_color_flag brblack
            end

            set -l ahead_behind (git_ahead)

            emit print_debug "prompt" "prompt_git| icon: $icon branch: $branch ahead_behind: $ahead_behind"
            __g2_color_print (__g2_enclose_in_brackets "$icon $branch $ahead_behind") $local_color_flag --bold
        end
    end

    begin # Prints the finishing glyph
        __g2_color_print $prompt_finisher_glyph green --bold
    end

    emit flush_fish_debug "/tmp/fish_prompt_debug.log"
end

function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo -en (__g2_enclose_in_brackets 'N')
        case insert
            set_color --bold green
            echo -en (__g2_enclose_in_brackets 'I')
        case replace_one
            set_color --bold green
            echo -en (__g2_enclose_in_brackets 'R')
        case visual
            set_color --bold brmagenta
            echo -en (__g2_enclose_in_brackets 'V')
        case '*'
            set_color --bold red
            echo -en (__g2_enclose_in_brackets '?')
    end
    echo -en " "
    set_color normal
end

function fish_right_prompt -d "Write out the right prompt"
    if test "$dirstack[1]"
        test (count $dirstack) -gt 1
        and set more " +"

        function __g2_pretty_path -a path
            echo -n (string replace "$HOME" "~" $path | string replace --all --regex "(?'short'\.?[^/])[^/]*/" "\$short/")
        end

        __g2_color_print (__g2_enclose_in_brackets (__g2_pretty_path "$dirstack[1]$more")) green --bold
    end
end

