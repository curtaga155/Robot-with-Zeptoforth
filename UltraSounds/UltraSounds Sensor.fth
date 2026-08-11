\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%% UltraSounds Sensor  %%%%%%%%%%%%%%%%%%%%
\ %%%%%%%%%%%%  Many thanks to Travis Bemann! %%%%%%%%%%%%%%
\ %%%%%%%%%%%%%%%%%%%%ZEPTOFORTH %%%%%%%%%%%%%%%%%%%%%%%%%%%

compile-to-flash
begin-module Ultra_Sounds
pin import
gpio import
interrupt import
17 constant trigger-pin
16 constant echo-pin
0 value echo-started-us
0 value echo-ended-us
false value echo-started?
false value echo-ended?
: handle-echo ( -- )
echo-pin PROC0_INTS_GPIO_EDGE_HIGH@ if
echo-started? not if
TIMER::US-COUNTER-LSB to echo-started-us
true to echo-started?
then
echo-pin INTR_GPIO_EDGE_HIGH!
then
echo-pin PROC0_INTS_GPIO_EDGE_LOW@ if
echo-started? echo-ended? not and if
TIMER::US-COUNTER-LSB to echo-ended-us
true to echo-ended?
then
echo-pin INTR_GPIO_EDGE_LOW!
then
;
: init-ultrasound-pins ( -- )
trigger-pin output-pin
echo-pin input-pin
echo-pin pull-down-pin
['] handle-echo IO_IRQ_BANK0 16 + vector!
true echo-pin PROC0_INTE_GPIO_EDGE_HIGH!
true echo-pin PROC0_INTE_GPIO_EDGE_LOW!
IO_IRQ_BANK0 NVIC_ISER_SETENA!
;
initializer init-ultrasound-pins
\ Measure an echo in us
: measure-echo ( -- us )
false to echo-ended?
false to echo-started?
true trigger-pin pin!
10. timer::delay-us
false trigger-pin pin!
begin echo-ended? until
echo-ended-us echo-started-us -
;
end-module

