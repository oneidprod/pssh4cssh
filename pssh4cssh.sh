# pssh4cssh -- pssh helper functions that read ClusterSSH cluster groups
# Source this file from ~/.bashrc:
#   source ~/Documents/pssh4cssh/pssh4cssh.sh

CSSH_CLUSTERS="${CSSH_CLUSTERS:-$HOME/.clusterssh/clusters}"

_cluster_hosts() {
  local group=$1
  local members
  members=$(grep "^$group " "$CSSH_CLUSTERS" | sed "s/^$group //" | tr ' ' '\n')
  local result=()
  while IFS= read -r member; do
    [[ -z "$member" ]] && continue
    if grep -q "^$member " "$CSSH_CLUSTERS"; then
      while IFS= read -r host; do
        result+=("$host")
      done < <(_cluster_hosts "$member")
    else
      result+=("$member")
    fi
  done <<< "$members"
  printf '%s\n' "${result[@]}" | sort -u
}

pssh-c() {
  local group=$1; shift
  local hosts=()
  while IFS= read -r h; do hosts+=(-H "$h"); done < <(_cluster_hosts "$group")
  parallel-ssh "${hosts[@]}" -i "$@"
}

pscp-c() {
  local group=$1; shift
  local hosts=()
  while IFS= read -r h; do hosts+=(-H "$h"); done < <(_cluster_hosts "$group")
  parallel-scp "${hosts[@]}" "$@"
}

prsync-c() {
  local group=$1; shift
  local hosts=()
  while IFS= read -r h; do hosts+=(-H "$h"); done < <(_cluster_hosts "$group")
  parallel-rsync "${hosts[@]}" "$@"
}

pslurp-c() {
  local group=$1; shift
  local hosts=()
  while IFS= read -r h; do hosts+=(-H "$h"); done < <(_cluster_hosts "$group")
  parallel-slurp "${hosts[@]}" "$@"
}
