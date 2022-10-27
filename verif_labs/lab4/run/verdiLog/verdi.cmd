verdiWindowWorkMode -win $_Verdi_1 -formalVerification
verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
srcSetPreference -vcstOpts \
           {-demo -file run.tcl -prompt vcf -fmode _default -new_verdi_comm}
verdiDockWidgetSetCurTab -dock windowDock_vcstConsole_2
verdiWindowResize -win $_Verdi_1 "0" "0" "1470" "817"
schSetVCSTDelimiter -hierDelim "."
srcSetXpropOption "tmerge"
simSetSimulator "-vcssv" -exec \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/seq_top.exe" \
           -args
debImport "-simflow" "-dbdir" \
          "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/seq_top.exe.daidir"
verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
verdiDockWidgetSetCurTab -dock widgetDock_VCF:TaskList
srcSetSnipSignal -reset
srcSetSnipSignal -reset
opVerdiComponents -xmlstr \
           "<Command delimiter=\"/\" name=\"schSession\">
<HighlightObjs clear=\"true\"/>
</Command>
"
schSetPreference -displayAbstractSrc on
verdiRunVcstCmd check_fv

verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
srcShowDefine -incrSearch seq_top.spec.product
srcShowDefine -incrSearch seq_top.spec.product
srcDeselectAll -win $_nTrace1
srcSelect -signal "product" -line 296 -pos 1 -win $_nTrace1
srcDbClkSource -file \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/design/rtl1cg_bad.v" \
           -line 295
srcAction -pos 295 11 5 -win $_nTrace1 -name "product" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcDbClkSource -file \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/design/rtl1cg_bad.v" \
           -line 362
srcSetActiveSourceTab -win $_nTrace1 -tab 1
srcHBSelect "seq_top.impl" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "product" -line 370 -pos 1 -win $_nTrace1
srcDbClkSource -file \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/design/rtl1cg_bad.v" \
           -line 369
srcAction -pos 369 1 3 -win $_nTrace1 -name "product" -ctrlKey off
srcSetActiveSourceTab -win $_nTrace1 -tab 2
srcHBSelect "seq_top.spec" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "product" -line 370 -pos 1 -win $_nTrace1
srcDbClkSource -file \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/design/rtl1cg_bad.v" \
           -line 369
srcAction -pos 369 1 2 -win $_nTrace1 -name "product" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "product" -line 370 -pos 1 -win $_nTrace1
srcDbClkSource -file \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/design/rtl1cg_bad.v" \
           -line 369
srcAction -pos 369 1 2 -win $_nTrace1 -name "product" -ctrlKey off
verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcInvokeExtEditor -win $_nTrace1
srcSaveAs -win $_nTrace3 -file \
          /home/ecelrc/students/jkhare/verif_labs/lab4/design/rtl1cg_bad.v
nsMsgSwitchTab -tab general
verdiWindowSaveUserLayout -win $_Verdi_1 "UserRestart_1"
verdiVcstRestartShellApp
verdiWindowRestoreUserLayout -win $_Verdi_1 "UserRestart_1"
verdiWindowResize -win $_Verdi_1 "0" "0" "1470" "817"
verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
verdiSetSyncSelection -win $_Verdi_1
verdiSeqDebug -on
verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
schSetVCSTDelimiter -hierDelim "."
srcSetXpropOption "tmerge"
simSetSimulator "-vcssv" -exec \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/seq_top.exe" \
           -args
debImport "-simflow" "-dbdir" \
          "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/seq_top.exe.daidir"
verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
srcSetSnipSignal -reset
srcSetSnipSignal -reset
opVerdiComponents -xmlstr \
           "<Command delimiter=\"/\" name=\"schSession\">
<HighlightObjs clear=\"true\"/>
</Command>
"
verdiRunVcstCmd check_fv

verdiSeqDebug -xml \
           "/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml"
debExit
