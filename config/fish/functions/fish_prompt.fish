function fish_prompt
		
		set -l symbol 'λ'

		set -l last_status $status
    # Prompt status only if it's not 0
    if test $last_status -ne 0
        set symbol (set_color black)"$symbol "(set_color normal)
				#else if $program_running -eq 0
				#set symbol (set_color cyan)" $symbol "(set_color normal)
		else
				set symbol (set_color 8c7e73)"$symbol "(set_color normal)
    end
		
		string join '' -- (set_color dadc56) \
				(prompt_pwd) (set_color normal) \
				" $(fish_svn_prompt)" (set_color normal) \
				\n $symbol
		

end
