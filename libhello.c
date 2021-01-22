#include <stdio.h>
#include <unistd.h>

void __attribute__ ((constructor)) init()
{
    fprintf(stderr, "\nHello World! I've been injected into pid %u\n", getpid());
}

