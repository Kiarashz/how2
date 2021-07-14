for branch in $(git branch -r --sort=committerdate | xargs echo); do echo ============= $branch =============; git log -1 --since='Jan 01, 2021' -s $branch; done
