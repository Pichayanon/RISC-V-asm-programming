.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9 ,10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, a # loading address of a and put to a0
    la a1, b # loading address of b and put to a1
    addi a2, x0, 5 # set size of array into a2
    addi s1, x0, 0 # set result of dot_product_recursive = 0
    jal dot_product_recursive
    
    mv s1, a0        # move result of dot_product_recursive function to t3
 
    # print a text character; use print_string
    addi a0, x0, 4
    la a1, text
    ecall
    
    # print_int; sop
    addi a0, x0, 1
    add a1, x0, s1
    ecall
   
    # print a newline character; use print_string
    addi a0, x0, 4
    la a1, newline
    ecall
   
    # exit  cleanly
    addi a0, x0, 10
    ecall

dot_product_recursive:
    # base case
    # check if size of array equal to 1 go to exit_base_case
    addi t0, x0, 1          
    beq a2, t0, exit_base_case 
    
    # recursive case 
    # save ra on the stack
    addi sp, sp, -4             
    sw ra, 0(sp)    
    
    # save a0 and a1 on the stack
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)
    
    # dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4  # add 4 to address of a
    addi a1, a1, 4  # add 4 to address of b
    addi a2, a2, -1 # sub size of array with 1
    jal dot_product_recursive
    mv t1, a0 # move result of dot_product_recursive(a+1, b+1, size-1) to t1
    
    # restoring a0, a1 their origin value
    lw a0, 0(sp)
    lw a1, 4(sp)
    addi sp, sp, 8
    
    lw a3, 0(a0) # load value of a0
    lw a4, 0(a1) # load value of a1
    mul t2, a3, a4  # t2 = a[0]*b[0]
    add a0, t2, t1  # a0 = a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)

    # restoring ra their origin value
    lw ra, 0(sp)
    addi sp, sp, 4
    
    jr ra   
    
exit_base_case:
    lw a3, 0(a0)   # load value of a0
    lw a4, 0(a1)   # load value of a1
    mul a0, a3, a4 # a0 = a[0]*b[0]
    jr ra
    
    
    
    
    