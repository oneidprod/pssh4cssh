# pssh4cssh

Use your existing [ClusterSSH](https://github.com/duncs/clusterssh) cluster groups with [parallel-ssh](https://parallel-ssh.org/) tools. No duplicate host lists -- one source of truth in `~/.clusterssh/clusters`, including nested group expansion.

## Requirements

```bash
sudo apt install pssh clusterssh
```

## Install

```bash
git clone https://github.com/oneidprod/pssh4cssh.git /path/to/pssh4cssh
```

Add to your `~/.bashrc` (use the path where you cloned it):

```bash
source /path/to/pssh4cssh/pssh4cssh.sh
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

## Donate

If you find this useful, tips are appreciated:

| Coin | Address |
|-|-|
| LTC | `LWpuHQUGw3qZg8MCHYGgTPRZ3a1i8jc5u3` |
| BTC | `bc1qw0t40dunylgtz9kgfylwxac3a8vwp70cgrga5r` |
| SOL | `up9YvW6ewNati5fmmDjGHzFbq8UkSbHPccoDNzijk3G` |
| POL | `0x5198f52fA768294ae66f0cB75A98DCc895a36F2E` |
| DOGE | `DJAg2fTzS5vN3yXDPn5gGPz9JSmzJn3cXD` |

## Custom clusters file

By default pssh4cssh reads `~/.clusterssh/clusters`. Override with:

```bash
export CSSH_CLUSTERS=/path/to/your/clusters
```
