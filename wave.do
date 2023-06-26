onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_bin2bcd/clk
add wave -noupdate /tb/u_bin2bcd/rstn
add wave -noupdate /tb/u_bin2bcd/bin_vid
add wave -noupdate /tb/u_bin2bcd/bin
add wave -noupdate /tb/u_bin2bcd/bcd_vid
add wave -noupdate /tb/u_bin2bcd/bcd
add wave -noupdate /tb/u_bin2bcd/din
add wave -noupdate /tb/u_bin2bcd/sum_pipe
add wave -noupdate /tb/u_bin2bcd/sum0
add wave -noupdate /tb/u_bin2bcd/din_pipe
add wave -noupdate /tb/u_bin2bcd/res
add wave -noupdate /tb/u_bin2bcd/vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {421425 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 196
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 3
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
WaveRestoreZoom {99048 ps} {548708 ps}
