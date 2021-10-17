# DO NOT USE
# OR RATHER READ IT AND THEN USE
# ONLY WORKS FROM THE PROJECT DIR
# WILL PUBLISH STUFF ON THE WEBSITE, DON'T SCREW UP
BUILD_DIR="gh-pages"
echo "BUILD_DIR->${BUILD_DIR}"
OLD=${PWD}
echo "OLD->${OLD}"
ORIGIN_URL=$(git config --get remote.origin.url)
echo "ORIGIN_URL->${ORIGIN_URL}"
echo "->${PWD}/build-html-docker-inside-docker.sh"
${PWD}/build-html-docker-inside-docker.sh
#echo "*******************************"
#ls -lah ${OLD}/${BUILD_DIR}
#echo "*******************************"
#exit 0
cd $BUILD_DIR
echo "GIT_GLOBAL_MAIL->${GIT_GLOBAL_MAIL}"
echo "GIT_GLOBAL_USER_NAME->${GIT_GLOBAL_USER_NAME}"
git config --global user.email ${GIT_GLOBAL_MAIL}
git config --global user.name ${GIT_GLOBAL_USER_NAME}
git init
git add .
git commit -m "$GIT_GLOBAL_USER_NAME - rebuilding gh-pages $(date)"

# rename branch to 'main' if necessary
CURRENT_BRANCH=$(git branch --show-current)
echo "current branch: $CURRENT_BRANCH"
if [ "$CURRENT_BRANCH" != "main" ]
then
  git branch -M main
  echo "branch $CURRENT_BRANCH renamed to 'main'"
else
  echo "branch $CURRENT_BRANCH not renamed"
fi

git remote add origin $ORIGIN_URL


# echo gh-pages url
IFS='/' read -ra TEMP <<< "$ORIGIN_URL"
#for i in "${TEMP[@]}"; do
#    # process "$i"
#    echo "$i"
#done
REPO_NAME=${TEMP[4]}
echo
echo "***********************************************************"
echo trying to create gh-pages under following url
echo https://${TEMP[3]}.github.io/${REPO_NAME%.*}
echo "***********************************************************"
