NAME	=	libasm.a
CC		=	nasm
CFLAGS	=	-f macho64

SRCS	=	ft_write.s \
			ft_read.s \
			ft_strlen.s \
			ft_strcpy.s \
			ft_strcmp.s \
			ft_strdup.s 

OBJS	=	$(SRCS:.c=.o)

%.o		:	%.s
		$(CC) $(CFLAGS) -c $< -o $@

all		:	$(NAME)

$(NAME)	:	$(OBJS)
		ar rcs $@ $^

clean	:
			rm -rf $(OBJS)

fclean	:	clean
			rm -rf $(NAME)

re		:	clean all

.PHONY	:	re fclean clean all
