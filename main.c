#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include "libasm.h"

void	strdup_test(char *str1, char *str2)
{
	printf("\n=============== FT_STRDUP ================\n\n");
	printf("ft_strdup: %s\n", str1);
	printf("   strdup: %s\n", str2);
}

void	strcpy_test(char *str, char *str2)
{
	char	*cpy1 = "muchmuchmuchmuchlonger";
	char	*cpy2 = "small";

	printf("\n=============== FT_STRCPY ================\n");
	printf("\n[COPY SRC: %s]\n", cpy1);
	printf("ft_strcpy: %s\n", ft_strcpy(str, cpy1));
	printf("   strcpy: %s\n", strcpy(str2, cpy1));
	printf("\n[COPY SRC: %s]\n", cpy2);
	printf("ft_strcpy: %s\n", ft_strcpy(str, cpy2));
	printf("   strcpy: %s\n", strcpy(str, cpy2));
}

void	strcmp_test(char *str)
{
	char	*cmp1 = "helloworld";
	char	*cmp2 = "hellow";
	
	printf("\n=============== FT_STRCMP ================\n");
	printf("ft_strcmp: %d, strcmp: %d\n", ft_strcmp(str, cmp1), strcmp(str, cmp1));
	printf("ft_strcmp: %d, strcmp: %d\n", ft_strcmp(str, cmp2), strcmp(str, cmp2));
	printf("ft_strcmp: %d, strcmp: %d\n", ft_strcmp(cmp2, str), strcmp(cmp2, str));
}

void	strlen_test(char *str)
{
	printf("\n=============== FT_STRLEN ================\n");
	printf("\n[%s]\n", str);
	printf("[ft_strlen]: %zd\n", ft_strlen(str));
	printf("   [strlen]: %zd\n", strlen(str));
	printf("\n[hihi]\n");
	printf("[ft_strlen]: %zd\n", ft_strlen("hihi"));
	printf("   [strlen]: %zd\n", strlen("hihi"));
}

void	write_test(char *str)
{
	int		ret1;
	int		ret2;

	printf("\n=============== WRITE ================\n");
	printf("\n[ft_write]\n");
	ret1 = ft_write(1, str, strlen(str));
	printf("\n\n[write]\n");
	ret2 = write(1, str, strlen(str));
	printf("\n\n[ft_write] RET: %d\n", ret1);
	printf("   [write] RET: %d\n", ret2);
	printf("\n[ERRNO]\n");
	ret1 = ft_write(-1, str, strlen(str));
	printf("[ft_write] ERRNO: %d, RET: %d\n", errno, ret1);
	ret2 = write(-1, str, strlen(str));
	printf("   [write] ERRNO: %d, RET: %d\n", errno, ret2);
}

void	read_test(void)
{
	char	buf[100];
	char	buf2[100];
	int		ret1;
	int		ret2;

	printf("\n=============== READ ================\n");
	printf("\n[ft_read]\n");
	ret1 = ft_read(0, buf, sizeof(buf));
	write(1, buf, ret1);
	printf("\n[read]\n");
	ret2 = read(0, buf2, sizeof(buf2));
	write(1, buf2, ret2);
	printf("\n\n[ft_read] RET: %d\n", ret1);
	printf("   [read] RET: %d\n", ret2);
	printf("\n[ERRNO]: fd = -1\n");
	ret1 = ft_read(-1, buf, sizeof(buf));
	printf("[ft_read] ERRNO: %d, RET: %d\n", errno, ret1);
	ret2 = read(-1, buf2, sizeof(buf2));
	printf("   [read] ERRNO: %d, RET: %d\n", errno, ret2);
	printf("\n[ERRNO]: size = -1\n");
	ret1 = ft_read(0, buf, -1);
	printf("[ft_read] ERRNO: %d, RET: %d\n", errno, ret1);
	ret2 = read(0, buf2, -1);
	printf("   [read] ERRNO: %d, RET: %d\n", errno, ret2);
}


int main(void)
{
	char	*str;
	char	*str2;
	char	buf[100];
	char	buf2[100];

	str = ft_strdup("helloworld");
	if (!str)
	{
		printf("mallo error\n");
		return (1);
	}
	str2 = strdup("helloworld");
	strdup_test(str, str2);
	strcpy_test(buf, buf2);
	strcmp_test(str);
	strlen_test(str);
	write_test(str);
	read_test();
	free(str);
	free(str2);
	return (0);
}
