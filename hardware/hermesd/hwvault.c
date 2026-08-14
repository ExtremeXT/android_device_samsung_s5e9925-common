/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <fcntl.h>
#include <shctrl.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <teecl.h>
#include <unistd.h>

#define HV_TZ_CMD_GET_CRED 0x271f
#define HWVAULT_CRED_SLOT 11
#define TRUSTLET_PATH "/vendor/tee/00000000-0000-0000-0000-487641557457"
#define TRUSTLET_ID "\0\0\0\0\0\0\0\0\0\0HvAUtW"

void *context, *session;

int payload[] = {HV_TZ_CMD_GET_CRED, 8, 0x1000005, HWVAULT_CRED_SLOT};

struct shared_mem in = {.ptr = payload, .size = 16, .mode = 1};

struct shared_mem out = {.size = 124, .mode = 2};

struct message msg = {.type = 0xcc00000000, .in = &in, .out = &out};

void nwd_tz_open() {
    int fd;
    size_t size;
    struct stat st;
    void* data;

    TEEC_InitializeContext(NULL, &context);

    fd = open(TRUSTLET_PATH, O_RDONLY);
    fstat(fd, &st);
    size = st.st_size;
    data = malloc(size);
    read(fd, data, size);
    close(fd);

    TEECS_OpenSession(&context, &session, TRUSTLET_ID, data, size, 0, NULL, NULL, NULL);
    free(data);
}

void nwd_tz_close() {
    TEEC_CloseSession(&session);
    TEEC_FinalizeContext(&context);
}

void hwvault_get_cred() {
    out.ptr = malloc(out.size);
    TEEC_RegisterSharedMemory(&context, &out);
    TEEC_RegisterSharedMemory(&context, &in);

    hwvault_ssp_init();
    TEEC_InvokeCommand(&session, 0, &msg, NULL);
    hwvault_ssp_exit();

    TEEC_ReleaseSharedMemory(&in);
    TEEC_ReleaseSharedMemory(&out);
    free(out.ptr);
}
