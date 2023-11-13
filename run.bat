nasm -f elf add.asm
gcc -c main.c
gcc -o program main.o add.o
.\program.exe