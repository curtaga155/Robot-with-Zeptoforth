begin-module RandomTwo  
VARIABLE rand 
HERE rand !  
: random  ( -- ) rand @ 31421 * 6927 + DUP rand ! ; 
: ran2x ( u1 -- u2 ) random random UM* NIP 2 mod ;
end-module
