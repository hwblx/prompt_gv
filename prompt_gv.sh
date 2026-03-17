#!/usr/bin/env bash

# --- Git prompt configuration ---
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=true

# Try to source git prompt script (portable)
if ! command -v __git_ps1 &>/dev/null; then
    GIT_PROMPT_PATH="$(git --exec-path 2>/dev/null)/git-sh-prompt"
    if [ -f "$GIT_PROMPT_PATH" ]; then
        # shellcheck disable=SC1090
        source "$GIT_PROMPT_PATH"
    elif [ -f /usr/share/git/completion/git-prompt.sh ]; then
        source /usr/share/git/completion/git-prompt.sh
    elif [ -f /usr/lib/git-core/git-sh-prompt ]; then
        source /usr/lib/git-core/git-sh-prompt
    fi
fi

# Disable Python venv PS1 override
export VIRTUAL_ENV_DISABLE_PROMPT=1

# --- Prompt function ---
set_prompt() {
    local venv=""
    local git=""
    local newline=""
    local pyver=""

    # Colors (wrapped for Bash prompt safety)
    local cyan="\[\033[1;36m\]"
    local green="\[\033[1;32m\]"
    local white="\[\033[1;37m\]"
    local orange="\[\033[38;5;208m\]"
    local reset="\[\033[0m\]"

    # Icons (may be disabled if rendering issues occur)
    local pysnake="🐍"
    local gitbranch=$'\ue725'

    # --- Python virtualenv ---
    if [ -n "$VIRTUAL_ENV" ]; then
        if command -v python &>/dev/null; then
            pyver=$(python --version 2>&1)
        elif command -v python3 &>/dev/null; then
            pyver=$(python3 --version 2>&1)
        fi
        venv="${cyan}(${pysnake} $(basename "$VIRTUAL_ENV") ${pyver#Python }) ${reset}"
    fi

    # --- Git status ---
    if command -v __git_ps1 &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
        if git diff --quiet 2>/dev/null && git diff --cached --quiet 2>/dev/null; then
            # clean repo
            git="$(__git_ps1 "\[${green}\](${gitbranch} %s)\[${reset}\]")"
        else
            # dirty repo
            git="$(__git_ps1 "\[${orange}\](${gitbranch} %s)\[${reset}\]")"
        fi
    fi

    # --- Layout ---
    if [ -n "$venv" ] || [ -n "$git" ]; then
        newline="\n"
    fi

    PS1="${venv}${git}${newline}${white}\u@\w${reset}\$ "
}

PROMPT_COMMAND=set_prompt

