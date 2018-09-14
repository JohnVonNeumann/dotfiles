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
        if diff $WEECHAT_DIR/irc.conf $PWD/weechat/irc.conf >/dev/null
            then
                echo "Weechat: No change to be made."
            else
                sudo ln -sf $PWD/weechat/irc.conf ~/.weechat/irc.conf
        fi
    else
        echo "Weechat: Not installed. Use Ansible playbooks."
fi
