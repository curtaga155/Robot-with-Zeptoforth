\ MotorRightForward 

compile-to-flash
pwm import
7 constant MotorRightForward \ gpio7 pin10 led verte
3 constant MotorRightForward-slice
: init-MotorRightForward
MotorRightForward-slice bit disable-pwm
MotorRightForward-slice
MotorRightForward pwm-pin  
MotorRightForward-slice free-running-pwm 
 
false MotorRightForward-slice pwm-phase-correct! 
0 25 MotorRightForward-slice pwm-clock-div! 
125 MotorRightForward-slice pwm-top!  
125 MotorRightForward-slice pwm-counter-compare-b!  
0 MotorRightForward-slice pwm-counter!  
;

: start-MotorRightForward { compare -- }
MotorRightForward-slice bit disable-pwm
compare MotorRightForward-slice pwm-counter-compare-b!
0 MotorRightForward-slice pwm-counter!
MotorRightForward-slice bit enable-pwm
; 

: MotorRightForward { compare -- }
compare MotorRightForward-slice pwm-counter-compare-b!
;
init-MotorRightForward start-MotorRightForward

\ 60 MotorRightForward
\ 0 MotorRightForward


