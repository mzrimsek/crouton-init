while read ext; do
  code --install-extension $ext
done <extensions.txt