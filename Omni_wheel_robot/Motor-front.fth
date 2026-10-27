compile-to-flash
begin-module Motors_Robot-front
pwm import

\ MotorLeftForward-front.fth
8 constant MotorLeftForward-front
4 constant MotorLeftForward-front-slice
: init-MotorLeftForward-front
MotorLeftForward-front-slice bit disable-pwm
MotorLeftForward-front-slice
MotorLeftForward-front pwm-pin 

MotorLeftForward-front-slice free-running-pwm  
false MotorLeftForward-front-slice pwm-phase-correct! 
0 25 MotorLeftForward-front-slice pwm-clock-div! 
125 MotorLeftForward-front-slice pwm-top!  
125 MotorLeftForward-front-slice pwm-counter-compare-a!  
0 MotorLeftForward-front-slice pwm-counter!  
;

: start-MotorLeftForward-front { compare -- }
MotorLeftForward-front-slice bit disable-pwm
compare MotorLeftForward-front-slice pwm-counter-compare-a!
0 MotorLeftForward-front-slice pwm-counter!
MotorLeftForward-front-slice bit enable-pwm
;

: MotorLeftForward-front { compare -- }
compare MotorLeftForward-front-slice pwm-counter-compare-a!
;
init-MotorLeftForward-front 
start-MotorLeftForward-front

\ MotorLeftBackward-front 
15 constant MotorLeftBackward-front
7 constant MotorLeftBackward-front-slice
: init-MotorLeftBackward-front
MotorLeftBackward-front-slice bit disable-pwm
MotorLeftBackward-front-slice
MotorLeftBackward-front pwm-pin 

MotorLeftBackward-front-slice free-running-pwm  
false MotorLeftBackward-front-slice pwm-phase-correct! 
0 25 MotorLeftBackward-front-slice pwm-clock-div! 
125 MotorLeftBackward-front-slice pwm-top!  
125 MotorLeftBackward-front-slice pwm-counter-compare-b!  
0 MotorLeftBackward-front-slice pwm-counter!  
;

: start-MotorLeftBackward-front { compare -- }
MotorLeftBackward-front-slice bit disable-pwm
compare MotorLeftBackward-front-slice pwm-counter-compare-b!
0 MotorLeftBackward-front-slice pwm-counter!
MotorLeftBackward-front-slice bit enable-pwm
; 


: MotorLeftBackward-front { compare -- }
compare MotorLeftBackward-front-slice pwm-counter-compare-b!
;
init-MotorLeftBackward-front 
start-MotorLeftBackward-front


\ MotorRightForward-front 
7 constant MotorRightForward-front \ gpio7 pin10 led verte
3 constant MotorRightForward-front-slice
: init-MotorRightForward-front
MotorRightForward-front-slice bit disable-pwm
MotorRightForward-front-slice
MotorRightForward-front pwm-pin


MotorRightForward-front-slice free-running-pwm 
false MotorRightForward-front-slice pwm-phase-correct! 
0 25 MotorRightForward-front-slice pwm-clock-div! 
125 MotorRightForward-front-slice pwm-top!  
125 MotorRightForward-front-slice pwm-counter-compare-b!  
0 MotorRightForward-front-slice pwm-counter!  
;


: start-MotorRightForward-front { compare -- }
MotorRightForward-front-slice bit disable-pwm
compare MotorRightForward-front-slice pwm-counter-compare-b!
0 MotorRightForward-front-slice pwm-counter!
MotorRightForward-front-slice bit enable-pwm
; 


: MotorRightForward-front { compare -- }
compare MotorRightForward-front-slice pwm-counter-compare-b!
;
init-MotorRightForward-front  
start-MotorRightForward-front


\ MotorRightBackward-front
12 constant MotorRightBackward-front \ pin 16
6 constant MotorRightBackward-front-slice
: init-MotorRightBackward-front
MotorRightBackward-front-slice bit disable-pwm
MotorRightBackward-front-slice
MotorRightBackward-front pwm-pin 


MotorRightBackward-front-slice free-running-pwm 
false MotorRightBackward-front-slice pwm-phase-correct! 
0 25 MotorRightBackward-front-slice pwm-clock-div! 
125 MotorRightBackward-front-slice pwm-top!  
125 MotorRightBackward-front-slice pwm-counter-compare-a!  
0 MotorRightBackward-front-slice pwm-counter!  
;


: start-MotorRightBackward-front { compare -- }
 MotorRightBackward-front-slice bit disable-pwm
compare  MotorRightBackward-front-slice pwm-counter-compare-a!
0  MotorRightBackward-front-slice pwm-counter!
 MotorRightBackward-front-slice bit enable-pwm
;


:  MotorRightBackward-front { compare -- }
compare  MotorRightBackward-front-slice pwm-counter-compare-a!
;
init-MotorRightBackward-front 
start-MotorRightBackward-front


\ application All_motors-front
pin import
: initAllMotors-front
init-MotorRightBackward-front start-MotorRightBackward-front
init-MotorRightForward-front start-MotorRightForward-front
init-MotorLeftBackward-front start-MotorLeftBackward-front
init-MotorLeftForward-front start-MotorLeftForward-front
;

: enableRight-front  9 output-pin high 9 pin!  ;  
: disableRight-front 9 output-pin low 9 pin! ;  
: enableLeft-front 3 output-pin  high 3 pin! ;  
: disableLeft-front 3 output-pin  low 3 pin! ;  
: enableAll-front   enableRight-front enableLeft-front ;
: disableAll-front disableRight-front disableLeft-front ;
: InitAll-front enableAll-front initAllmotors-front ;

: Forward-front  100 MotorRightForward-front  100 MotorLeftForward-front ;
: Backward-front 100 MotorRightBackward-front 100 MotorLeftBackward-front ;
: StopForward-front 00 MotorRightForward-front  00 MotorLeftForward-front ;
: StopBackward-front 00  MotorRightBackward-front  00 MotorLeftBackward-front ;
: stop_motors-front StopForward-front StopBackward-front ; 

\ test_motors
: test_motors-front  Forward-front 500 ms stop_motors-front 500 ms Backward-front 500 ms stop_motors-front ;
: start_test_motors-front  initAll-front test_motors-front stop_motors-front ;
: ttt start_test_motors-front ;

end-module 

