#!/usr/bin/env fish

function show_help
    set progname (basename (status -f))
    echo 'Usage: $progname <SecureNoteName> <user@host>
'
end

function lastpass_userprompt
    echo "LastPass Username>"
end

function lastpass_login
    lpass status -q > /dev/null
    if test $status -ne 0
        read -l -p lastpass_userprompt lpuser
        lpass login $lpuser
        if test $status -ne 0
            set_color red
            echo "Unable to authenticate to LastPass!"
            set_color normal
            exit 1
        end
    end
end

function lastpass_sync
    set_color blue
    echo "Starting LastPass sync..."
    lpass sync
    if test $status -ne 0
        set_color red
        echo "Error syncing LastPass!"
        set_color normal
        exit 1
    end
    echo "Sync complete."
    set_color normal
end

if test (count $argv) -lt 2 > /dev/null
    show_help
    exit 1
end

lastpass_login
lastpass_sync

set lpassitem $argv[1]
set sshargs $argv[2..-1]

lpass show -c $lpassitem > /dev/null
if test $status -ne 0
    set_color red
    echo 'Error retrieving values from LastPass.

Please make sure secret is stored as a Secure Note of type SSH Key inside of LastPass.'
        set_color normal
        exit 1
end

ssh -i (lpass show $lpassitem --field="Private Key" | psub) $sshargs
