cat <<EOT > extensions.txt
`code --list-extensions`
EOT

GIT_STATUS=$(git status --short)
if [ "$GIT_STATUS" != "" ]; then
  git commit -am "Update extensions"
  git push
fi