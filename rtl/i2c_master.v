module i2c_master (
    input  wire       clk,
    input  wire       rst,
    input  wire       start,
    input  wire [6:0] slave_addr,
    input  wire [7:0] data_in,
    output reg        busy,
    output reg        done,
    output reg        scl,
    inout  wire       sda
);

reg sda_out;
reg sda_oe;
reg [7:0] data_reg;
reg [6:0] addr_reg;
reg [3:0] bit_count;

reg [3:0] state;

localparam IDLE      = 4'd0,
           START     = 4'd1,
           ADDR      = 4'd2,
           ADDR_ACK  = 4'd3,
           DATA      = 4'd4,
           DATA_ACK  = 4'd5,
           STOP      = 4'd6,
           DONE      = 4'd7;

assign sda = sda_oe ? sda_out : 1'bz;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        busy      <= 1'b0;
        done      <= 1'b0;
        scl       <= 1'b1;
        sda_out   <= 1'b1;
        sda_oe    <= 1'b1;
        data_reg  <= 8'b0;
        addr_reg  <= 7'b0;
        bit_count <= 4'd0;
        state     <= IDLE;
    end
    else begin
        done <= 1'b0;

        case (state)

            IDLE: begin
                scl     <= 1'b1;
                sda_out <= 1'b1;
                busy    <= 1'b0;

                if (start) begin
                    busy     <= 1'b1;
                    addr_reg <= slave_addr;
                    data_reg <= data_in;
                    state    <= START;
                end
            end

            START: begin
                sda_out   <= 1'b0;
                scl       <= 1'b1;
                bit_count <= 4'd6;
                state     <= ADDR;
            end

            ADDR: begin
                scl     <= 1'b0;
                sda_out <= addr_reg[bit_count];
                scl     <= 1'b1;

                if (bit_count == 0)
                    state <= ADDR_ACK;
                else
                    bit_count <= bit_count - 1'b1;
            end

            ADDR_ACK: begin
                scl     <= 1'b0;
                sda_oe  <= 1'b0;
                scl     <= 1'b1;
                sda_oe  <= 1'b1;

                bit_count <= 4'd7;
                state <= DATA;
            end

            DATA: begin
                scl     <= 1'b0;
                sda_out <= data_reg[bit_count];
                scl     <= 1'b1;

                if (bit_count == 0)
                    state <= DATA_ACK;
                else
                    bit_count <= bit_count - 1'b1;
            end

            DATA_ACK: begin
                scl     <= 1'b0;
                sda_oe  <= 1'b0;
                scl     <= 1'b1;
                sda_oe  <= 1'b1;
                state   <= STOP;
            end

            STOP: begin
                scl     <= 1'b1;
                sda_out <= 1'b1;
                state   <= DONE;
            end

            DONE: begin
                busy  <= 1'b0;
                done  <= 1'b1;
                state <= IDLE;
            end

            default: state <= IDLE;

        endcase
    end
end

endmodule