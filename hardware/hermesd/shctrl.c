/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#define SSP_DEVICE "/dev/ssp"
#define SSP_IOCTL_MAGIC 'c'
#define SSP_IOCTL_INIT _IO(SSP_IOCTL_MAGIC, 1)
#define SSP_IOCTL_EXIT _IOWR(SSP_IOCTL_MAGIC, 2, uint64_t)

void hwvault_ssp_init() {
    int fd = open(SSP_DEVICE, O_RDONLY);
    ioctl(fd, SSP_IOCTL_INIT);
    close(fd);
}

void hwvault_ssp_exit() {
    int fd = open(SSP_DEVICE, O_RDONLY);
    ioctl(fd, SSP_IOCTL_EXIT);
    close(fd);
}
