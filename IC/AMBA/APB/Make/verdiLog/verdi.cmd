verdiSetActWin -dock widgetDock_<Decl._Tree>
debImport "-sv" "../rtl/top_tb.v" "../rtl/APB_top.v" "../rtl/Master.v" \
          "../rtl/Slave.v"
debLoadSimResult /home/twmz/IC_FPGA/IC/AMBA/APB/Make/waveform/waveform.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "499" "105" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "top_tb.u_apb_top" -win $_nTrace1
srcSetScope "top_tb.u_apb_top" -delim "." -win $_nTrace1
srcHBSelect "top_tb.u_apb_top" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "top_tb.u_apb_top.u_apb_master" -win $_nTrace1
srcHBSelect "top_tb.u_apb_top.u_apb_master" -win $_nTrace1
srcSetScope "top_tb.u_apb_top.u_apb_master" -delim "." -win $_nTrace1
srcHBSelect "top_tb.u_apb_top.u_apb_master" -win $_nTrace1
srcHBSelect "top_tb.u_apb_top.u_apb_master" -win $_nTrace1
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.i_sys_clk"
srcSignalViewAddSelectedToWave
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.i_rst_n"
srcSignalViewAddSelectedToWave
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.o_PWRITE"
srcSignalViewAddSelectedToWave
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.o_PENABLE"
srcSignalViewAddSelectedToWave
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.o_PSEL"
srcSignalViewAddSelectedToWave
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.o_PWDATA\[31:0\]"
srcSignalViewAddSelectedToWave
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
wvPanLeft -win $_nWave2
wvPanLeft -win $_nWave2
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "top_tb.u_apb_top.u_apb_slave" -win $_nTrace1
srcSetScope "top_tb.u_apb_top.u_apb_slave" -delim "." -win $_nTrace1
srcHBSelect "top_tb.u_apb_top.u_apb_slave" -win $_nTrace1
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.i_PWDATA\[31:0\]"
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.i_PWDATA\[31:0\]"
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.i_PWDATA\[31:0\]"
srcSignalViewAddSelectedToWave
wvZoomIn -win $_nWave2
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.r_rdata\[31:0\]"
srcSignalViewAddSelectedToWave
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.r_memory\[0:1023\]"
srcSignalViewAddSelectedToWave
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.r_memory\[0:1023\]"
srcSignalViewExpand "top_tb.u_apb_top.u_apb_slave.r_memory\[0:1023\]"
srcSignalViewExpand "top_tb.u_apb_top.u_apb_slave.r_memory\[0\]\[31:0\]"
srcSignalViewCollapse "top_tb.u_apb_top.u_apb_slave.r_memory\[0\]\[31:0\]"
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.r_memory\[0:1023\]"
srcSignalViewCollapse "top_tb.u_apb_top.u_apb_slave.r_memory\[0:1023\]"
srcSignalViewSelect "top_tb.u_apb_top.u_apb_slave.i_PADDR\[31:0\]"
srcSignalViewAddSelectedToWave
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
srcHBSelect "top_tb.u_apb_top.u_apb_master" -win $_nTrace1
srcSetScope "top_tb.u_apb_top.u_apb_master" -delim "." -win $_nTrace1
srcHBSelect "top_tb.u_apb_top.u_apb_master" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcSignalViewSelect "top_tb.u_apb_top.u_apb_master.i_PRDATA\[31:0\]"
srcSignalViewAddSelectedToWave
verdiSetActWin -dock widgetDock_<Signal_List>
wvSetCursor -win $_nWave2 969974.611628 -snap {("G1" 7)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 910552.849789 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 927753.886111 -snap {("G1" 5)}
wvSetCursor -win $_nWave2 938700.000134 -snap {("G1" 5)}
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetCursor -win $_nWave2 946518.653008 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 969974.611628 -snap {("G1" 7)}
srcHBSelect "top_tb.u_apb_top.u_apb_slave" -win $_nTrace1
srcSetScope "top_tb.u_apb_top.u_apb_slave" -delim "." -win $_nTrace1
srcHBSelect "top_tb.u_apb_top.u_apb_slave" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
debExit
