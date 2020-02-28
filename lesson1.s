#adding & values in registers
  add $t0, $s1, $s2
  add $t1, $s3, $s4
  sub $s0, $t0, $t1

#Loading words(32-bit data)
   lw $t0, 32($s3)

#storing words
   sw $t0, 48(#s3)

  #adding register with a constant
    addi $s3, $s3, 4
    #* special case:
      # Can't subi therefore:
         addi $s2, $s1, -1
  #$zero register
    #contant value of 0 and can't be overwritten
    #Helpful for moving values between registers:
       add $t1, $s1, $zero

  #Masking bits in a word
    and $t0, $t1, $t2

  #Including bits in a word
    or $t0, $t1, $t2

  #Inverting bits in a word
    nor $t0, $t1, $zero

  #Branch to labeled instruction if condition is true
    beq $t0, $t1, L1

  #Branch to labeled instruction if NOT condition is true
    bne $t0, $t1, L1

  #Unconditional jump to the instruction labeled l1
    j L1

  # Simple if-else statment
    bne $s3, $s4, Else
    add $s0, $s1, $s2
    j Exit
  Else: sub $s0, $s1, $s2
  Exit: #comething else

  #Simple loop
    Loop: sll $t1, $s3, 2 #shifts left and adds zero 2^2 times = 4 shift left w/ 0's
          add $t1, $t1, $s6 #add the adress to $t1 therefore its gonna look in memory like: |value of i|address|
          lw $t0, 0($t1) #grab the first slot of the register which is the value of i and put it into t0
          bne $t0, $s5, Exit #if the value of i != k then go to Branch Exit
          addi $s3, $s3, 1 #else increment i by one
          j Loop  #restart the loop
