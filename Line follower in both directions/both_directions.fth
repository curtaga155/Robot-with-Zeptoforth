\ Line follower in both directions
: initAllMotors
init-MotorRightBackward start-MotorRightBackward
init-MotorRightForward start-MotorRightForward
init-MotorLeftBackward start-MotorLeftBackward
init-MotorLeftForward start-MotorLeftForward
;

 : enableRight  
 pin import   
9 output-pin  
high 9 pin!  
;  

: disableRight
 pin import   
9 output-pin  
low 9 pin!  
;  

: enableLeft \ green left yellow
 pin import   
3 output-pin  \ gpio09
high 3 pin!  
;  

: disableLeft  
pin import
3 output-pin  
low 3 pin!  
;  

: enableAll   enableRight enableLeft ;
: disableAll disableRight disableLeft ;

 : Forward  100 MotorRightForward  100 MotorLeftForward ;
 : Backward 100 MotorRightBackward 100 MotorLeftBackward ;
 : StopForward 0 MotorRightForward  0 MotorLeftForward ;
 : StopBackward 0  MotorRightBackward  0 MotorLeftBackward ;
 : stop_motors StopForward StopBackward ; 

\ applications motors
enableAll initAllmotors 
: test_motors  Forward 2000 ms stop_motors 500 ms Backward 2000 ms stop_motors ;
: start_test_motors enableAll initAllmotors test_motors stop_motors ;

\ applications round_trip
pin import   4 input-pin 5 input-pin 20 input-pin 21 input-pin InitAll 
: turnRight 100 MotorLeftForward 1 ms stop_motors  ;  
: turnLeft   90 MotorRightForward 2 ms stop_motors ;
: LEFT 0 ;  : RIGHT 1 ;  : 1= 1 = ; : BOTH-OFF? AND 0= ;   
: GOSTRAIGHT turnLeft turnRight ;  
: turn ( n-- ) 0= if turnRight else turnLeft then ;  
: LEFTSENSOR 4 pin@  ;  : RIGHTSENSOR 5 pin@ ; 
: out-loop LEFTSENSOR RIGHTSENSOR and  0=  ;
: out-loop-anticlockwise RIGHTSENSOR 0=  ; 
: out-loop-clockwise LEFTSENSOR  0=  ; 
: step-clockwise 80 MotorRightBackward  80 MotorLeftForward 100 ms stop_motors ;
: step-anticlockwise  80 MotorRightForward 80 MotorLeftBackward 100 ms  stop_motors ;
: half-turn-clockwise begin step-clockwise  out-loop-clockwise until  ;
: half-turn-anticlockwise begin step-anticlockwise out-loop until  ;
: robot begin LEFTSENSOR RIGHTSENSOR BOTH-OFF? if GOSTRAIGHT then   
LEFTSENSOR turn RIGHTSENSOR turn  while  out-loop  repeat ;
: run_robot-anticlockwise robot half-turn-anticlockwise  ;
: run_robot-clockwise robot half-turn-clockwise ;
: full_robot-clockwise  22 1 do run_robot-clockwise loop ;
: full_robot-anticlockwise  20 1 do run_robot-anticlockwise loop ;
: round_trip 9000 ms InitAll full_robot-clockwise full_robot-anticlockwise reboot ;
round_trip
