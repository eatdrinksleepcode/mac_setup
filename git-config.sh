# Git config is done in this file instead of copying .gitconfig to
# prevent overwriting settings in that file (such as user.email)
git config --global advice.addIgnoredFile false
git config --global advice.detachedHead false

git config --global alias.co checkout
git config --global alias.fixup "commit -a --amend --no-edit"
git config --global alias.unstage "reset HEAD --"
git config --global alias.log-all "log --all --graph --decorate --graph"
git config --global alias.log-ahead "log @{u}.."
git config --global alias.default-branch "!basename $(git rev-parse --abbrev-ref origin/HEAD)"
git config --global alias.lol-branch "!git lol ${1:-$(git default-branch)}.."
git config --global alias.diff-branch "!git diff ${1:-$(git default-branch)}... #"
git config --global alias.exec-branch "!git rebase -i --keep-base ${2:-$(git default-branch)} --exec \\\"${1:-}\\\" #"
git config --global alias.rebase-branch "!git rebase -i --keep-branch ${1:-$(git default-branch)}"
git config --global alias.branch-cleanup "!git branch -d $(git branch --list | grep -v \"^*\")"
git config --global alias.lol "log --pretty=format:'%Cgreen%ad%Creset %C(auto)%h%d %s %C(bold blue)<%aN>%Creset' --date=format-local:'%Y-%m-%d %H:%M (%a)'"
git config --global alias.ff "merge --ff-only @{u}"
git config --global alias.unpushed "lol --branches --tags --not --remotes --no-walk"

git config --global core.autocrlf input
git config --global core.excludesfile "~/.gitignore_global"

git config --global fetch.prune true

git config --global init.defaultBranch main

git config --global log.abbrevcommit true

git config --global merge.autostash true

git config --global pull.rebase true

git config --global push.default current

git config --global rebase.autostash true

git config --global submodule.recurse true
