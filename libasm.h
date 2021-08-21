/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jungwkim <jungwkim@student.42seoul.kr>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/08/19 15:23:18 by jungwkim          #+#    #+#             */
/*   Updated: 2021/08/21 11:51:41 by jungwkim         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>

ssize_t	ft_write(int fd, const void *buf, size_t len);
ssize_t	ft_read(int fd, const void *buf, size_t len);

int		ft_strcmp(const char *s1, const char *s2);
char	*ft_strcpy(char *d, const char *s);
size_t	ft_strlen(const char *s);
char	*ft_strdup(const char *str);

#endif
