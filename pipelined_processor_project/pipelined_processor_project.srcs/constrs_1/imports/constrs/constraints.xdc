# Clock constraint
create_clock -period 10.000 -name sys_clk [get_ports clk]

# Physical constraints for xa7s15csga196-1L
# Note: Package CSGA196 ke pins

set_property PACKAGE_PIN A1 [get_ports clk]
set_property PACKAGE_PIN A2 [get_ports rst]
set_property PACKAGE_PIN B1 [get_ports {led[0]}]
set_property PACKAGE_PIN B2 [get_ports {led[1]}]
set_property PACKAGE_PIN C1 [get_ports {led[2]}]
set_property PACKAGE_PIN C2 [get_ports {led[3]}]
set_property PACKAGE_PIN D1 [get_ports {led[4]}]
set_property PACKAGE_PIN D2 [get_ports {led[5]}]
set_property PACKAGE_PIN E1 [get_ports {led[6]}]
set_property PACKAGE_PIN E2 [get_ports {led[7]}]
set_property PACKAGE_PIN F1 [get_ports halt_flag]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports halt_flag]