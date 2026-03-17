# Minimal Bash Prompt with Git + Python Virtualenv

A small, fast, and readable Bash prompt that shows:

* 🐍 Active Python virtual environment (with version)
* 🌿 Git branch + status (clean vs dirty)
* Clean two-line layout when needed
* Zero dependencies beyond standard Git tools

---

## ✨ Features

* **Git integration**

  * Branch name
  * Clean (green) vs dirty (orange) state
* **Python virtualenv awareness**

  * Shows env name + Python version
  * Disables default venv prompt override
* **Smart layout**

  * Single line when idle
  * Expands to two lines when Git or venv is active
* **Lightweight**

  * Pure Bash, no frameworks

---

## 📦 Requirements

* Bash
* Git (with `git-sh-prompt`, usually included)

On most systems, the Git prompt script is located at:

```bash
/usr/lib/git-core/git-sh-prompt
```

---

## 🚀 Installation

Clone the repository:

```bash
git clone https://github.com/hwblx/prompt_gv.git
cd prompt_gv
```

Add this line to your `~/.bashrc`:

```bash
source /path/to/prompt_gv.sh
```

Then reload your shell:

```bash
source ~/.bashrc
```

---

## 🧪 Quick Test (recommended)

Run a clean Bash session:

```bash
bash --noprofile --norc
```

Then load the prompt:

```bash
source ./prompt_gv.sh
```

---

## 🔍 What it looks like

### In a clean directory

```bash
user@folder$
```

### Inside a Git repo (clean)

```bash
(🌿 main)
user@repo$
```

### Inside a Git repo (dirty)

```bash
(🌿 main*)
user@repo$
```

### With Python virtualenv

```bash
(🐍 venv 3.11.2)
user@project$
```

### Combined

```bash
(🐍 venv 3.11.2) (🌿 main*)
user@project$
```

### Git Prompt Indicators Explained

| Symbol | Meaning |
|--------|---------|
| `*`    | Unstaged changes in working directory |
| `+`    | Staged changes ready to commit |
| `?`    | Untracked files present |
| `!`    | Stashed changes (if enabled) |
| `↑n`   | Branch is *n* commits ahead of upstream |
| `↓n`   | Branch is *n* commits behind upstream |
| `=`    | Branch is equal (in sync) with upstream |
| `#`    | No HEAD (fresh repository) |
| `%`    | Repo has untracked files (fresh repository) |

---

## ⚙️ Configuration

The prompt uses Git’s built-in `__git_ps1` with:

```bash
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=true
```

You can tweak these in `prompt.sh`.

---

## 🛠 Notes

* The script must be **sourced**, not executed:

  ```bash
  source prompt_gv.sh
  ```
* Designed for **Bash only**
* Tested on Linux environments

---

## 🧩 Customization Ideas

* Change colors (ANSI codes in script)
* Replace icons (🐍, branch symbol)
* Add exit status or execution time
* Add Kubernetes / Docker context

---

## 🐞 Troubleshooting

### No Git info showing

Make sure:

```bash
type __git_ps1
```

If not found, verify the path to `git-sh-prompt`.

---

### Prompt not updating

Check:

```bash
echo $PROMPT_COMMAND
```

Should output:

```bash
set_prompt
```

---

## 🙌 Acknowledgements

* Git’s `__git_ps1` prompt helper
* Inspired by minimal prompt setups and developer workflows

