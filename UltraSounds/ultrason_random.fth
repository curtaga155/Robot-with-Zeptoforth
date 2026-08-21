Motors_Robot import  
All_motors import   
Full-Sensors import 
pin import
Ultra_Sounds import 
RandomTwo import


\ speed motors

: Forward70  70 MotorRightForward  70 MotorLeftForward ;
: Backward70 70 MotorRightBackward 70 MotorLeftBackward ;

\ init rotate
initAll
: step-anticlockwise ( -- )  100 MotorRightForward 100 MotorLeftBackward 1 ms  stop_motors  ;  
: step-clockwise ( -- )  100 MotorRightBackward 100 MotorLeftForward  1 ms
 stop_motors  ; 
: quater-anticlockwise ( -- ) 200 0 do  step-anticlockwise loop ;
: quater-clockwise ( -- )  200 0 do  step-clockwise loop ; 

compile-to-flash
\ application
: Side-control RIGHTPI/4SENSOR 0<> if quater-anticlockwise else Forward70 then
LEFTPI/4SENSOR 0<> if quater-clockwise Forward70  then ;
: Random-Control Eads-or-Tails  0= if quater-anticlockwise else quater-clockwise then ;
: US-control measure-echo 300 < if stop_motors Random-Control  stop_motors  then ;
: stop adc_value 300 < if ;; then ;
\ to start
: run_us  3000 ms  initAll  begin  Forward70 US-control Side-control stop again  ;
: random_run 3000 ms  initAll  begin  Forward70 US-control Side-control  stop again  ;

