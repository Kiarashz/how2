# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# NEW: get current AWS profile
function parse_aws_profile() {
    if [ ! -z "${AWS_DEFAULT_PROFILE}" ]; then
        echo " ☁️  ${AWS_DEFAULT_PROFILE} "
    elif [ ! -z "${AWS_PROFILE}" ]; then
        # Supporting both AWS_DEFAULT_PROFILE and AWS_PROFILE
        echo " ☁️  ${AWS_PROFILE} "
    else
        echo ""
    fi
}

# Updated PS1 with AWS profile information
export PS1="\[\e[37;44m\] \h \[\e[m\] \[\e[30;46m\] \d \[\e[m\] \[\e[42m\] \A \[\e[m\] \[\e[30;43m\] \W \[\e[m\] \[\e[30;45m\] \`parse_git_branch\` \[\e[m\] \[\e[36;40m\]\`parse_aws_profile\`\[\e[m\]\n\$ "
