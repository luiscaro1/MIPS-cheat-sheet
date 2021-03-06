#adding & values in registers
  add $t0, $s1, $s2
  add $t1, $s3, $s4
  sub $s0, $t0, $t1

#Loading words(32-bit data)
   lw $t0, 32($s3)

#storing words
   sw $t0, 48($s3) #save $t0 into the offset 48 of register $s3

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

           $t0, 0($t1) #grab the first slot of the register which is the value of i and put it into t0
          bne $t0, $s5, Exit #if the value of i != k then go to Branch Exit
          addi $s3, $s3, 1 #else increment i by one
          j Loop  #restart the loop
      Exit: #Do nothing

    #More conditionals
      slt rd, rs, rt # if( rs < rt ) rd = 1, else rt = 0
      slti rt, rs, constant # if( rs < constant) rt=1, else rt =

    #Combination with beq
      slt $t0, $s1, $s2 #if( $s1 < $s2) $t0 = 1, else $t0 = 0
      bne $t0, $zero, L # go to branch L

      #Signed comparisons
        slt, slti

      #Unsigned Comparisons
        sltu, sltui

      #Register Usage
        #Arguments
          $a0 - $a3 #reg's 4-7

        #Result Values
          $v0, $v1 #reg's 2 & 3

        #Temporaries (Can be overwritten)
          $t0 - $t9

        #Saved
          $s0 - $s7 #Must be saved and restored by callee

        #Global pointer
          $gp #static data reg28

        #Stack pointer
          $sp #reg29

        #Frame pointer
          $fp #reg30

        #Return Address
          $ra #reg31

        #Procedure Call: Jump and Link
          jal ProcedureLabel #jumps to a label and store address in $ra

        #Procedure Return: Jump register
          jr $ra #returns to an address in a register (return)

        #Byte/Halfword Operations
          lb rt, offset(rs) #Load Byte & extends the reamaining bits from the offset to 0

          lbu, rt offset(rs) #Load Byte & extends the reamaining bits from the offset to the extended sign

          lh rt, offset(rs) #Load Halfword & extends the reamaining bits from the offset to 0

          lhu rt, offset(rs) #Load Halfword & extends the reamaining bits from the offset to the extended sign

          sb rt, offset(rs) #store rightmost byte

          sh rt, offset(rs) #store rightmost word

          lui rt, constant #Copies 16-bit constant to left 16 of rt & clears right 16 bits of rt to 0

          ori $s0, $s0, 2304 #adds 2304 into register $s0
          #Load Link
          ll rt, offset(rs) #Loads a word from memory for an atomic-read modify-write
          #Load Conditional
          sc rt, offset(rs) #returns 1 if the locaation has not changed since the ll else return 0

          #Synchronization

            try: add $t0, $zero, $s4 #copy the contents of $s4 to $t0
                  ll $t1, 0($s1) # Load linked
                  sc $t0, 0($s1) #checks if the ll succeeded
                  beq $t0, $zero, try #if branch equals to zero try again
                  add $s4, $zero, $t1 #put the load value in $t1

          # Bubble sort
          swap: sll $t1, $a1, 2   # $t1 = k*4
                add $t1, $a0, $t1 # $t1 = v + (k*4) -->  #| k value | V value| <-- in memory
                lw $t0, 0($t1) # $t0 (temp) = v[k]
