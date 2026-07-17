#!/bin/sh
# sync-configs.sh
# Run this from the repo root any time you've edited a config file in the repo
# (or right after cloning zen-kernel / busybox fresh) and need those repo
# configs placed into the right spots inside the build dirs before building.

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

placed=0

place_file() {
    src="$1"
    dst="$2"
    label="$3"

    if [ ! -f "$src" ]; then
        echo "  skip: $label (no repo copy at $src yet)"
        return
    fi

    dst_dir=$(dirname "$dst")
    if [ ! -d "$dst_dir" ]; then
        echo "  skip: $label (build dir '$dst_dir' doesn't exist — clone/build it first?)"
        return
    fi

    mkdir -p "$dst_dir"

    if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
        echo "  ok:   $label (already up to date)"
        return
    fi

    cp "$src" "$dst"
    echo "  placed: $label -> $dst"
    placed=1
}

echo "Applying repo configs into build dirs..."

place_file "kernel.config"       "zen-kernel/.config"      "kernel .config"
place_file "busybox.config"      "busybox/.config"         "busybox .config"
place_file "initramfs/init"      "busybox/_install/init"   "initramfs init script"
place_file "grub/grub.cfg"       "iso/boot/grub/grub.cfg"  "grub.cfg"

echo ""
if [ "$placed" = "1" ]; then
    echo "Configs applied. You can now build:"
    echo "  cd zen-kernel && make olddefconfig && make -j\$(nproc) bzImage"
    echo "  cd busybox && make olddefconfig && make -j\$(nproc) && make install"
else
    echo "Nothing to apply — build dirs already match repo."
fi
