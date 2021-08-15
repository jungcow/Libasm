#include <stdio.h>

int sum(int a, int b)
{
	return a + b;
}


int main(void)
{
	int c;
	
	c = sum(1, 2);
	printf("%d\n", c);
	return (c);
}
