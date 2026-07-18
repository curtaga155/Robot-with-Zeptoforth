\ %%%%%%%%%%%%%%%%%%%%%%%%%%%% TWO CHICANES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ compile-to-flash 
\ cornerstone -sauf  
begin-module Two_chicanes
Motors_Robot import
All_motors import 
Paper_circle  import
pin import 
adc import  
\ initialization
: init-robot> ( -- ) 4 input-pin  28 input-pin 26 input-pin InitAll ;
initializer init-robot>
: INITadc adc_pin1 adc_init adc@ ;
\ Applications
: CENTERSENSOR     ( -- )  4 pin@ ;
: LEFTFRONTSENSOR  ( -- ) 28 pin@ ;
: RIGHTFRONTSENSOR ( -- ) 26 pin@ ;
: pin_test ( -- ) CENTERSENSOR   ." CENTER=". LEFTFRONTSENSOR  ." LEFTFRONT=" . RIGHTFRONTSENSOR  ." RIGHTFRONT=" . ;  
: sensor_value adc_pin1 adc_init adc@ 10 / ; 
: sensor_test begin  sensor_value . cr 1000 ms key? until ; 
: st ( -- ) sensor_test ;   : ft ( -- ) pin_test ;  \ shortcuts
: one-clockwise 100 MotorRightBackward    100   MotorLeftForward 260 ms stop_motors ;
: one-anticlockwise 100  MotorRightForward 100 MotorLeftBackward 260 ms stop_motors ; 
: turn_right  70 MotorRightBackward  70 MotorLeftForward  1 ms stop_motors ;
: turn_left   70 MotorRightForward   70 MotorLeftBackward 1 ms stop_motors ;
: tempo 50 0 DO turn_right  LOOP ;
: gostraight 70  MotorRightForward   70 MotorLeftForward  1 ms stop_motors ;
: control>  begin
sensor_value  373 < if  turn_right   else gostraight then \ on the line
sensor_value  377 > if  turn_left    else gostraight then \ on the line
sensor_value 385 > until tempo  stop_motors \ if the sensor is on white
RIGHTFRONTSENSOR  CENTERSENSOR  AND if  
one-anticlockwise then 
LEFTFRONTSENSOR CENTERSENSOR    AND if
one-clockwise then ;
: robot>  2000 ms  35 0 do control>  10 ms  loop  ; \ to be modified if necessary
\ robot>
end-module

