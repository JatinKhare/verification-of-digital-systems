#!/bin/csh -f
setenv VCS_HOME /usr/local/packages/synopsys_2020/vc_static/Q-2020.03-SP2/vcs-mx
setenv VC_STATIC_HOME /usr/local/packages/synopsys_2020/vc_static/Q-2020.03-SP2
setenv SYNOPSYS_SIM_SETUP /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/synopsys_sim.setup

$VCS_HOME/bin/vlogan  -kdb /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/undef_vcs.v -Xvd_opts=-silent,+disable_message+C00373,-ssy,-ssv,-ssz -file /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/analyzeCmd1 -Xufe=parallel:incrdump  -full64 

$VCS_HOME/bin/vlogan  -kdb /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/undef_vcs.v -Xvd_opts=-silent,+disable_message+C00373,-ssy,-ssv,-ssz -file /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/analyzeCmd2 -Xufe=parallel:incrdump  -full64 

$VCS_HOME/bin/vcs -file /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/.internal/design/elaborateCmd -Xvcstatic_extns=0x4  +warn=noCI-CCE  -kdb -lca  -Xufe=parallel:incrdump  +warn=noKDB-ELAB-E  -Xverdi_elab_opts=-saveLevel  -verdi_opts "-logdir /home/ecelrc/students/jkhare/verif_labs/lab4/run/vcst_rtdb/verdi/elabcomLog " -Xvd_opts=,-ssy,-ssv,-ssz,-silent,+disable_message+C00373, -full64 
