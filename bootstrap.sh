#!/bin/bash

set -e

[ ! -f /data/btsync.conf ] && cat > /data/btsync.conf <<"EOF"
{
	"device_name": "btshare.io",
	"listening_port" : 0,
	"storage_path" : "/btsync",
	"display_new_version": false,
	"vendor" : "tuxpoldo",
	"use_upnp" : false,
	"download_limit" : 0,
	"upload_limit" : 0, 
	"webui" :
	{
	},
	"shared_folders" :
	[
		{
		"secret" : "ENV_SECRET",
		"dir" : "/data",
		"use_relay_server" : true,
		"use_dht" : false,
		"search_lan" : true,
		"use_sync_trash" : false
		}
	]
}
EOF

sed -i "s/ENV_SECRET/$SECRET/g" /data/btsync.conf 

/usr/local/bin/btsync --nodaemon --config /data/btsync.conf
