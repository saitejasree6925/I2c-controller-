`timescale 1ns/1ps

module i2c_master_tb;

reg clk;
reg rst;
reg start;
reg [6:0] slave_addr;
reg [7:0] data_in;

wire busy;
wire done;
wire scl;

wire sda;

reg sda_slave;

assign sda = sda_slave ? 1'bz : 1'b0;

i2c_master uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .slave_addr(slave_addr),
    .data_in(data_in),
    .busy(busy),
    .done(done),
    .scl(scl),
    .sda(sda)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    start = 0;
    slave_addr = 7'h50;
    data_in = 8'hA5;
    sda_slave = 1;

    #20;
    rst = 0;

    #20;
    start = 1;

    #10;
    start = 0;

    #500;

    $display("I2C Simulation Completed");
    $finish;
end

initial begin
    $dumpfile("i2c.vcd");
    $dumpvars(0, i2c_master_tb);
end

endmodule