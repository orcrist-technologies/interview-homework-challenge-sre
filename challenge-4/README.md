## Challenge 4: What's wrong?

## setup

build and run the container

```bash
docker build --platform linux/amd64 -t challenge-4 .
docker run --platform linux/amd64 challenge-4
```

## Problem

Running the binary returns an unexpected output:

```bash
root@8484ec17fc42:/app# ./blackbox ; echo
Ooooh, what's wrong? :(
```

## Investigation

Using `strings` to extract readable content from the binary reveals that it calls `access` to check if `the_magic_filez.txt` exists. Depending on the result, it prints one of two messages:

```bash
root@8484ec17fc42:/app# strings blackbox | grep -B 10 -A 10 "Ooooh, what's wrong?"
access
__libc_start_main
GLIBC_2.2.5
_ITM_deregisterTMCloneTable
__gmon_start__
_ITM_registerTMCloneTable
u+UH
[]A\A]A^A_
the_magic_filez.txt
Congrats! :)
Ooooh, what's wrong? :(
:*3$"
GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
crtstuff.c
deregister_tm_clones
__do_global_dtors_aux
completed.8060
__do_global_dtors_aux_fini_array_entry
frame_dummy
__frame_dummy_init_array_entry
main.c
```

The binary logic is:
- if `the_magic_filez.txt` exists → `Congrats! :)`
- if `the_magic_filez.txt` is missing → `Ooooh, what's wrong? :(`

## Fix

The binary is correct, the environment is missing `the_magic_filez.txt` file

```bash
root@8484ec17fc42:/app# touch the_magic_filez.txt
root@8484ec17fc42:/app# ls
# Dockerfile  blackbox  the_magic_filez.txt
```

```bash
root@8484ec17fc42:/app# ./blackbox ; echo
# Congrats! :)
```