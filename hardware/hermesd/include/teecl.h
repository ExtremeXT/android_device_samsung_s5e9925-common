/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

struct shared_mem {
    int* ptr;
    size_t size;
    int mode;
    char reserved[5];
};

struct message {
    long type;
    struct shared_mem* in;
    char reserved[16];
    struct shared_mem* out;
};

void TEEC_CloseSession(void**);
void TEEC_FinalizeContext(void**);
void TEEC_InitializeContext(void*, void**);
void TEEC_InvokeCommand(void**, int, struct message*, int*);
void TEEC_RegisterSharedMemory(void**, struct shared_mem*);
void TEEC_ReleaseSharedMemory(struct shared_mem*);
void TEECS_OpenSession(void**, void**, char[], void*, size_t, int, void*, void*, int*);
