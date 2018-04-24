function nodeenv_prompt_info(){
  [[ -n ${NODE_VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_NODEENV_PREFIX:=[}${NODE_VIRTUAL_ENV:t}${ZSH_THEME_NODEENV_SUFFIX:=]}"
}

# disables prompt mangling in virtual_env/bin/activate
export NODE_VIRTUAL_ENV_DISABLE_PROMPT=1
