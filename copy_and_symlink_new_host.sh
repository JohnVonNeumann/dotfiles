#!/bin/bash

# So in this, I'm checking if weechat is installed, which could probably be done
# with a different command, like an `apt show blah` or something of the like.
# But I can refactor later if necessary. Ulimately though, it would appear there
# that there could be edge cases where I'm unintendedly blapping files that have
# had updates made to them.

#TODO look up a style guide and write consistent code to standard
#TODO do similar checks for all files included in the dotfiles directory

WEECHAT_DIR=~/.weechat

if [ -x "/usr/bin/weechat" ] 
    then
        for each in $( ls $PWD/weechat/ ); do
            if diff $WEECHAT_DIR/$each $PWD/weechat/$each
                then
                    # Use printf for cleaner colour formatting than echo
                    printf "\e[32m Weechat $each: No changes to be made."
                    # reset the colour back to normal, otherwise to it continue
                    echo -e "\033[0m"
                else
                    printf "\e[31m Weechat $each: Changes to be made."
                    echo -e "\033[0m"
            fi
            echo $PWD/weechat/$each
        done
    else
        echo "Weechat: Not installed. Use Ansible playbooks."
fi
#if [ -x "/usr/bin/weechat" ] 
#    then
#        for each in $( ls $PWD/weechat/ ); do
#            if diff $WEECHAT_DIR/$each $PWD/weechat/$each >/dev/null
#                then
#                    echo "Weechat: No change to be made."
#                else
#                    sudo ln -sf $PWD/weechat/$each ~/.weechat/$each
#            fi
#            echo $PWD/weechat/$each
#        done
#    else
#        echo "Weechat: Not installed. Use Ansible playbooks."
#fi
