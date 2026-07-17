YADD (YET ANOTHER DISTRO FOR DESKTOP)

### Issues
- Unable to work on Virtual machines

### Checks 
- Works on Qemu Machines 
'''
qemu-system-x86_64 -kernel ~/Desktop/YADD/zen-kernel/arch/x86/boot/bzImage \
  -initrd ~/Desktop/YADD/bootable/iso/boot/initramfs.cpio.gz \
  -append "console=ttyS0 init=/bin/sh" \
  -nographic
'''

### Builds
'''
Runs the build.sh script to make the .iso image
'''

### Dependencies 
'''
sudo apt install \
  build-essential \
  bison \
  flex \
  libncurses-dev \
  libssl-dev \
  libelf-dev \
  bc \
  git \
  cpio \
  wget \
  libc6-dev \
  grub-pc-bin \
  xorriso \
  mtools \
  qemu-system-x86
'''

### Sync configs 
- User the sync-configs.sh to sync before make any commit or build to make sure your build is based on yoru configurations
