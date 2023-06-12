# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aurue-lo <aurue-lo@student.42barcel>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/12 11:27:45 by aurue-lo          #+#    #+#              #
#    Updated: 2023/06/12 12:38:56 by aurue-lo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#								#Variables#                                    #
################################################################################
NAME = minitalk
N_SERVER = server
N_CLIENT = client
CC = gcc
CFLAGS = -Wall -Wextra -Werror
RM = rm -rf

################################################################################
#								#Sources#									   #
################################################################################
SRC_CLIENT = client.c
SRC_SERVER = server.c
LIBFT = ./libft/
SRC_PATH = ./src
LIBFT_PATH = ./libft/libft.a
INC = -I ./inc/\
	  -I ./libft/\

################################################################################
#								#Directories#                                  #
################################################################################
D_OBJ = $(SRC_PATH)/obj
OBJ_SERVER = $(addprefix $(D_OBJ)/, $(SRC_SERVER:.c=.o))
OBJ_CLIENT = $(addprefix $(D_OBJ)/, $(SRC_CLIENT:.c=.o))

DEP_SERVER = $(addprefix $(D_OBJ)/, $(SRC_SERVER:.c=.d))
DEP_CLIENT = $(addprefix $(D_OBJ)/, $(SRC_CLIENT:.c=.d))

################################################################################
#								#Colors and  fonts#                            #
################################################################################
E = \033[m
R = \033[31m
G = \033[32m
Y = \033[33m
B = \033[34m
P = \033[35m
C = \033[36m
ligth = \033[1m
dark = \033[2m
italic = \033[3m

################################################################################
#								#Make rules#                                   #
################################################################################
all: comp $(NAME)
-include $(DEP_SERVER)
-include $(DEP_CLIENT)
comp:
	make -C $(LIBFT) # -C flag para compilar makefiles externos
	-mkdir $(D_OBJ)
$(D_OBJ)/%.o:$(SRC_PATH)/%.c
	$(CC) -MMD $(CFLAGS) -c $< -o $@ $(INC) #-MMD flag para compilar con dep
	printf "$C$(ligth)Compiling minitalk\n$E"
$(N_SERVER): $(OBJ_SERVER)
	$(CC) $(CFLAGS) $(OBJ_SERVER) $(LIBFT_PATH) -o $(N_SERVER) $(INC)
$(N_CLIENT): $(OBJ_CLIENT)
	$(CC) $(FLAGS) $(OBJ_CLIENT) $(LIBFT_PATH) -o $(N_CLIENT) $(INC)
#$(MAKE) es una variable de makefile y sirve para hacer make de una regla
$(NAME): $(OBJ_SERVER) $(OBJ_CLIENT)
	$(MAKE) $(N_SERVER)
	$(MAKE) $(N_CLIENT)
	touch $(NAME)
	printf "$(B)$(ligth)Projecct minitalk compiled!$(E)"
.PHONY: all clean fclean re
fclean: clean
	$(RM) $(NAME) $(N_SERVER) $(N_CLIENT)
	make fclean -C $(LIBFT)
	printf "$(B)$(ligth)minitalk executable files and name cleaned!\n$(E)"
clean:
	$(RM) $(D_OBJ)
	make clean -C $(LIBFT)
	printf "$(B)$(ligth) minitalk object files cleaned!\n$(E)"
re: fclean all
.SILENT:
