function prompt.getBranchOp
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

