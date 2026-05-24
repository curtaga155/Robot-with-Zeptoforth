ompile-to-flash 
\ cornerstone -rien
begin-module wriggling_rat
Motors_Robot import
All_motors import 
Paper_circle  import
pin import   4 input-pin 20 input-pin 21 input-pin 
adc import
: CENTERSENSOR     ( -- )  4 pin@ ; 
: LEFTSIDESENSOR   ( -- ) 28 pin@ ;    
: RIGHTSIDESENSOR  ( -- ) 26  pin@ ;   
: SENSORS_TEST ( -- ) CENTERSENSOR   ." CENTERSENSOR=". LEFTSIDESENSOR ." LEFTSIDESENSOR=" . RIGHTSIDESENSOR  ." RIGHTSIDESENSOR=" . ;
InitAll
: step-anticlockwise ( -- )  100 MotorRightForward 100 MotorLeftBackward 1 ms  stop_motors  ;  
: step-clockwise ( -- )  100 MotorRightBackward 100 MotorLeftForward  1 ms
 stop_motors  ;  
\ : halfturn-anticlockwise ( -- )  8 0 do  step-anticlockwise loop ;
: halfturn-clockwise ( -- )  500 0 do  step-clockwise loop ;
: wait_motor CENTERSENSOR 0<> if halfturn-clockwise 1 ms else Forward then ;
: adc_stop ( -- ) adc_pin1 adc_init adc@ 3000 < if reboot then ;
: rat_run  ( -- ) 3000 ms InitAll begin LEFTSIDESENSOR   0<> if step-clockwise else   Forward   then  RIGHTSIDESENSOR  0<> if step-anticlockwise else  Forward  then wait_motor adc_stop again ;
end-module
