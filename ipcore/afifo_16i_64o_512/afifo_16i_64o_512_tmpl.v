// Generated by IP Generator (Version 2019.1-patch2 build 42169)
// Module Instantiation Template
// Insert the following codes into your Verilog file.
//   * Change <InstanceName> to your own instance name.
//   * Fill in your own signal names in the port connections.

afifo_16i_64o_512 <InstanceName> (
    .wr_clk(),
    .wr_rst(),
    .wr_en(),
    .wr_data(),
    .wr_full(),
    .wr_water_level(),
    .almost_full(),
    .rd_clk(),
    .rd_rst(),
    .rd_en(),
    .rd_data(),
    .rd_empty(),
    .rd_water_level(),
    .almost_empty());
