onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -color Yellow -itemcolor Yellow -label SelOp /testprotocol/Selop
add wave -noupdate -color Cyan -itemcolor Cyan -label A -radix unsigned /testprotocol/A
add wave -noupdate -color Cyan -itemcolor Cyan -label B -radix unsigned /testprotocol/B
add wave -noupdate -divider Output
add wave -noupdate -color {Green Yellow} -itemcolor {Green Yellow} -label Q -radix decimal /testprotocol/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {258836 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {504 ns}
