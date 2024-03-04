.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9 ,10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
    addi x5, x0, 0 # let x5 be i and set it to 0
    addi x6, x0, 0 # let x6 be sop and set it to 0
    addi x7, x0, 5 # let x7 be number of loop and set it to 5
    la x8, a       # loading the address of a to x8
    la x9, b       # loading the address of b to x9
    
    
loop: 
    bge x5, x7, exit  # check if i >= 5 go to exit
    slli x18, x5, 2   # set x18 to i*4
    add x19, x18, x8  # add i*4 to the base address of a and put it to x19
    add x20, x18, x9  # add i*4 to the base address of b and put it to x20
    lw x21, 0(x19)    # x21 has a[i]
    lw x22, 0(x20)    # x22 has b[i]
    mul x23, x21, x22 # mul a[i] and b[i] and put it to x23
    add x6, x6, x23   # sop += a[i]*b[i]
    addi x5, x5, 1    # i++
    j loop
    
exit:
   # print a text character; use print_string
   addi a0, x0, 4
   la a1, text
   ecall
   
   # print_int; sop
   addi a0, x0, 1
   add a1, x0, x6
   ecall
   
   # print a newline character; use print_string
   addi a0, x0, 4
   la a1, newline
   ecall
   
   # exit  cleanly
   addi a0, x0, 10
   ecall
   

   