# pssh4cssh

Use your existing [ClusterSSH](https://github.com/duncs/clusterssh) cluster groups with [parallel-ssh](https://parallel-ssh.org/) tools. No duplicate host lists -- one source of truth in `~/.clusterssh/clusters`, including nested group expansion.

## Requirements

```bash
sudo apt install pssh clusterssh
```

## Install

```bash
git clone https://github.com/oneidprod/pssh4cssh.git ~/Documents/pssh4cssh
```

Add to your `~/.bashrc`:

```bash
source ~/Documents/pssh4cssh/pssh4cssh.sh
```

Then reload (or open a new terminal):

```bash
source ~/.bashrc
```

## Usage

All commands take a cluster group name as the first argument, followed by the normal arguments for that tool.

### parallel-ssh -- run a command on all hosts in a group

```bash
pssh-c vps-all "uptime"
pssh-c vps-arm "df -h /"
pssh-c vps-amd "free -h"
```

### parallel-scp -- copy a file TO all hosts

```bash
pscp-c vps-all /local/file.conf /remote/path/
```

### parallel-rsync -- rsync to all hosts

```bash
prsync-c vps-all -r /local/dir/ /remote/dir/
```

### parallel-slurp -- pull a file FROM all hosts

```bash
pslurp-c vps-all /var/log/syslog ./logs/
```

## Nested groups

Groups that reference other groups in your clusters file are expanded recursively. For example if your clusters file contains:

```
vps-amd ubuntu@host1 ubuntu@host2
vps-arm ubuntu@host3 ubuntu@host4
vps-all vps-amd vps-arm
```

Then `pssh-c vps-all` will expand to all four hosts automatically.

## Custom clusters file

By default pssh4cssh reads `~/.clusterssh/clusters`. Override with:

```bash
export CSSH_CLUSTERS=/path/to/your/clusters
```
