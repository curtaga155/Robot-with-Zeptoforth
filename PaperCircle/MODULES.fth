\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%% ZEPTOROBOT MODULES %%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ Motors
compile-to-flash
begin-module Motors_Robot
pwm import

\ MotorLeftForward.fth
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
init-MotorLeftForward 
start-MotorLeftForward

\ MotorLeftBackward 
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
init-MotorLeftBackward 
start-MotorLeftBackward

\ MotorRightForward 
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
init-MotorRightForward  
start-MotorRightForward

\ MotorRightBackward
12 constant MotorRightBackward \ pin 16
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
init-MotorRightBackward 
start-MotorRightBackward
end-module


\ applications motors
compile-to-flash
cornerstone -ici \ I'm using French  markers to avoid interfering with the English words
begin-module All_motors
Motors_Robot import
pin import
: initAllMotors
init-MotorRightBackward start-MotorRightBackward
init-MotorRightForward start-MotorRightForward
init-MotorLeftBackward start-MotorLeftBackward
init-MotorLeftForward start-MotorLeftForward
;
: enableRight  9 output-pin high 9 pin!  ;  
: disableRight 9 output-pin low 9 pin! ;  
: enableLeft 3 output-pin  high 3 pin! ;  
: disableLeft 3 output-pin  low 3 pin! ;  
: enableAll   enableRight enableLeft ;
: disableAll disableRight disableLeft ;
: InitAll enableAll initAllmotors ;
: Forward  100 MotorRightForward  100 MotorLeftForward ;
: Backward 100 MotorRightBackward 100 MotorLeftBackward ;
: StopForward 0 MotorRightForward  0 MotorLeftForward ;
: StopBackward 0  MotorRightBackward  0 MotorLeftBackward ;
: stop_motors StopForward StopBackward ; 

\ test_motors
: test_motors  Forward 1000 ms stop_motors 500 ms Backward 1000 ms stop_motors ;
: start_test_motors  initAll test_motors stop_motors ;

end-module 

compile-to-flash  
\ cornerstone -autres  
 
