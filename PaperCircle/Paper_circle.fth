\ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\ %%%%%%%%%%%%%%%%%%%%%%%%%%  Paper_circle  %%%%%%%%%%%%%%%%%%%%%%%%%%
\ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

compile-to-flash 
\ cornerstone -autres  
begin-module Paper_circle
\ In a circle initialization
\ modules import 
\ Install from MODULES.fth
Motors_Robot import  
All_motors import  
\ pin initialization
pin import 4 input-pin 5 input-pin 28 input-pin 27 input-pin 
adc import \ adc initialization
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
1 constant adc_pin1 0 constant adc_init
\ Sensor test
: SENSORS_TEST ( -- )  CENTERSENSOR ." CENTERSENSOR=". LEFTSIDESENSOR ." LEFTSIDESENSOR=" . RIGHTSIDESENSOR  ." RIGHTSIDESENSOR=" . ;
\ halfturn
: step-clockwise ( -- )  80 MotorRightForward 80 MotorLeftBackward 100 ms  stop_motors ;
: step-anticlockwise ( -- )  80 MotorRightBackward 80 MotorLeftForward 100 ms stop_motors ;
\ For this route, the half-turns are more like quarter turns.
: halfturn-anticlockwise ( -- )  4 0 do  step-anticlockwise loop ;
: halfturn-clockwise ( -- )  4 0 do  step-clockwise loop ;
end-module

\ In the circle
compile-to-flash
\ cornerstone -ligne
begin-module Robot_circle 

Motors_Robot import 
All_motors import  
Paper_circle import
\ To stop the robot, close the program.
adc import
: adc_stop ( -- ) adc_pin1 adc_init adc@ 3000 < if reboot then ;

: In_circle_run ( -- ) 3000 ms \ Three seconds of waiting for setup.
   InitAll begin
\  When one of the side sensors detects an obstacle, the robot makes a quarter turn.
\ The central sensor is not used.
LEFTSIDESENSOR   0<> if halfturn-clockwise else  GOSTRAIGHT then  RIGHTSIDESENSOR  0<> if halfturn-anticlockwise else  GOSTRAIGHT then  
adc_stop again ; \ To stop the robot

end-module

\ Robot_circle import   
\ In_circle_run
\ +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

