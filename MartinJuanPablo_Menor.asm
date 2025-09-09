# ================== MartinJuanPablo_Menor.asm ==================
# Programa: Lee N numeros (3..5) y muestra el menor.
# Syscalls: 4 print_string, 1 print_int, 5 read_int, 10 exit

.data
msgN:        .asciiz "Ingrese la cantidad de numeros a comparar (3 a 5): "
msgNum:      .asciiz "Ingrese un numero: "
msgErrorN:   .asciiz "Valor invalido. Debe ser entre 3 y 5.\n"
msgRes:      .asciiz "El menor es: "
newline:     .asciiz "\n"

.text
.globl main
main:
# --- Pedir N (3..5) ---
pideN:
    la   $a0, msgN
    li   $v0, 4
    syscall

    li   $v0, 5          # read_int
    syscall
    move $t0, $v0        # t0 = N

    blt  $t0, 3, errN
    bgt  $t0, 5, errN
    b    primer

errN:
    la   $a0, msgErrorN
    li   $v0, 4
    syscall
    b    pideN

# --- Leer primer numero = menor inicial ---
primer:
    la   $a0, msgNum
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t1, $v0        # t1 = menor

    li   $t2, 1          # i = 1 (ya leimos 1)

# --- Leer restantes y actualizar menor ---
loop:
    beq  $t2, $t0, fin   # si i == N -> terminar

    la   $a0, msgNum
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t3, $v0        # t3 = numero leido

    # if (t3 < t1) t1 = t3
    bge  $t3, $t1, noChange
    move $t1, $t3
noChange:
    addi $t2, $t2, 1
    b    loop

# --- Mostrar resultado ---
fin:
    la   $a0, msgRes
    li   $v0, 4
    syscall

    move $a0, $t1        # imprimir menor
    li   $v0, 1
    syscall

    la   $a0, newline
    li   $v0, 4
    syscall

    li   $v0, 10         # exit
    syscall
