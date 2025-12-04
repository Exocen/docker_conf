## 🐳 Docker samples

Docker configuration samples, with helper tools
Works with docker.io and msmtp, no need for docker-compose

| Docker container | Base image pull (*custom) | Arguments | Comments |
| --- |  --- |  --- |  --- |
| Filebrowser | **filebrowser/filebrowser** | **$FILEBROWSER_PATH** | |
| FmdServer | **registry.gitlab.com/fmd-foss/fmd-server** | | Behind nginx_certbot proxy |
| Gitea | **gitea/gitea** |  | Behind nginx_certbot proxy |
| Gluetun | **qmcgaw/gluetun** | **$VPN_KEY** | |
| Jdownloader2 | **jlesage/jdownloader-2*** | **$JDOWNLOADER_DL_PATH** | Behind gluetun network |
| Nginx_certbot | **nginx:mainline-alpine*** | **$DOMAIN** | Allows redirection for gitea, vaultwarden, fmd, and snappymail containers<br>Creates and renews certifications with certbot automatically |
| Install_test | * | **$IMAGES** | Debian, Ubuntu, Fedora, Alpine, Archlinux, vcatechnology/linux-mint, and Manjarolinux/base are used by default |
| Mail_server | **mailserver/docker-mailserver** | **$MAIL_DOMAIN** | Add/Del mail accounts with *setup-mail.sh*<br>Creates opendkim conf with *setup-opendkim.sh*<br>*smtp_sample* available |
| Snappymail | **djmaze/snappymail** | | For the first time configuration use *mail.domain.com/?admin*.<br>Accepts user *admin* and password from */docker-data/snappymail/_data_/_default_/admin_password.txt*<br>Behind nginx_certbot proxy |
| Syncthing | **syncthing/syncthing*** | **$SYNCTHING_PATH** | Behind gluetun network |
| Transmission | **lscr.io/linuxserver/transmission** | **$TRANSMISSION_DL_PATH** | Behind gluetun network |
| Vaultwarden | **vaultwarden/server** | **$VW_ADMIN_PASS_ENABLED** |  **$VW_ADMIN_PASS_ENABLED** allows https://VW-DOMAIN/admin access<br>Behind nginx_certbot proxy |
| Ydl | **alpine*** | **$YDL_MUSIC_PATH** | Behind gluetun network |
| Firefox | **jlesage/firefox*** | | Behind gluetun network |

<br>Each configuration
* use a docker-run.sh script to build and run the container
* use detached and volatiles containers(-d --rm)
* use */docker-data* and */docker-data-nobackup* dir for data storage
* share localtime and timezone with the host
* log to journald
* could be started independently with args or grouped with */tools/manager*

### Docker Tools

#### Backup
*ssh-backup* script is used to backup the */docker-data* dir from a host or locally.\
./*ssh-backup* $host $output_dir\
*vaultwarden-db-backup* script create a backup from the local */docker-data/vaultwarden/sqlite.db*.

#### Docker_manager
Script created to manage all docker containers *(one to rule them all)*.\
Can start containers, allows auto-heal, forwards errors with msmtp, and could be started with systemd.\
./docker_manager $start||stop||reload $conf_file (*tun_conf* or *vps_conf* samples)

#### Fail2ban
Fail2ban configuration sample for every containers. The script installs every jails and filters.

#### Notification and Mails
*msmtp_sample* and *feed-update.sh* script (allow *atom.xml* update) availables.
