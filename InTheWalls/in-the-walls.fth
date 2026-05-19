\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%% TINY-ZEPTOROBOT %%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ Motors
compile-to-flash
\ cornerstone -premier \ I'm using French  markers to avoid interfering with the English words

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

\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ applications motors
compile-to-flash
\ cornerstone -deuxieme \ I'm using French  markers to avoid interfering with the English words
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
: test_motors  Forward 500 ms stop_motors 500 ms Backward 1000 ms stop_motors ;
: start_test_motors  initAll test_motors stop_motors ;

end-module 

\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

compile-to-flash  
\ cornerstone -troisieme  
compile-to-flash 
begin-module four_sensors 

\ initialization 
Motors_Robot import
All_motors import 
pin import 4 input-pin 5 input-pin 28 input-pin 26 input-pin 
InitAll 

\ initialization straight line
: turnRight 100 MotorLeftForward 1 ms stop_motors  ;  
: turnLeft   90 MotorRightForward 2 ms stop_motors ;  
: LEFT 0 ;  : RIGHT 1 ;  : 1= 1 = ; : BOTH-OFF? AND 0= ;  
: GOSTRAIGHT turnLeft turnRight ;  
: turn ( n-- ) 0= if turnRight else turnLeft then ;  
: LEFTSENSOR 4 pin@  ;  : LEFTSIDESENSOR 28 pin@ ;  
: RIGHTSENSOR 5 pin@ ;  : RIGHTSIDESENSOR 26  pin@ ;

\ command on the straight line
: out-loop LEFTSENSOR RIGHTSENSOR and 0= ; 
: tiny InitAll begin LEFTSENSOR RIGHTSENSOR BOTH-OFF? if GOSTRAIGHT then   LEFTSENSOR turn RIGHTSENSOR turn again ;  

\ initialization of right angle rotation mode
: step-anticlockwise 80 MotorRightBackward 80 MotorLeftForward 100 ms stop_motors ;  
: step-clockwise 80 MotorRightForward 80 MotorLeftBackward 100 ms  stop_motors ;
: few-steps InitAll FORWARD 100 ms stop_motors ; \ A few wheel rotations to center the robot on the line.
: out-loop_clockwise LEFTSENSOR 0=  ;
: out-loop_anticlockwise RIGHTSENSOR 0= ;
: all-turn-clockwise begin step-clockwise  out-loop_clockwise until  ;  
: all-turn-anticlockwise begin step-anticlockwise out-loop_anticlockwise until  ;
: run_tiny-clockwise  few-steps all-turn-clockwise  ;  
: run_tiny-anticlockwise few-steps all-turn-anticlockwise ; 
end-module 

\  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
compile-to-flash  
\ cornerstone -quatrieme 

begin-module Paper_circle
\ In a circle initialization
\ modules import 
\ Install from MODULES.fth
Motors_Robot import  
All_motors import  
four_sensors import
\ pin initialization
pin import 4 input-pin 5 input-pin 28 input-pin 26 input-pin 

InitAll \ motors initialization
 
\ initialization motors 
: turnRight ( -- ) 100 MotorLeftForward 1 ms stop_motors  ;    
: turnLeft ( -- )  100 MotorRightForward 1 ms stop_motors ;    
: LEFT 0 ;  : RIGHT 1 ;  : 1= 1 = ; : BOTH-OFF? AND 0= ;    
: GOSTRAIGHT ( -- ) turnLeft turnRight ;    
: turn ( n-- ) 0= if turnRight else turnLeft then ;    
: CENTERSENSOR ( -- )  4 pin@  ;  
: LEFTSIDESENSOR  ( -- ) 28 pin@ ;  
: RIGHTSIDESENSOR  ( -- ) 26  pin@ ;  

\ Sensor test
: SENSORS_TEST ( -- )  CENTERSENSOR ." CENTERSENSOR=". LEFTSIDESENSOR ." LEFTSIDESENSOR=" . RIGHTSIDESENSOR  ." RIGHTSIDESENSOR=" . ;
\ halfturn
: step-clockwise ( -- )  80 MotorRightForward 80 MotorLeftBackward 100 ms  stop_motors ;
: step-anticlockwise ( -- )  80 MotorRightBackward 80 MotorLeftForward 100 ms stop_motors ;
\ For this route, the half-turns are more like quarter turns.
: halfturn-anticlockwise ( -- )  4 0 do  step-anticlockwise loop ;
: halfturn-clockwise ( -- )  4 0 do  step-clockwise loop ;
\ end-module

\ In the circle
\ compile-to-flash
\ cornerstone -ligne
\ begin-module Robot_circle 

\ Motors_Robot import 
\ All_motors import  
\ Paper_circle import
\ To stop the robot, close the program.
: black-stop 4 pin@ 0= if ;; then ;
: In_circle_run ( -- ) 3000 ms \ Three seconds of waiting for setup.
   InitAll begin
\  When one of the side sensors detects an obstacle, the robot makes a quarter turn.
\ The central sensor is not used.
LEFTSIDESENSOR   0<> if halfturn-clockwise else  GOSTRAIGHT then  RIGHTSIDESENSOR  0<> if halfturn-anticlockwise else  GOSTRAIGHT then  
black-stop again ; \ To stop the robot

end-module

\ Paper_circle import 
\ In_circle_run
\  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
compile-to-flash  
\ cornerstone -cinquieme 
compile-to-flash
begin-module in-the-walls
  
Motors_Robot import  
All_motors import 
four_sensors import
Paper_circle import
pin import   
: LEFTSIDESENSOR  ( -- ) 28 pin@ ;    
: RIGHTSIDESENSOR  ( -- ) 26  pin@ ;   
: SENSORTEST LEFTSIDESENSOR . RIGHTSIDESENSOR . ;
InitAll   
: step-clockwise ( -- )  100 MotorRightForward 100 MotorLeftBackward   stop_motors ;  
: step-anticlockwise ( -- )  100 MotorRightBackward 100 MotorLeftForward 
 stop_motors ;  
: black-stop 4 pin@ 0= if ;; then ;
: In_walls_run ( -- ) 3000 ms InitAll begin LEFTSIDESENSOR   0= if step-anticlockwise else   Forward then  RIGHTSIDESENSOR  0= if step-clockwise else  Forward then  black-stop   again ;
end-module 

in-the-walls import
In_walls_run
\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
