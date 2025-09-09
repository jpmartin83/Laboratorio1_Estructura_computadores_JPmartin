# ============= MartinJuanPablo_Fibonacci.asm =============
# Pide N (>=1), imprime N terminos de Fibonacci y la suma total.
# Ej.: N=5 -> Serie: 0 1 1 2 3 ; Suma: 7
# Syscalls: 4 print_string, 1 print_int, 5 read_int, 10 exit

.data
msgN:       .asciiz "Ingrese cuantos numeros de Fibonacci desea (entero >= 1): "
msgErr:     .asciiz "Valor invalido. Debe ser >= 1.\n"
msgSerie:   .asciiz "Serie: "
msgSuma:    .asciiz "Suma: "
space:      .asciiz " "
newline:    .asciiz "\n"

.text
.globl main
main:
# --- Leer N >= 1 ---
leerN:
    la   $a0, msgN
    li   $v0, 4
    syscall

    li   $v0, 5          # read_int
    syscall
    move $t0, $v0        # t0 = N

    blez $t0, n_invalido # if N <= 0 -> error
    b    fib_init

n_invalido:
    la   $a0, msgErr
    li   $v0, 4
    syscall
    b    leerN

# --- Inicializar a=0, b=1, suma=0, i=0 ---
fib_init:
    li   $t1, 0          # a
    li   $t2, 1          # b
    li   $t3, 0          # suma
    li   $t4, 0          # i

    la   $a0, msgSerie   # "Serie: "
    li   $v0, 4
    syscall

# --- Bucle de N terminos ---
fib_loop:
    beq  $t4, $t0, imprimir_suma   # si i==N -> fin impresion

    # imprimir a
    move $a0, $t1
    li   $v0, 1
    syscall

    # espacio
    la   $a0, space
    li   $v0, 4
    syscall

    # suma += a
    add  $t3, $t3, $t1

    # siguiente = a + b
    add  $t5, $t1, $t2
    move $t1, $t2        # a = b
    move $t2, $t5        # b = siguiente

    addi $t4, $t4, 1     # i++
    b    fib_loop

# --- Imprimir suma ---
imprimir_suma:
    la   $a0, newline
    li   $v0, 4
    syscall

    la   $a0, msgSuma
    li   $v0, 4
    syscall

    move $a0, $t3
    li   $v0, 1
    syscall

    la   $a0, newline
    li   $v0, 4
    syscall

    li   $v0, 10         # exit
    syscall
