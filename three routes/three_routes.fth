\ three_routes
Motors_Robot import
All_motors import 
Paper_circle  import
pin import   5 input-pin 20 input-pin 21 input-pin 
adc import
: CENTERSENSOR     ( -- )  4 pin@ ; 
: LEFTSIDESENSOR   ( -- ) 28 pin@ ;    
: RIGHTSIDESENSOR  ( -- ) 26  pin@ ;   
: SENSORS_TEST ( -- ) CENTERSENSOR   ." CENTERSENSOR=". LEFTSIDESENSOR ." LEFTSIDESENSOR=" . RIGHTSIDESENSOR  ." RIGHTSIDESENSOR=" . ;
InitAll

\ compile-to-flash
: step-anticlockwise ( -- )  100 MotorRightForward 100 MotorLeftBackward 1 ms  stop_motors  ;  
: step-clockwise ( -- )  100 MotorRightBackward 100 MotorLeftForward  1 ms
 stop_motors  ; 
: quater-anticlockwise ( -- ) 200 0 do  step-anticlockwise loop ;
: quater-clockwise ( -- )  200 0 do  step-clockwise loop ; : halfturn-anticlockwise ( -- ) 500 0 do  step-anticlockwise loop ;

\ compile-to-flash
: halfturn-clockwise ( -- )  500 0 do  step-clockwise loop ;
: trip>left  CENTERSENSOR  0<> if stop_motors quater-anticlockwise then ;
: trip>right  CENTERSENSOR  0<> if stop_motors quater-clockwise then ;

\ compile-to-flash
: INITadc adc_pin1 adc_init adc@ ;

\ : adc_medium-gray ( -- ) INITadc 3200 < if reboot  then ;
\ : adc_light-gray ( -- ) INITadc  3800 < if reboot then ; 
: adc_stop ( -- ) INITadc 2800 < if halfturn-anticlockwise reboot then ;
\ compile-to-flash
: test-adc 12 0 DO INITadc . cr  100 ms LOOP ;

\ compile-to-flash
: trip>right_run  ( -- ) 1000 ms  InitAll begin LEFTSIDESENSOR   0<> if step-clockwise else   Forward   then  RIGHTSIDESENSOR  0<> if step-anticlockwise else  Forward  then  trip>right  adc_stop   again ; 
\ clockwise


: trip>left_run  ( -- ) 1000 ms InitAll begin LEFTSIDESENSOR   0<> if step-clockwise else   Forward   then  RIGHTSIDESENSOR  0<> if step-anticlockwise else  Forward  then  trip>left  INITadc 2800 <  if halfturn-anticlockwise trip>right_run then again ; 
\ anticlockwise

: trip>right_start  ( -- ) 5000 ms InitAll begin LEFTSIDESENSOR   0<> if step-clockwise else   Forward   then  RIGHTSIDESENSOR  0<> if step-anticlockwise else  Forward  then  trip>right INITadc 2800 < if halfturn-clockwise  trip>left_run then again ; 

