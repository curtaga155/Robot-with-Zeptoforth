
compile-to-flash
begin-module App_Omni

Motors_Robot-front import 
Motors_Robot-back import
InitAll InitAll-front
: InitRobot InitAll InitAll-front ;

: stop StopForward StopForward-front StopBackward StopBackward-front ;
: sss stop ; 

: 1ClockWise 100 MotorLeftForward-front ;
: 2ClockWise 100 MotorRightForward-front ;
: 3ClockWise  100 MotorLeftForward ;
: 4ClockWise  100 MotorRightForward ;

: 1AntiClockWise 100 MotorLeftBackward-front ;
: 2AntiClockWise 100 MotorRightBackward-front ;
: 3AntiClockWise 100 MotorRightBackward ;
: 4AntiClockWise 100 MotorLeftBackward ;

: round_trip InitRobot 1ClockWise 2ClockWise 3ClockWise  4ClockWise 1000 ms stop 200 ms 
1AntiClockWise 2AntiClockWise 3AntiClockWise 4AntiClockWise 
1000 ms stop 
;

 : one_by_one 1ClockWise 1000 ms stop 2ClockWise 1000 ms stop 3ClockWise 1000 ms stop 4ClockWise 1000 ms stop 4AntiClockWise 1000 ms stop 3AntiClockWise 1000 ms stop 2AntiClockWise 1000 ms stop  1AntiClockWise 1000 ms stop 
;

: Left>Right InitRobot 1ClockWise 2AntiClockWise 4AntiClockWise  3ClockWise 1000 ms stop ; 

: Right>Left InitRobot 1AntiClockWise 2ClockWise 3AntiClockWise 4ClockWise 1000 ms stop ;

\ compile-to-flash
end-module 

