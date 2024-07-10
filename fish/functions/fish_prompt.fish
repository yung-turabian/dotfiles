function fish_prompt
    set_color brgreen
    echo -n (prompt_pwd)
    set_color normal
    echo -n ' ❱ '
end
