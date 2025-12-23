\ MotorLeftForward.fth

compile-to-flash

pwm import
8 constant MotorLeftForward
4 constant MotorLeftForward-slice
: init-MotorLeftForward
MotorLeftForward-slice bit disable-pwm
MotorLeftForward-slice
MotorLeftForward pwm-pin  
MotorLeftForward-slice free-running-pwm  

false MotorLeftForward-slice pwm-phase-correct! 
0 25 MotorLeftForward-slice pwm-clock-div! 
125 MotorLeftForward-slice pwm-top!  
125 MotorLeftForward-slice pwm-counter-compare-a!  
0 MotorLeftForward-slice pwm-counter!  
;

: start-MotorLeftForward { compare -- }
MotorLeftForward-slice bit disable-pwm
compare MotorLeftForward-slice pwm-counter-compare-a!
0 MotorLeftForward-slice pwm-counter!
MotorLeftForward-slice bit enable-pwm
;
: MotorLeftForward { compare -- }
compare MotorLeftForward-slice pwm-counter-compare-a!
;
init-MotorLeftForward start-MotorLeftForward


\ 60 MotorLeftForward
\ 0 MotorLeftForward

