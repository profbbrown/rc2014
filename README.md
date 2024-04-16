# RC2014 Emulator

This is a Docker image that will emulate the RC2014 Z80 retro computer using
RomWBW so that it can run CP/M.

The project exists because I wanted an easy way to spin up the emulator without
having to compile the emulator in all its variants and keep around the RomWBW files.

It was also a way for me to learn about Docker multi-stage builds.

# Usage

```
docker run -it rc2014
```

By default, the emulator will boot up with a 128MB virtual IDE disk with the following slices:

| Slice | Description |
----|---------
| 0 | ZSDOS |
| 1 | Turbo Pascal |
| 2 | Games |
| 3 | Aztec C |

The virtual disk is emphemeral. You can mount an alternative directory under `/disk`
and the emualtor will create the virtual disk there as `disk.ide`.

# Future Direction

- [ ] Use an environment variable to control which IDE disk is used.
- [ ] Use an environment variable to control which ROM file is used.
- [ ] Allow multiple disks to be mounted.
- [ ]  Implement a mode in which the container will, instead of booting the emulator, will
  allow some utilities to be run instead. For example, utilities to copy slices
  in and out of the disk, or to copy files in and out of a slice.
