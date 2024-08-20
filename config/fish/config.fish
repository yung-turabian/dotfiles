if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi="nvim"
    alias vim="nvim"

    alias quit="exit"
    alias q="exit"

		alias la="ls -a"

    set -gx EDITOR nvim # enviro variable -gx
		set -gx PAGER less

		#set -g __fish_git_prompt_show_informative_status 1


		# function fish_right_prompt -d "Write out the right prompt"
		#  printf '%s@%s' $USER $hostname
		#end
		
		# Created by `pipx` on 2024-04-18 01:47:00
		set PATH $PATH /home/henry/.local/bin

		set GOPATH $GOPATH /home/henry/go
		set PATH $PATH "$GOPATH/bin"
		set PATH $PATH "/Users/hew_/.local/bin"

		alias valgrind_full='valgrind --leak-check=full --show-leak-kinds=all'
end

# Setup SSH-AGENT
fish_ssh_agent

alias fman="complete -C | fzf | xargs man"

alias motherboard="sudo dmidecode -t 2"

alias emsdk_setup ". ~/emsdk/emsdk_env.fish"

# Need Bass, provided by fisherman
#bass source /usr/local/opt/chruby/share/chruby/chruby.sh --no-use ';' chruby ruby-3.1.3
#bass source /usr/local/opt/chruby/share/chruby/auto.sh

