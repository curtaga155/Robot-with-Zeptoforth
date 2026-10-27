
compile-to-flash
begin-module Motors_Robot-back
pwm import

\ Motor-backLeftForward.fth

18 constant Motor-backLeftForward
1 constant Motor-backLeftForward-slice
: init-Motor-backLeftForward
Motor-backLeftForward-slice bit disable-pwm
Motor-backLeftForward-slice
Motor-backLeftForward pwm-pin 

Motor-backLeftForward-slice free-running-pwm  
false Motor-backLeftForward-slice pwm-phase-correct! 
0 25 Motor-backLeftForward-slice pwm-clock-div! 
125 Motor-backLeftForward-slice pwm-top!  
125 Motor-backLeftForward-slice pwm-counter-compare-a!  
0 Motor-backLeftForward-slice pwm-counter!  
;
: start-Motor-backLeftForward { compare -- }
Motor-backLeftForward-slice bit disable-pwm
compare Motor-backLeftForward-slice pwm-counter-compare-a!
0 Motor-backLeftForward-slice pwm-counter!
Motor-backLeftForward-slice bit enable-pwm
;

: Motor-backLeftForward { compare -- }
compare Motor-backLeftForward-slice pwm-counter-compare-a!
;
init-Motor-backLeftForward 
start-Motor-backLeftForward

\ Motor-backLeftBackward 
27 constant Motor-backLeftBackward
5 constant Motor-backLeftBackward-slice
: init-Motor-backLeftBackward
Motor-backLeftBackward-slice bit disable-pwm
Motor-backLeftBackward-slice
Motor-backLeftBackward pwm-pin 

Motor-backLeftBackward-slice free-running-pwm  
false Motor-backLeftBackward-slice pwm-phase-correct! 
0 25 Motor-backLeftBackward-slice pwm-clock-div! 
125 Motor-backLeftBackward-slice pwm-top!  
125 Motor-backLeftBackward-slice pwm-counter-compare-b!  
0 Motor-backLeftBackward-slice pwm-counter!  
;

: start-Motor-backLeftBackward { compare -- }
Motor-backLeftBackward-slice bit disable-pwm
compare Motor-backLeftBackward-slice pwm-counter-compare-b!
0 Motor-backLeftBackward-slice pwm-counter!
Motor-backLeftBackward-slice bit enable-pwm
; 

: Motor-backLeftBackward { compare -- }
compare Motor-backLeftBackward-slice pwm-counter-compare-b!
;
init-Motor-backLeftBackward 
start-Motor-backLeftBackward

\ Motor-backRightForward 
5 constant Motor-backRightForward \ gpio7 pin10 led verte
2 constant Motor-backRightForward-slice
: init-Motor-backRightForward
Motor-backRightForward-slice bit disable-pwm
Motor-backRightForward-slice
Motor-backRightForward pwm-pin

 
Motor-backRightForward-slice free-running-pwm 
false Motor-backRightForward-slice pwm-phase-correct! 
0 25 Motor-backRightForward-slice pwm-clock-div! 
125 Motor-backRightForward-slice pwm-top!  
125 Motor-backRightForward-slice pwm-counter-compare-b!  
0 Motor-backRightForward-slice pwm-counter!  
;

: start-Motor-backRightForward { compare -- }
Motor-backRightForward-slice bit disable-pwm
compare Motor-backRightForward-slice pwm-counter-compare-b!
0 Motor-backRightForward-slice pwm-counter!
Motor-backRightForward-slice bit enable-pwm
; 

: Motor-backRightForward { compare -- }
compare Motor-backRightForward-slice pwm-counter-compare-b!
;
init-Motor-backRightForward  
start-Motor-backRightForward

\ Motor-backRightBackward
pwm import
13 constant Motor-backRightBackward 
6 constant Motor-backRightBackward-slice
: init-Motor-backRightBackward
Motor-backRightBackward-slice bit disable-pwm
Motor-backRightBackward-slice
Motor-backRightBackward pwm-pin 

Motor-backRightBackward-slice free-running-pwm 
false Motor-backRightBackward-slice pwm-phase-correct! 
0 25 Motor-backRightBackward-slice pwm-clock-div! 
125 Motor-backRightBackward-slice pwm-top!  
125 Motor-backRightBackward-slice pwm-counter-compare-b!  
0 Motor-backRightBackward-slice pwm-counter!  
;

: start-Motor-backRightBackward { compare -- }
 Motor-backRightBackward-slice bit disable-pwm
compare  Motor-backRightBackward-slice pwm-counter-compare-b!
0  Motor-backRightBackward-slice pwm-counter!
 Motor-backRightBackward-slice bit enable-pwm
;

:  Motor-backRightBackward { compare -- }
compare  Motor-backRightBackward-slice pwm-counter-compare-b!
;
init-Motor-backRightBackward 
start-Motor-backRightBackward

\ Application All_motors-back
pin import
: initAllMotors-back
init-Motor-backRightBackward start-Motor-backRightBackward
init-Motor-backRightForward start-Motor-backRightForward
init-Motor-backLeftBackward start-Motor-backLeftBackward
init-Motor-backLeftForward start-Motor-backLeftForward
;: enableRight-back  17 output-pin high 17 pin!  ;  
: disableRight-back 17 output-pin low 17 pin! ;  
: enableLeft-back 28 output-pin  high 28 pin! ;  
: disableLeft-back 28 output-pin  low 28 pin! ;  
: enableAll-back   enableRight-back enableLeft-back ;
: disableAll-back disableRight-back disableLeft-back ;
: InitAll-back enableAll-back  initAllMotors-back ;

: Forward-back  100 Motor-backRightForward 100 Motor-backLeftForward ;
: Backward-back 100 Motor-backRightBackward 100 Motor-backLeftBackward ;
: StopForward-back 00 Motor-backRightForward  00 Motor-backLeftForward ;
: StopBackward-back 00  Motor-backRightBackward 00 Motor-backLeftBackward ;
: stop_motors-back StopForward-back StopBackward-back ; 

\ test_motors-back
: test_motors-back  Forward-back 500 ms stop_motors-back 500 ms Backward-back 500 ms stop_motors-back ;
: start_test_motors-back  initAll-back test_motors-back stop_motors-back ;
: rtt start_test_motors-back ;

end-module 

