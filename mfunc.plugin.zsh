# mfunc - meta function plugin for oh-my-zsh
#
# a wrapper for easier use of zshell's functions/autoload capabilities
#
# hlohm 2015
# github.com/hlohm
##################


#
# init
######

# make sure functions directory exists
if [ ! -d $ZSH/functions/ ]; then
    mkdir $ZSH/functions/
    echo "mfunc init: functions directory created in $ZSH"
fi

# autoload any functions in functions directory
[[ -e $ZSH/functions/* ]] && autoload $(ls $ZSH/functions/)


#
#functions
##########

# helper
function mfunc_define() {

            touch $ZSH/functions/$i
            chmod +x $ZSH/functions/$i
            echo "enter function '$i' and finish with CTRL-D"
            cat >$ZSH/functions/$i
            echo "new function '$i' created in $ZSH/functions"
            source $ZSH/custom/plugins/mfunc/mfunc.plugin.zsh
            echo "function is now available"
}
# make function(s)
function mfunc() {

    # berate user if no arguments given
    # to do: interactive mode
    if (($# == 0)); then
        echo "usage: mfunc [function name]"
    else
        # to do: prompt user to overwrite existing function
        for i do;
            mfunc_define $i
        done
    fi
}

# remove function(s)
function rfunc() {

    # demand argument
    # to do: interactive mode
    if (($# == 0)) ; then
        echo "please name at least one function to delete";
    fi

    # to do: autocompletion/wildcards
    for i; do
        if [ -e $ZSH/functions/$i ]; then
            rm $ZSH/functions/$i
            echo "function $i removed"
        else
            echo "function $i not found"
        fi
    done
    echo "functions will still be available until next login"
}

# list functions
function lfunc() {
    # to do: specific functions, wildcards
    for f in $(ls $ZSH/functions/); do
        echo $f "() {"; cat $ZSH/functions/$f; echo "}\n"
    done
}
