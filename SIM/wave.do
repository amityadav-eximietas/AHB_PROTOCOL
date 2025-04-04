onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ahb_tb_top/ahb_mas_vif_0/hclk
add wave -noupdate /ahb_tb_top/ahb_mas_vif_0/hrst_n
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hrst_n
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hwrite
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/htrans
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/haddr
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hwdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hburst
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hready
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} -radix binary /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hstrb
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/hsize
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mdrv_cb} /ahb_tb_top/ahb_mas_vif_0/mdrv_cb/mdrv_cb_event
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hrst_n
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hwrite
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/htrans
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/haddr
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hwdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hresp
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hburst
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hrdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hready
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hstrb
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/hsize
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_mas_vif_0/mmon_cb} /ahb_tb_top/ahb_mas_vif_0/mmon_cb/mmon_cb_event
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hrst_n
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hwrite
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/htrans
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/haddr
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hwdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hburst
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hresp
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hrdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hsize
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/hstrb
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/sdrv_cb} /ahb_tb_top/ahb_slv_vif_0/sdrv_cb/sdrv_cb_event
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hrst_n
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hwrite
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/htrans
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/haddr
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hwdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hburst
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hready_out
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hrdata
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hresp
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hsize
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/hstrb
add wave -noupdate -expand -label sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb/Group1 -group {Region: sim:/ahb_tb_top/ahb_slv_vif_0/smon_cb} /ahb_tb_top/ahb_slv_vif_0/smon_cb/smon_cb_event
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 20
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {158 ns}
