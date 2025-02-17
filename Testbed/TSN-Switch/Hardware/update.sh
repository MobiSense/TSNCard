#!/bin/bash
/mnt/c/Windows/System32/cmd.exe /c "vivado -mode batch -source tns_tsn_03.tcl"
rm -rf Work_Dir
mv tns_tsn_03 Work_Dir
