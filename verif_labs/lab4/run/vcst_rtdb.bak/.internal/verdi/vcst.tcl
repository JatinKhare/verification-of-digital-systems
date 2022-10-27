## VerdiPlay
source ./verdi_vcst.tcl
verdiVcstResizeTopWin
verdiWindowRestoreUserLayout -lastRunLayout
verdiDockWidgetSetCurTab -dock windowDock_vcstConsole_2
::vcst::creatInstAction
::vcst::createAnalyzerAction
::vcst::creatResetLayoutAction
set ::vcst::EnableUDWin 0
qwConfig -type nWave -cmds [list {qwAddToolBarGroup -group "UDWinGroup"}]
srcSetOptions -lockActView on
source /usr/local/packages/synopsys_2020/vc_static/Q-2020.03-SP2/auxx/monet/tcl/menu.tcl

verdiVcstOnPropSelectionChanged -strNum 0 -propList {}
verdiVcstSetAppmode -mode SEQ -fromVcst
::vcst::changeLayout FPV SEQ
verdiVcstCheckFv -active -taskName SEQ
set ::vcst::_fml_max_proof_depth {-1};set ::vcst::_fml_max_time {12H};catch {verdiVcstOnFmlVarChanged -key {fml_effort} -value {default}}
verdiVcstDesignLoaded
verdiSetStatusMsg -win Verdi_1 -color red { Design import... cross probing not ready }
set ::vcst::_top "seq_top"
set ::vcst::_elab ""
set ::vcst::_elabOpts {}
set ::vcst::_rtdbDir {/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb}
set ::vcst::_hiddenDir {.internal}
set ::vcst::_masterMode true
set ::vcst::_workLib "work"
set ::vcst::_upfOpts " -upf "
set ::vcst::_enableKdb "true"
set ::vcst::_simBinPath "seq_top.exe"
set ::vcst::_goldenUpfConfig {}
set ::vcst::_nldmNschema {false}
set ::vcst::_kdbAlias {false}
set ::vcst::_covDut {}
set ::vcst::_splitbus {false}
set ::vcst::_enableVerdiLog {1}
set ::vcst::_fml_max_proof_depth {-1}
set ::vcst::_smartLoad {false}
set ::vcst::_diucFlow {false}
set ::vcst::_libArgs ""
set ::vcst::_seqXmlFile ""
schSetPreference -turboLibs {} -turboLibPaths {}
verdiSetPrefEnv -bSpecifyWindowTitleForDockContainer off
paSetPreference -brightenPowerColor on
schSetPreference -showPassThroughNet on
paSetPreference -AnnotateSignal off
paSetPreference -highlightPowerObject off
srcAssertSetOpt -addSigToWave 0 -addSigWithExpGrp 1 -maskWave 0 -ShowCycleInfo 1
verdiRunVcst -on
schSetVCSTDelimiter -hierDelim .
srcSetXpropOption "tmerge"
set ::vcst::_powerDbDir ""
set ::vcst::_bRestore ""
verdiDockWidgetFix -dock widgetDock_VCF:GoalList
::vcst::loadMainWin "0"
verdiDockWidgetUnfix -dock widgetDock_VCF:GoalList

setStyleFvProgress -css {font-family:Bitstream Vera Sans monospace;font-size:11px}
setStyleFvGoalProgress -css {font-family:Bitstream Vera Sans monospace;font-size:11px}
verdiSetFont -font "Bitstream Vera Sans" -size "11"
verdiSetPrefEnv -monoFontSize "11"
verdiVcstEnableAppMode -enable FRV

