# The compiler: gcc for C program, define as g++ for C++
NAME := prime.out
CPP := g++
CC = gcc

OBJDUMP := objdump
OBJ_DIR := obj
GIT_VERSION := $(shell git describe --abbrev=4 --dirty --always --tags)
PRODUCT := "BC-linux-shell"

# Put in our include file locations
INCLUDES= \
	"-I./"== \

# Our c file sources
C_SOURCES= 			\
	prime.c 	\

# Our c++ files
CPP_SOURCES= \

# Flags not enabled by Wall
COMMON_FLAGS := -Wno-write-strings -O0 -Wall -Wextra -g \
		-Wno-missing-field-initalizers -fPIC \
		-DGIT_VERSION=\"$(GIT_VERSION)\" -DDEV_NAME=\"$(PRODUCT)\" \

CFLAGS := -std=gnu11 $(COMMON_FLAGS) $(INCLUDES)
CPPFLAGS := -std=gnu++11 -fno-rtti -fno-exceptions $(COMMON_FLAGS) $(INCLUDES)

all: ${OBJ_DIR} ${NAME}

# No idea how this works, should probably RTFM
vpath %.c $(sort $(dir $(C_SOURCES)))
vpath %.cpp $(sort $(dir $(CPP_SOURCES)))

# Create Object File Lists
CPP_OBJS := $(addprefix ${OBJ_DIR}/,$(notdir $(CPP_SOURCES:%.cpp=%.o)))
C_OBJS := $(addprefix ${OBJ_DIR}/,$(notdir $(C_SOURCES:%.c=%.o)))

# Create our object DIRECTORY
${OBJ_DIR}:
	mkdir ${OBJ_DIR}

# Pull in dependency info for **existing** .o files
-include $(C_OBJS:.o=.d)
-include $(CPP_OBJS:.o=.d)

# NOTE
# $@ is the file being generated (Could be a phony target)
# $< is the first prerequisite(usually source file)
# $^ is all the source files

# Get our Local C files
${OBJ_DIR}/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MMD -MP -o $@ -c $<

# Get our Local C files
${OBJ_DIR}/%.o: %.c
	mkdir -p $(dir $@)
	$(CPP) $(CPPFLAGS) -MMD -MP -o $@ -c $<

# Our executable
${NAME}: $(C_OBJS) $(CPP_OBJS)
	$(CC) $(CFLAGS) $(CPP_OBJS) $(C_OBJS) -o $@

# Our executable
${NAME}.tst: $(C_OBJS) $(CPP_OBJS)
	$(CC) $(CFLAGS) $(CPP_OBJS) $(C_OBJS) -o $@

# Our executable
${NAME}.lst: ${NAME}
	${OBJDUMP} -dSt $^ >$@

clean:
	@rm -rf ${NAME} ${NAME}.lst ${OBJ_DIR}
