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



\ADC
\ FOREHEAD 
\ front sensor initialization
adc import
1 constant adc_pin1\GPIO27
0 constant adc_init
: sensor_value_front adc_pin1 adc_init adc@; 
\checking the front sensor
: sensor_pin1_test begins sensor_value_front . cr 1000 ms key? until ; : st1 sensor_pin1_test ;

\REAR
\rear sensor initialization
adc import
0 constant adc_pin0\GPIO26
0 constant adc_init
\ rear sensor check
: sensor_value_rear adc_pin0 adc_init adc@;
: sensor_pin0_test begin sensor_value_rear . cr 1000 ms key? until ; : st0 sensor_pin0_test ;

\forward adc_pin1
: stop_left_forward 0 MotorLeftForward;
: stop_right_forward 0 MotorRightForward;

\black_on_the_right_forward
lambda import/initialization control structures
: black_on_the_right_stop_left_forward sensor_value_front 1500 > [: stop_left_forward ;] qif ;
: black_on_the_right_stop_right_forward sensor_value_front 1500 < [: stop_right_forward ;] qif ;
\ moving the blackest part of the line to its right.
: robot_black_forward begin Forward
black_on_the_right_stop_left_forward
black_on_the_right_stop_right_forward
50 ms sensor_value_front 3500 > until ;

\backward adc_pin0
: stop_left_backward 0 MotorLeftBackward;
: stop_right_backward 0 MotorRightBackward ;

\white_on_the_right_backward
lambda import/initialization control structures
: white_on_the_right_stop_right sensor_value_rear 2000 < [: stop_right_backward ;] qif ;
: white_on_the_right_stop_left sensor_value_rear 2000 > [: stop_left_backward ;] qif ;

\ moving the whitest part of the line to its right.
: robot_white_backward begin Backward
white_on_the_right_stop_right
white_on_the_right_stop_left
50 ms sensor_value_rear 3500 > until ;

\ the main sequence
: run_front InitAll robot_black_forward stop_motors 100 MotorLeftForward 300 ms stop_motors;
: run_rear InitAll robot_white_backward 100 MotorLeftBackward 300 ms stop_motors;
\ MotorLeftBackward and MotorLeftForward align the robot on the track.

\ Loop five times with a nine-second delay.
: on_the_line 9000 ms 5 0 do run_front run_rear loop ;
