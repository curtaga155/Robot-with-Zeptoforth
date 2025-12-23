\ MotorLeftBackward 

compile-to-flash

pwm import
15 constant MotorLeftBackward
7 constant MotorLeftBackward-slice
: init-MotorLeftBackward
MotorLeftBackward-slice bit disable-pwm
MotorLeftBackward-slice
MotorLeftBackward pwm-pin 
MotorLeftBackward-slice free-running-pwm  

false MotorLeftBackward-slice pwm-phase-correct! 
0 25 MotorLeftBackward-slice pwm-clock-div! 
125 MotorLeftBackward-slice pwm-top!  
125 MotorLeftBackward-slice pwm-counter-compare-b!  
0 MotorLeftBackward-slice pwm-counter!  
;

: start-MotorLeftBackward { compare -- }
MotorLeftBackward-slice bit disable-pwm
compare MotorLeftBackward-slice pwm-counter-compare-b!
0 MotorLeftBackward-slice pwm-counter!
MotorLeftBackward-slice bit enable-pwm
; 

: MotorLeftBackward { compare -- }
compare MotorLeftBackward-slice pwm-counter-compare-b!
;
init-MotorLeftBackward start-MotorLeftBackward

\0 MotorLeftBackward
\ 60 MotorLeftBackward


