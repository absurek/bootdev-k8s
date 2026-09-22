enable_cgroup_v2_nesting() {
  if [ ! -f /sys/fs/cgroup/cgroup.controllers ]; then
    return 0
  fi
  mkdir -p /sys/fs/cgroup/init
  xargs -rn1 < /sys/fs/cgroup/cgroup.procs > /sys/fs/cgroup/init/cgroup.procs || true
  sed -e 's/ / +/g' -e 's/^/+/' < /sys/fs/cgroup/cgroup.controllers \
    > /sys/fs/cgroup/cgroup.subtree_control || true
}

enable_cgroup_v2_nesting

mkdir -p /etc/docker
printf '%s\n' '{"no-new-privileges": false}' > /etc/docker/daemon.json

start-docker.sh
exec "$@"
