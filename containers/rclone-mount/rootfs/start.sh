#!/bin/sh

function term_handler {
  unmount_rclone
  echo "exiting container now"
  exit 0
}

function unmount_rclone {
#check if rclone gracefully unmounted
  if grep -Eq ''$RemotePath'.*'$MountPoint'|'$MountPoint'.*'$RemotePath'' /proc/mounts; then
      echo -e "Force unmounting with fusermount $UnmountCommands at: $(date +%Y.%m.%d-%T)"
      fusermount $UnmountCommands $MountPoint
      wait ${!}
      exit 1
  else
      #cleanup of mount namespace
      umount $MountPoint
      echo -e "Successful unmounted"
      exit 0
  fi
}

echo -e "Starting rclone mount $(date +%Y.%m.%d-%T)"

#trap term_handler SIGHUP SIGINT SIGTERM

## ECHO DEBUG
if [ "$DEBUG" = true ]; then
    echo -e "${PREFFIX} [DEBUG] command: /usr/local/sbin/rclone --config $ConfigPath mount $RemotePath $MountPoint $MountCommands"
fi

/usr/bin/rclone --config $ConfigPath mount $RemotePath $MountPoint $MountCommands

/usr/sbin/nginx -g "daemon off;"