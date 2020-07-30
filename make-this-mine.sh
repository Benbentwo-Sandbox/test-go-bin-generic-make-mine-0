if [[ "${GITHUB_WORKSPACE}" ]]; then
		echo "Repo: ${GITHUB_REPOSITORY}"
		cd ${GITHUB_WORKSPACE}
		egrep -lRZ '${GITHUB_REPOSITORY}' . | grep -v Makefile | xargs -0 -l sed -i -e 's@Benbentwo@go-bin-generic@${GITHUB_REPOSITORY}/g'
		#sed -i 's@${GITHUB_REPOSITORY}@${GITHUB_REPOSITORY}@g' go.mod
else  # someones local
		read -r -p "Do you want to continue? [y/N] " response
		case "$response" in
			[yY][eE][sS]|[yY])
				continue
				;;
			*)
			  echo "Exiting..."
				exit 0
				;;
		esac
		GITHUB_REPOSITORY=$(git remote get-url origin | awk -F 'github.com/' '{print $2}' | awk -F '.git' '{print $1}')
		echo "GITHUB REPOSITORY: ${GITHUB_REPOSITORY}"
		find . -type f \( -iname \*.mod -o -iname \*.go \) -print0 | xargs -0 sed -i "" "s@${GITHUB_REPOSITORY}@${GITHUB_REPOSITORY}@g"
fi
