\ MotorRightBackward

compile-to-flash

pwm import
12 constant MotorRightBackward 
6 constant MotorRightBackward-slice
: init-MotorRightBackward
MotorRightBackward-slice bit disable-pwm
MotorRightBackward-slice
MotorRightBackward pwm-pin  
MotorRightBackward-slice free-running-pwm 
 
false MotorRightBackward-slice pwm-phase-correct! 
0 25 MotorRightBackward-slice pwm-clock-div! 
125 MotorRightBackward-slice pwm-top!  
125 MotorRightBackward-slice pwm-counter-compare-a!  
0 MotorRightBackward-slice pwm-counter!  
;

: start-MotorRightBackward { compare -- }
 MotorRightBackward-slice bit disable-pwm
compare  MotorRightBackward-slice pwm-counter-compare-a!
0  MotorRightBackward-slice pwm-counter!
 MotorRightBackward-slice bit enable-pwm
;
 
:  MotorRightBackward { compare -- }
compare  MotorRightBackward-slice pwm-counter-compare-a!
;
init-MotorRightBackward start-MotorRightBackward

\ 60  MotorRightBackward
\ 0  MotorRightBackward
