# find local branches that do not exist on remote anymore
for branch in $(git branch -r --sort=committerdate | xargs echo); do echo ============= $branch =============; git log -1 --since='Jan 01, 2021' -s $branch; done

# find commit by message
$ git log --all --grep='my commit message'
commit 111111111111111111111111111111111111111
Author: xxxxxxxxxxxxxxx
Date:   xxxxxxxxxxxxxxxx
. . .


# find branch where commit was first made
$ git name-rev --name-only --exclude=tags/*  111111111111111111111111111111111111111
remotes/origin/BRANCH-WHERE-COMMIT-WAS-MADE

# search for a code pattern in branches
for branch in $(git branch); do git grep --max-depth -1 -i 're\.sub.*/' $branch -- ':(exclude)*.js'; done
