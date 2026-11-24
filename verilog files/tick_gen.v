module tick_gen #(
    parameter integer CLK_FREQ_HZ = 50000000
)(
    input  wire clk,
    input  wire rst_n,
    output reg  tick_1s
);

    localparam integer MAX_COUNT = (CLK_FREQ_HZ > 0) ? (CLK_FREQ_HZ - 1) : 0;
    localparam integer CNT_WIDTH = (MAX_COUNT > 0) ? $clog2(MAX_COUNT + 1) : 1;

    reg [CNT_WIDTH-1:0] count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count   <= {CNT_WIDTH{1'b0}};
            tick_1s <= 1'b0;
        end else begin
            if (count == MAX_COUNT[CNT_WIDTH-1:0]) begin
                count   <= {CNT_WIDTH{1'b0}};
                tick_1s <= 1'b1;
            end else begin
                count   <= count + 1'b1;
                tick_1s <= 1'b0;
            end
        end
    end

endmodule