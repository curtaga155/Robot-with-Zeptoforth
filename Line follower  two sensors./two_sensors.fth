 
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
: InitAll  enableAll initAllmotors ;
: test_motors  Forward 2000 ms stop_motors 500 ms Backward 2000 ms stop_motors ;
: start_test_motors InitAll test_motors stop_motors ;



\ two_sensors
task import pin import InitAll
4 input-pin 5 input-pin
variable my-task_left  
variable my-task_right
: robot ( -- )
 0 [: begin 4 pin@   0<> if   00 MotorLeftForward else  100 MotorLeftForward  then     again  ;] 320 128 512 0 spawn-on-core my-task_left  ! 
 0 [: begin 5 pin@   0<> if  00 MotorRightForward  else  100 MotorRightForward   then  again   ;] 320 128 512 1 spawn-on-core my-task_right ! ;
: start_robot my-task_left  @ run my-task_right  @ run ;
: stop_robot my-task_left  @ stop my-task_right @ stop ;


\ application
robot
InitAll
start_robot 
stop_robot


