#!/bin/bash

download_script() {
    wget -c https://www.dropbox.com/s/lfb5nr98umvgoly/crowntemp2.sh?dl=0 -O crowntemp2.sh
}

add_permission() {
    sudo chmod 755 crowntemp2.sh
}

add_cron_job() {
    cron_line2="0 16 * * * ./crowntemp2.sh"
    if [ `crontab -l 2>/dev/null | grep "$cron_line2" | wc -l` -eq 0 ]; then
        (crontab -l 2>/dev/null; echo "$cron_line2") | crontab -
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