# @********************************************************************************************************
# @                                                uC/CPU
# @                                    CPU CONFIGURATION & PORT LAYER
# @
# @                         (c) Copyright 2004-2018; Silicon Laboratories Inc.,
# @                                400 W. Cesar Chavez, Austin, TX 78701
# @
# @                   All rights reserved. Protected by international copyright laws.
# @
# @                  Your use of this software is subject to your acceptance of the terms
# @                  of a Silicon Labs Micrium software license, which can be obtained by
# @                  contacting info@micrium.com. If you do not agree to the terms of this
# @                  license, you may not use this software.
# @
# @                  Please help us continue to provide the Embedded community with the finest
# @                  software available. Your honesty is greatly appreciated.
# @
# @                    You can find our product's documentation at: doc.micrium.com
# @
# @                          For more information visit us at: www.micrium.com
# @********************************************************************************************************

# @********************************************************************************************************
# @
# @                                            CPU PORT FILE
# @
# @                                               ARC
# @                                            MetaWare
# @
# @ Filename : cpu_a.s
# @ Version  : V1.31.04
# @********************************************************************************************************
# @ Note(s)  : This port supports the ARC cores
# @********************************************************************************************************


# @********************************************************************************************************
# @                                      CODE GENERATION DIRECTIVES
# @********************************************************************************************************

.file "cpu_a.s"
.text
.align 4


# @********************************************************************************************************
# @                                           PUBLIC FUNCTIONS
# @********************************************************************************************************


        .global  CPU_CntLeadZeros
        .global  CPU_CntTrailZeros


# @********************************************************************************************************
# @                                         CPU_CntLeadZeros()
# @                                        COUNT LEADING ZEROS
# @
# @ Description : Counts the number of contiguous, most-significant, leading zero bits before the
# @                   first binary one bit in a data value.
# @
# @ Prototype   : CPU_DATA  CPU_CntLeadZeros(CPU_DATA  val);
# @
# @ Argument(s) : val         Data value to count leading zero bits.
# @
# @ Return(s)   : Number of contiguous, most-significant, leading zero bits in 'val'.
# @
# @ Note(s)     : (1) (a) Supports 32-bit data value size as configured by 'CPU_DATA' (see 'cpu.h
# @                       CPU WORD CONFIGURATION  Note #1').
# @
# @                   (b) For 32-bit values :
# @
# @                             b31  b30  b29  ...  b04  b03  b02  b01  b00    # Leading Zeros
# @                             ---  ---  ---       ---  ---  ---  ---  ---    ---------------
# @                              1    x    x         x    x    x    x    x            0
# @                              0    1    x         x    x    x    x    x            1
# @                              0    0    1         x    x    x    x    x            2
# @                              :    :    :         :    :    :    :    :            :
# @                              :    :    :         :    :    :    :    :            :
# @                              0    0    0         1    x    x    x    x           27
# @                              0    0    0         0    1    x    x    x           28
# @                              0    0    0         0    0    1    x    x           29
# @                              0    0    0         0    0    0    1    x           30
# @                              0    0    0         0    0    0    0    1           31
# @                              0    0    0         0    0    0    0    0           32
# @
# @
# @               (2) MUST be defined in 'cpu_a.asm' (or 'cpu_c.c') if CPU_CFG_LEAD_ZEROS_ASM_PRESENT is
# @                   #define'd in 'cpu_cfg.h' or 'cpu.h'.
# @********************************************************************************************************

CPU_CntLeadZeros:
    MOV    %r1, 31
    FLS.F  %r0, %r0
    MOV.Z  %r0, -1
    SUB    %r0, %r1, %r0
    J_S    [%blink]

# @********************************************************************************************************
# @                                         CPU_CntTrailZeros()
# @                                        COUNT TRAILING ZEROS
# @
# @ Description : Counts the number of contiguous, least-significant, trailing zero bits before the
# @                   first binary one bit in a data value.
# @
# @ Prototype   : CPU_DATA  CPU_CntTrailZeros(CPU_DATA  val);
# @
# @ Argument(s) : val         Data value to count trailing zero bits.
# @
# @ Return(s)   : Number of contiguous, least-significant, trailing zero bits in 'val'.
# @
# @ Note(s)     : (1) (a) Supports 32-bit data value size as configured by 'CPU_DATA' (see 'cpu.h
# @                       CPU WORD CONFIGURATION  Note #1').
# @
# @                   (b) For 32-bit values :
# @
# @                             b31  b30  b29  b28  b27  ...  b02  b01  b00    # Trailing Zeros
# @                             ---  ---  ---  ---  ---       ---  ---  ---    ----------------
# @                              x    x    x    x    x         x    x    1            0
# @                              x    x    x    x    x         x    1    0            1
# @                              x    x    x    x    x         1    0    0            2
# @                              :    :    :    :    :         :    :    :            :
# @                              :    :    :    :    :         :    :    :            :
# @                              x    x    x    x    1         0    0    0           27
# @                              x    x    x    1    0         0    0    0           28
# @                              x    x    1    0    0         0    0    0           29
# @                              x    1    0    0    0         0    0    0           30
# @                              1    0    0    0    0         0    0    0           31
# @                              0    0    0    0    0         0    0    0           32
# @
# @
# @               (2) MUST be defined in 'cpu_a.asm' (or 'cpu_c.c') if CPU_CFG_TRAIL_ZEROS_ASM_PRESENT is
# @                   #define'd in 'cpu_cfg.h' or 'cpu.h'.
# @********************************************************************************************************


CPU_CntTrailZeros:
    FFS.F  %r0, %r0
    MOV.Z  %r0, 32
    J_S  [%blink]


# @********************************************************************************************************
# @                                     CPU ASSEMBLY PORT FILE END
# @********************************************************************************************************


