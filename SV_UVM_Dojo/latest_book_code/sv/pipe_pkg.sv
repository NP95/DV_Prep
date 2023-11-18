//----------------------------------------------------------------------
//   Copyright 2013 Verilab, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------

package pipe_pkg;
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   `include "data_packet.sv"
   `include "pipe_driver.sv"
   `include "pipe_monitor.sv"
   `include "pipe_sequencer.sv"
   `include "pipe_agent.sv"
   `include "pipe_scoreboard.sv"
   `include "pipe_coverage.sv"
   `include "pipe_env.sv"
   `include "dut_env.sv"
   `include "pipe_sequence_lib.sv"
   `include "test_lib.sv"
endpackage: pipe_pkg
