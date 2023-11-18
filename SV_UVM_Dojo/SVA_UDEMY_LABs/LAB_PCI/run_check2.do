
#=======================================
# C R E A T E / S E T  'work' lib
#--------------------------------
alib work
set worklib work

#=======================================
# C O M P I L E
#---------------
alog -sv31a pci_master.v pci_target.v pci_protocol_property.sv test_pci_protocol.sv +define+check2
                                    
#=======================================
# S I M
#------

asim -dbg test_pci_protocol -l test_pci_protocol_check2.log 
run -all
endsim
