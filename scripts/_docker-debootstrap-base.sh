#!/usr/bin/env bash

# repository related
IMAGE="pro-manage.net/debian-bootstrap"
CODENAME="wheezy"
MIRROR="http://mirrors.linode.com/debian/"
SECTIONS="main contrib non-free"
SOFTWARE="iproute,iputils-ping,apt-utils"

# build related
WORKDIR="/opt/dockerbuilds"
DOCKER_SRC="$WORKDIR/src"
DOCKER_DEBOOTSTRAP="$DOCKER_SRC/contrib/mkimage-debootstrap.sh"
TMPDIR="/tmp"

# ./mkimage-debootstrap.sh pro-manage.net/debian wheezy http://mirrors.linode.com/debian/

print_error()
{
	echo "ERROR: $@"
	exit 1
}

print_warn()
{
	echo "WARNING: $@"
}

run()
{
	sh -c "$@"
	[[ $? == 0 ]] || print_error "command failed: $!"
	return 0
}

is_set()
{
	local var="$1"
	[[ ! ${!var} && ${!var-unset} ]] && print_error "variable not set"
}

dir_exists()
{
	[[ -d "$1" ]] || mkdir -p "$1" || print_error "$1 directory creation failed"
}

file_exists()
{
  [[ -f "$1" ]] || print_error "$1 file not exists!"
}

disk_enough()
{
	local path="$1"
	local size="$2"

	run "/bin/mountpoint $path"

	#[[ -f "$mountpoint" ]] || print_warn "could not check free space on $path"

	#local device=
	#[[ device=$($mountpoint $path) ]] || print_error "$device"
 #	&& device=$("$mountpoint" -d "$path") || print_error ""
 #	|| print_error "disk "
}

# checking paths
dir_exists "$WORKDIR"
dir_exists "$DOCKER_SRC"
file_exists "/opt/dockerbuilds/src/contrib/mkimage-debootstrap.sh"
#disk_enough "/tmp" "2"

echo "/opt/dockerbuilds/src/contrib/mkimage-debootstrap.sh -i '$SOFTWARE' $IMAGE $CODENAME $MIRROR"


