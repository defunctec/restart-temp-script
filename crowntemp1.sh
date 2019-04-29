#!/bin/bash

download_script() {
    wget "https://www.dropbox.com/s/ww1nc79eh7qdqqh/crowntemp2.sh?dl=0"
}

add_permission() {
    sudo chmod 755 crowntemp2.sh
}

add_cron_job() {
    cron_line="0 15 20 * * ./crowntemp2.sh"
    if [ `crontab -l 2>/dev/null | grep "$cron_line" | wc -l` -eq 0 ]; then
        (crontab -l 2>/dev/null; echo "$cron_line") | crontab -
    fi
}

main() {
	# (Quietly) Stop crownd (in case it's running)
    /usr/local/bin/crown-cli stop 2>/dev/null
    # Download script
    download_script
    # Permissions for script
    add_permission
    # Ensure there is a cron job to restart crownd on reboot
    add_cron_job
   	# Allow wallet to shutdown
   	sleep 300
    # Start Crownd to begin sync
    /usr/local/bin/crownd
}

handle_arguments "$@"
main