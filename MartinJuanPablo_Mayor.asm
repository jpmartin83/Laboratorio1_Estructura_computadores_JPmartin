# ================== MartinJuanPablo_Mayor.asm ==================
# Programa: Lee N numeros (3..5) y muestra el mayor.
# Ensamblador: MARS (MIPS)
# Syscalls usados:
#   4 = print_string, 1 = print_int, 5 = read_int, 10 = exit

.data
msgN:        .asciiz "Ingrese la cantidad de numeros a comparar (3 a 5): "
msgNum:      .asciiz "Ingrese un numero: "
msgErrorN:   .asciiz "Valor invalido. Debe ser entre 3 y 5.\n"
msgRes:      .asciiz "El mayor es: "
newline:     .asciiz "\n"

.text
.globl main
main:
    # Solicitar N (entre 3 y 5)
solicitar_N:
    la   $a0, msgN          # Mostrar mensaje
    li   $v0, 4
    syscall

    li   $v0, 5             # Leer entero
    syscall
    move $t0, $v0           # t0 = N

    blt  $t0, 3, n_invalido # si N < 3 -> error
    bgt  $t0, 5, n_invalido # si N > 5 -> error
    b    leer_primero

n_invalido:
    la   $a0, msgErrorN
    li   $v0, 4
    syscall
    b    solicitar_N

# Leer el primer numero y guardarlo como mayor
leer_primero:
    la   $a0, msgNum
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t1, $v0           # t1 = mayor inicial

    li   $t2, 1             # contador i = 1

# Bucle para leer el resto
leer_restantes:
    beq  $t2, $t0, mostrar_resultado

    la   $a0, msgNum
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t3, $v0

    # if (t3 > t1) t1 = t3
    ble  $t3, $t1, no_cambia
    move $t1, $t3
no_cambia:
    addi $t2, $t2, 1
    b    leer_restantes

# Mostrar resultado
mostrar_resultado:
    la   $a0, msgRes
    li   $v0, 4
    syscall

    move $a0, $t1
    li   $v0, 1
    syscall

    la   $a0, newline
    li   $v0, 4
    syscall

    li   $v0, 10            # exit
    syscall
