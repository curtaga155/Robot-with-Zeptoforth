\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%% ZEPTOROBOT MODULES %%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%% Welcome to zeptoforth %%%%%%%%%%%%%%%%%%%%%%%%
\ Built for rp2040, version 1.16.0, on Sat Jan 31 10:05:15 AM CST 2026
\ zeptoforth comes with ABSOLUTELY NO WARRANTY: for details type `license'


\ Motors
compile-to-flash
\ cornerstone -debut  \ I'm using French  markers to avoid interfering with the English words

compile-to-flash
begin-module Motors_Robot

pwm import
\ MotorLeftForward.fth
8 constant MotorLeftForward
4 constant MotorLeftForward-slice
: init-MotorLeftForward
MotorLeftForward-slice bit disable-pwm
MotorLeftForward-slice
MotorLeftForward pwm-pin  
MotorLeftForward-slice free-running-pwm  
false MotorLeftForward-slice pwm-phase-correct! 
0 25 MotorLeftForward-slice pwm-clock-div! 
125 MotorLeftForward-slice pwm-top!  
125 MotorLeftForward-slice pwm-counter-compare-a!  
0 MotorLeftForward-slice pwm-counter!  
;

: start-MotorLeftForward { compare -- }
MotorLeftForward-slice bit disable-pwm
compare MotorLeftForward-slice pwm-counter-compare-a!
0 MotorLeftForward-slice pwm-counter!
MotorLeftForward-slice bit enable-pwm
;
: MotorLeftForward { compare -- }
compare MotorLeftForward-slice pwm-counter-compare-a!
;
init-MotorLeftForward 
start-MotorLeftForward
compile-to-flash
\ MotorLeftBackward 
15 constant MotorLeftBackward
7 constant MotorLeftBackward-slice
: init-MotorLeftBackward
MotorLeftBackward-slice bit disable-pwm
MotorLeftBackward-slice
MotorLeftBackward pwm-pin 
MotorLeftBackward-slice free-running-pwm  
false MotorLeftBackward-slice pwm-phase-correct! 
0 25 MotorLeftBackward-slice pwm-clock-div! 
125 MotorLeftBackward-slice pwm-top!  
125 MotorLeftBackward-slice pwm-counter-compare-b!  
0 MotorLeftBackward-slice pwm-counter!  
;
: start-MotorLeftBackward { compare -- }
MotorLeftBackward-slice bit disable-pwm
compare MotorLeftBackward-slice pwm-counter-compare-b!
0 MotorLeftBackward-slice pwm-counter!
MotorLeftBackward-slice bit enable-pwm
; 

: MotorLeftBackward { compare -- }
compare MotorLeftBackward-slice pwm-counter-compare-b!
;
init-MotorLeftBackward 
start-MotorLeftBackward

\ MotorRightForward 
7 constant MotorRightForward \ gpio7 pin10 led verte
3 constant MotorRightForward-slice
: init-MotorRightForward
MotorRightForward-slice bit disable-pwm
MotorRightForward-slice
MotorRightForward pwm-pin  
MotorRightForward-slice free-running-pwm 
false MotorRightForward-slice pwm-phase-correct! 
0 25 MotorRightForward-slice pwm-clock-div! 
125 MotorRightForward-slice pwm-top!  
125 MotorRightForward-slice pwm-counter-compare-b!  
0 MotorRightForward-slice pwm-counter!  
;

: start-MotorRightForward { compare -- }
MotorRightForward-slice bit disable-pwm
compare MotorRightForward-slice pwm-counter-compare-b!
0 MotorRightForward-slice pwm-counter!
MotorRightForward-slice bit enable-pwm
; 
: MotorRightForward { compare -- }
compare MotorRightForward-slice pwm-counter-compare-b!
;
init-MotorRightForward  
start-MotorRightForward

\ MotorRightBackward
12 constant MotorRightBackward \ pin 16
6 constant MotorRightBackward-slice
: init-MotorRightBackward
MotorRightBackward-slice bit disable-pwm
MotorRightBackward-slice
MotorRightBackward pwm-pin  
MotorRightBackward-slice free-running-pwm 
false MotorRightBackward-slice pwm-phase-correct! 
0 25 MotorRightBackward-slice pwm-clock-div! 
125 MotorRightBackward-slice pwm-top!  
125 MotorRightBackward-slice pwm-counter-compare-a!  
0 MotorRightBackward-slice pwm-counter!  
;

: start-MotorRightBackward { compare -- }
 MotorRightBackward-slice bit disable-pwm
compare  MotorRightBackward-slice pwm-counter-compare-a!
0  MotorRightBackward-slice pwm-counter!
 MotorRightBackward-slice bit enable-pwm
;
:  MotorRightBackward { compare -- }
compare  MotorRightBackward-slice pwm-counter-compare-a!
;
init-MotorRightBackward 
start-MotorRightBackward
end-module
 

\ applications motors
compile-to-flash
\ cornerstone -ici \ I'm using French  markers to avoid interfering with the English words

compile-to-flash
begin-module All_motors

Motors_Robot import
pin import
: initAllMotors
init-MotorRightBackward start-MotorRightBackward
init-MotorRightForward start-MotorRightForward
init-MotorLeftBackward start-MotorLeftBackward
init-MotorLeftForward start-MotorLeftForward
;

: enableRight  9 output-pin high 9 pin!  ;  
: disableRight 9 output-pin low 9 pin! ;  
: enableLeft 3 output-pin  high 3 pin! ;  
: disableLeft 3 output-pin  low 3 pin! ;  
: enableAll   enableRight enableLeft ;
: disableAll disableRight disableLeft ;
: InitAll enableAll initAllmotors ;

: Forward  100 MotorRightForward  100 MotorLeftForward ;
: Backward 100 MotorRightBackward 100 MotorLeftBackward ;
: StopForward 00 MotorRightForward  00 MotorLeftForward ;
: StopBackward 00  MotorRightBackward  00 MotorLeftBackward ;
: stop_motors StopForward StopBackward ; 

\ test_motors
: test_motors  Forward 500 ms stop_motors 500 ms Backward 500 ms stop_motors ;
: start_test_motors  initAll test_motors stop_motors ;
: ttt start_test_motors ;

 All_motors import
: ttt initAll  Forward 500 ms stop_motors 500 ms Backward 500 ms stop_motors ; 

end-module 

\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

compile-to-flash 
cornerstone -autres 
compile-to-flash 
begin-module Full-Sensors

Motors_Robot import  
All_motors import  
pin import \ pin initialization
: init-Full-Sensors ( -- ) 4 input-pin 5 input-pin 10 input-pin 14 input-pin  21 input-pin 22 input-pin   28 input-pin   InitAll ;
initializer Full-Sensors

: CENTERSENSOR ( -- )  4 pin@  ;  
: LEFTFRONTSENSOR  ( -- ) 21 pin@ ;  
: RIGHTFRONTSENSOR  ( -- )10  pin@ ;  
: RIGHTREARSENSOR  ( -- ) 5 pin@  ; 
: LEFTREARSENSOR  ( -- ) 28 pin@  ; 
: RIGHTPI/4SENSOR  ( -- ) 14   pin@  ; 
: LEFTPI/4SENSOR  ( -- ) 22 pin@  ;
1 constant adc_pin1 0 constant adc_init

\ Sensor test
: SENSORS_TEST ( -- )  cr  
CENTERSENSOR ." CENTERSENSOR=".  cr 
LEFTFRONTSENSOR ." LEFTFRONTSENSOR=" . cr 
RIGHTFRONTSENSOR ." RIGHTFRONTSENSOR=" . cr 
LEFTREARSENSOR  ." LEFTREARSENSOR=" . cr 
RIGHTREARSENSOR  ." RIGHTREARSENSOR=" . cr 
RIGHTPI/4SENSOR  ." RIGHTPI/4SENSOR=" . cr 
LEFTPI/4SENSOR  ." LEFTPI/4SENSOR=" . cr 
;
: st SENSORS_TEST ;

adc import  \ initialisation ADC
1 constant adc_pin1
0 constant adc_init  
: INITadc adc_pin1 adc_init adc@ ;
: adc_value adc_pin1 adc_init adc@ 10 /  ;  
: adc_test begin  adc_value . cr 1000 ms key? until ;   
: as adc_test ; 

 end-module

\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








