compile-to-flash   

begin-module paper_run

Motors_Robot import 
All_motors import  
Paper_circle import  
task import 
pin import
: init-robot ( -- ) 28 input-pin 26 input-pin InitAll ;
initializer init-robot
: control_left begin 28 pin@   0= if  00 MotorLeftForward else 100 MotorLeftForward  then  again ;  
 : control_right begin 26 pin@   0= if  00 MotorRightForward else 100 MotorRightForward  then  again ;   
: robot   
0 ['] control_left 256 128 512 0 spawn-on-core run  
0 ['] control_right 256 128 512 1 spawn-on-core run  
; 
end-module
paper_run::robot

paper_run import
robot
