ssh ssh://${SSH_USER}@${SSH_HOST}:53185 /usr/bin/docker compose --file /home/${SSH_USER}/syncthing/coruscant/compose.yaml pull four-oh-four
ssh ssh://${SSH_USER}@${SSH_HOST}:53185 /usr/bin/docker compose --file /home/${SSH_USER}/syncthing/coruscant/compose.yaml up --detach four-oh-four