verdiRunVcstCmd "action aaVerdiWaitAnnotation -trigger
" -no_wait
verdiRunVcstCmd "action aaMonetSetReuseWave -data \{[verdiGetRCValue -section appSetting -key reuseWave]\}
" -no_wait
verdiSetStatusMsg -win Verdi_1 -color black { Design import ready }
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "off"
set ::vcst::_bRestore ""
verdiLayoutFreeze -off
verdiToolBar -rm toolbarHB_TOGGLE_PANEL toolbarHB_EMULATION_PANEL toolbarHB_PRODTYPE_PANEL UVM_AWARE_DEBUG AMS_CONFIG_TOOLBAR NOVAS_TBBR_INTERACTIVEVIEW_PANEL NOVAS_TBBR_DEBUG_REWIND_COMMAND NOVAS_TBBR_DEBUG_REWIND_UNDO_REDO_COMMAND NOVAS_TBBR_DEBUG_REVERSE_COMMAND NOVAS_TBBR_DEBUG_VSIM_COMMAND NOVAS_EMULATION_DEBUG_COMMAND CVG_CER_PANEL
verdiSetSeqDebug -xml {/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml}
verdiVcstOnPropSelectionChanged -strNum 0 -propList {}
verdiVcstDesignLoaded
verdiGetVcstCmdResult -xmlstr {<Command name="sim_run" status="1" />}
verdiGetVcstCmdResult -xmlstr {<Command name="sim_save_reset" status="1" />}
report_fv_complexity -silent -sim_save_reset
verdiSetSeqDebug -xml {/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml}
verdiLayoutFreeze -off
::vcst::showDebugViews -1 false false setupSource
verdiWindowMoveDockTab -win Verdi_1 widgetDock_VCF:Shell widgetDock_VCF:GoalList widgetDock_<Message>
verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList

verdiDockWidgetSetCurTab -dock widgetDock_VCF:TaskList
verdiVcstSetAppmode -mode SEQ -fromVcst
verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
srcSetSnipSignal -reset
report_fv_complexity -silent
vcstPropertyDensityShow -silent abstraction
srcSetSnipSignal -file {/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/verdi/snip_signals.list}
report_fv_complexity -silent
vcstPropertyDensityShow -silent abstraction
srcSetBlackbox   -delim {.}
srcSetGlassbox  -delim {.}
srcSetSnipSignal -reset
report_fv_complexity -silent
vcstPropertyDensityShow -silent abstraction
srcSetSnipSignal -file {/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/verdi/snip_signals.list}
report_fv_complexity -silent
vcstPropertyDensityShow -silent abstraction
verdiVcstConstantReport -xmlFile /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/verdi/constant.xml 
verdiVcstSetErrorIdentifier
verdiSetRCValue -section appSetting -key conSize -value {PROPERTY_CLASS,100:PROPERTY_LANGUAGE,138:PROPERTY_NAME,409:PROPERTY_TYPE,100:PROPERTY_USAGE,100:PROPERTY_VACUITY,100:PROPERTY_WITNESS,100:};
schSetPreference -displayAbstractSrc on 
verdiVcstCheckFv -taskName SEQ
vcstRunCovCmd -async gui_vcst_set_parameters -is_running true
verdiSetSeqDebug -xml {/home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/formal/verdiSeqMapping.xml}
receiveFvProgress /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/verdi/gridUsage.xml0
verdiGetVcstCmdResult -xmlstr {<Command name="check_fv" status="1" />}
verdiSetRCValue -section appSetting -key conSize -value {PROPERTY_CLASS,100:PROPERTY_LANGUAGE,122:PROPERTY_NAME,409:PROPERTY_TYPE,100:PROPERTY_USAGE,100:PROPERTY_VACUITY,100:PROPERTY_WITNESS,100:};
verdiVcstCheckFv -taskName SEQ
vcstRunCovCmd -async gui_vcst_set_parameters -is_running false
verdiVcstOnPropSelectionChanged -strNum 1 -propList {_map_output_product}
vcstRunCovCmd -async gui_verdi_drop -id CovSrc.1 -file /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/verdi/tmp_sync_vdcov
srcShowDefine -incrSearch {seq_top.spec.product}; 
verdiVcstOnPropSelectionChanged -strNum 1 -propList {_map_output_product}
vcstRunCovCmd -async gui_verdi_drop -id CovSrc.1 -file /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/verdi/tmp_sync_vdcov
srcShowDefine -incrSearch {seq_top.spec.product}; 
