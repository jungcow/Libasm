.PHONY	:	re fclean clean all
NAME	=	libasm.a
AS		=	nasm
CC		=	gcc
AR		=	ar
ASFLAGS	=	-f macho64
CFLAGS	=	-Werror -Wall -Wextra
ARFLAGS	=	rcs

LIBS	=	-L. -lasm

SRCS	=	ft_write.s \
			ft_read.s \
			ft_strlen.s \
			ft_strcpy.s \
			ft_strcmp.s \
			ft_strdup.s 

OBJS	=	$(SRCS:.s=.o)

%.o		:	%.s
		$(AS) $(ASFLAGS) $<

all		:	$(NAME)

$(NAME)	:	$(OBJS)
		$(AR) $(ARFLAGS) $@ $^

clean	:
			rm -rf $(OBJS)

fclean	:	clean
			rm -rf $(NAME)
			rm -rf a.out
			rm -rf *.dSYM

re		:	fclean all

test	:	all
	$(CC) $(LIBS) $(CFLAGS) main.c

