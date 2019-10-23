# Defined in /tmp/fish.ddj6jc/fish_prompt.fish @ line 2
function fish_prompt --description 'Write out left part of prompt'
	set -g PROMPT_LAST_STATUS $status

  set -x branch_glyph ''
  set -x detached_glyph "➦"
  set -x pull_pending_glyph '⬇'
  set -x push_pending_glyph '⇧'
  set -x prompt_finisher_glyph '❱ '

    begin # Prints the status segment
        # Print non-zero exit status
        if test $PROMPT_LAST_STATUS -ne 0
            util.colorPrint (util.encloseInParentheses "⚡") $custom_color_red --bold #--background red
        end

        # Print super-user glyph
        if test (id -u $USER) -eq 0
            util.colorPrint (util.encloseInParentheses "SU") red --bold
        end

        # Print background-jobs glyph
        if test (jobs -l | wc -l) -gt 0
            util.colorPrint (util.encloseInParentheses "BG") $custom_color_yellow --bold
        end
    end
    begin # Prints user if sudo is active or user@hostname if shell is in a ssh session
        util.encloseInParentheses (
        if [ "$theme_display_user" = "true" -o -n "$SUDO_USER" ]; or util.isSSHSession
          echo -en (whoami)
          if [ -n "$SUDO_USER" ]
            echo -en "($SUDO_USER)"
          end
        end
        if util.isSSHSession
          echo -en "@"(prompt_hostname)
        end
        )
    end
    begin # Prints the prettyfied pwd
        util.colorPrint (util.encloseInParentheses (prompt_pwd))" " $custom_color_medium_blue
    end

    begin # Prints some status information about git
        if git_is_repo
            set -l v (prompt.getBranchOp)
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
            util.colorPrint (util.encloseInParentheses "$icon $branch $ahead_behind") $local_color_flag --bold
        end
    end

    begin # Prints the finishing glyph
        util.colorPrint $prompt_finisher_glyph green --bold
    end

    emit flush_fish_debug "/tmp/fish_prompt_debug.log"
end
