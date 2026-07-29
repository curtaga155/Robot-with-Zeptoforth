Motors_Robot import  
All_motors import   
Full-Sensors import
pin import
adc import
\ adc import  \ initialisation ADC
1 constant adc_pin1
0 constant adc_init  
: INITadc adc_pin1 adc_init adc@ ;
: adc_value adc_pin1 adc_init adc@ 10 /  ;  
: adc_test begin  adc_value . cr 1000 ms key? until ;   
: as adc_test ; 

: adc_stop ( -- ) adc_value 280 < if  reboot then ;   
: tempo initAll 80 0 DO Forward 1 ms stop_motors LOOP ;  
: anticlockwise 100 MotorRightForward 100 MotorLeftBackward 240 ms stop_motors ; 
: clockwise 100 MotorRightBackward    100   MotorLeftForward 240 ms stop_motors ;

\ applications
: GoStraightLine  RIGHTFRONTSENSOR RIGHTREARSENSOR  AND 0<>   
if initAll  Forward  1 ms stop_motors 1 ms   then
 CENTERSENSOR RIGHTREARSENSOR and 0<>   
if tempo  stop_motors 800 ms anticlockwise then 
RIGHTFRONTSENSOR RIGHTREARSENSOR and 0<>
if Forward 1 ms stop_motors  1 ms   then
; 
: RobotRun>  initAll ( 2000  ms )   begin GoStraightLine ( adc_stop ) again ;   
\ RobotRun>

