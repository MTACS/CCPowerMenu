#import <Foundation/Foundation.h>
#import "spawn.h"
#include <unistd.h>
#include <stdio.h>
#include <rootless.h>
#include <sys/types.h>

int main(int argc, char *argv[], char *envp[]) {
	setuid(0);
	setgid(0);

	if (getuid() != 0) {
		exit(1);
	}

	pid_t pid;
    const char* args[] = {"launchctl", "reboot", "userspace", NULL};
    posix_spawn(&pid, ROOT_PATH("/usr/bin/launchctl"), NULL, NULL, (char* const*)args, NULL);	
	exit(0);
}
