\ a twisted path

Motors_Robot import  ok
All_motors import   ok
Paper_circle  import  ok
pin import   5 input-pin 20 input-pin 21 input-pin   ok
adc import  ok
: CENTERSENSOR     ( -- )  4 pin@ ;   ok
: LEFTSIDESENSOR   ( -- ) 28 pin@ ;      ok
: RIGHTSIDESENSOR  ( -- ) 26  pin@ ;     ok
: SENSORS_TEST ( -- ) CENTERSENSOR   ." CENTERSENSOR=". LEFTSIDESENSOR ." LEFTSIDESENSOR=" . RIGHTSIDESENSOR  ." RIGHTSIDESENSOR=" . ;  ok
InitAll  ok
  ok
: step-anticlockwise ( -- )  100 MotorRightForward 100 MotorLeftBackward 1 ms  stop_motors  ;    ok
: step-clockwise ( -- )  100 MotorRightBackward 100 MotorLeftForward  1 ms  ok
 stop_motors  ;   ok
: quater-anticlockwise ( -- ) 200 0 do  step-anticlockwise loop ;  ok
: quater-clockwise ( -- )  200 0 do  step-clockwise loop ;   ok
: halfturn-anticlockwise ( -- ) 500 0 do  step-anticlockwise loop ;  ok
: halfturn-clockwise ( -- )  500 0 do  step-clockwise loop ;  ok
: trip>left  CENTERSENSOR  0<> if stop_motors quater-anticlockwise then ;  ok
: trip>right  CENTERSENSOR  0<> if stop_motors quater-clockwise then ;  ok
  ok
\ ADC  ok
: INITadc adc_pin1 adc_init adc@ ;  ok
: adc_black ( -- ) INITadc 2800 < if halfturn-clockwise trip>right_run then ; unable to parse: trip>right_run
: adc_grey ( -- ) INITadc 2800 < if halfturn-anticlockwise trip>left_run then ; unable to parse: trip>left_run
\ clockwise  ok
: trip>right_run  ( -- )  InitAll begin LEFTSIDESENSOR   0<> if step-clockwise else   Forward   then  RIGHTSIDESENSOR  0<> if step-anticlockwise else  Forward  then  trip>right adc_black  again ;  unable to parse: adc_black
\ anticlockwise  ok
: trip>left_run  ( -- ) 1000 ms InitAll begin LEFTSIDESENSOR   0<> if step-clockwise else   Forward   then  RIGHTSIDESENSOR  0<> if step-anticlockwise else  Forward  then  trip>left adc_grey again ;  unable to parse: adc_grey
  ok

