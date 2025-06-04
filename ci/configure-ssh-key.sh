install --mode=600 -D /dev/null ~/.ssh/id_ed25519
echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_ed25519
ssh-keyscan -H -p 53185 ${SSH_HOST} > ~/.ssh/known_hosts
