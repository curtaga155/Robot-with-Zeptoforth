\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 16 aout 2026 %%%%%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%%%%%%% évite l'obstacle %%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%%%%%%%%% obstacle avoider %%%%%%%%%%%%%%%%%%%%%%%%
\ compile-to-flash 
\ cornerstone -sixieme
\ avoids>obstacle
Motors_Robot import  
All_motors import   
Full-Sensors import 
pin import
Ultra_Sounds import
Robot_starts import 

: Side-control RIGHTPI/4SENSOR 0<> if quater-clockwise else Forward then
LEFTPI/4SENSOR 0<> if quater-anticlockwise Forward  then ;
: US>control measure-echo 200 < if stop_motors quater-clockwise  stop_motors  then ;
: run>us  10000 ms  initAll  begin  Forward 10 ms stop_motors  US>control Side-control stop again  ; 

\ cornerstone -septieme
\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 15 aout 2026 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
