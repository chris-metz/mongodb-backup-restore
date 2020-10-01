# mongodb-backup-restore

## initial setup

### docker

make sure docker is installed

### borgbackup

```bash
sudo apt install borgbackup
mkdir -p ~/borgbackups
borg init -e none borgbackups/mongodb
```

### environment files

Copy and adjust environment file

```bash
cp env-template environments/my-server-01
vi environments/my-server-01
```

Replicaset HOST example:

```bash
HOST=rs0/mongo01.myserver.com,mongo02.myserver.com,mongo03.myserver.com
```

## Creating Backups

> WARNING: the script has no existence or validity check for the environment file yet!

```bash
# run example:
/path/to/create_backup.sh /path/to/environments/my-server-01
```

## Restoring Backups

Extract backup to some location:

```bash
mkdir /home/chris/restore
cd /home/chris/restore
borg extract /home/chris/borgbackups/mongodb::2019-11-23-16-48-01
```

> WARNING: the script has no existence or validity check for the environment file yet!

```bash
# run example:
/home/chris/mongodb-backup-restore/restore_backup.sh /home/chris/mongodb-backup-restore/environments/my-server-01
```

## Links

- http://tully.io/mongodb-ssl/
- https://docs.mongodb.com/manual/tutorial/enable-authentication/
