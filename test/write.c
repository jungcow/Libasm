#include <unistd.h>
#include <stdio.h>
#include <errno.h>

extern	int	errno;

int main(void)
{
	int	c;

	c = write(-1, "helloworld", 10);
	printf("%d\n", errno);
	printf("%d\n", c);
	return (c);
}
