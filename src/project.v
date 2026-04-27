module smart_counter (
    input wire clk,
    input wire reset,
    input wire start,
    input wire up_down,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 4'b0000;
    else begin
        if (start) begin
            if (up_down)
                count <= count + 1;
            else
                count <= count - 1;
        end
    end
end

endmodule

module tt_um_cristhian_counter (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

wire reset = ~rst_n;

// No usamos estos, pero deben existir:
assign uio_out = 8'b0;
assign uio_oe  = 8'b0;

smart_counter counter_inst (
    .clk(clk),
    .reset(reset),
    .start(ui_in[0]),
    .up_down(ui_in[1]),
    .count(uo_out[3:0])
);

assign uo_out[7:4] = 4'b0000;

endmodule
