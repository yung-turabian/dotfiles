if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi="nvim"
    alias vim="nvim"

    alias quit="exit"
    alias q="exit"

    set -gx EDITOR nvim # enviro variable -gx
		set -gx PAGER less

		#set -g __fish_git_prompt_show_informative_status 1


		# function fish_right_prompt -d "Write out the right prompt"
		#  printf '%s@%s' $USER $hostname
		#end
end



# Created by `pipx` on 2024-06-26 22:08:01
set PATH $PATH /Users/hew_/.local/bin

# Need Bass, provided by fisherman
#bass source /usr/local/opt/chruby/share/chruby/chruby.sh --no-use ';' chruby ruby-3.1.3
#bass source /usr/local/opt/chruby/share/chruby/auto.sh

