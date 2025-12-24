\ compile-to-flash

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

\ applications
enableAll initAllmotors 
: test_motors  Forward 2000 ms stop_motors 500 ms Backward 2000 ms stop_motors ;
: start_test_motors enableAll initAllmotors test_motors stop_motors ;



pin import   4 input-pin 5 input-pin InitAll 
: turnRight 100 MotorLeftForward 1 ms stop_motors  ;  
: turnLeft   90 MotorRightForward 2 ms stop_motors ;
: LEFT 0 ;  : RIGHT 1 ;  : 1= 1 = ; : BOTH-OFF? AND 0= ;   
: GOSTRAIGHT turnLeft turnRight ;  
: turn ( n-- ) 0= if turnRight else turnLeft then ;  
: LEFTSENSOR 4 pin@  ;  
: RIGHTSENSOR 5 pin@ ; 
: out-loop LEFTSENSOR RIGHTSENSOR and  0=  ;
 : robot begin LEFTSENSOR RIGHTSENSOR BOTH-OFF? if GOSTRAIGHT then   
LEFTSENSOR turn RIGHTSENSOR turn  while  out-loop repeat ; 
 : sensor_test begin  LEFTSENSOR ." left". cr RIGHTSENSOR  ." right" . cr 1000 ms key? until ;
: st sensor_test ;
: step-clockwise 80 MotorRightBackward  80 MotorLeftForward 100 ms stop_motors ;  
: half-turn-clockwise begin step-clockwise  out-loop until  ;
: run_robot robot half-turn-clockwise robot ;
: full_robot 6000 ms 11 1 do run_robot loop ;
full_robot
