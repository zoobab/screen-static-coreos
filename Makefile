build: torcx.tgz torcx.squashfs

torcx:
	mkdir -p rootfs/bin
	cp bin/screen rootfs/bin/

torcx.tgz: torcx
	tar -C rootfs -czf torcx.tgz .

torcx.squashfs: torcx
	mksquashfs rootfs torcx.squashfs
