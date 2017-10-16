#!/bin/bash
wget ${binary_src} -O /root/${app}
chmod 755 /root/${app}

echo "[Unit]
Description=go webserver
Documentation=nothing

[Service]
ExecStart=/root/${app} -platform=${platform}
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
" > /lib/systemd/system/${app}.service
systemctl enable ${app}
systemctl daemon-reload
systemctl start ${app}


