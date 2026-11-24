module display_ctrl (
    input  wire [4:0] hour_count,
    input  wire [5:0] min_count,
    input  wire [5:0] sec_count,
    output reg  [3:0] hour_tens, hour_ones, min_tens,min_ones,sec_tens, sec_ones
);

    always @(*) begin
        hour_tens = 4'd0;
        hour_ones = 4'd0;
        min_tens  = 4'd0;
        min_ones  = 4'd0;
        sec_tens  = 4'd0;
        sec_ones  = 4'd0;

        if (hour_count < 5'd10) begin
            hour_tens = 4'd0;
            hour_ones = hour_count[3:0];
        end else if (hour_count < 5'd20) begin
            hour_tens = 4'd1;
            hour_ones = hour_count - 5'd10;
        end else begin
            hour_tens = 4'd2;
            hour_ones = hour_count - 5'd20;
        end

        if (min_count < 6'd10) begin
            min_tens = 4'd0;
            min_ones = min_count[3:0];
        end else if (min_count < 6'd20) begin
            min_tens = 4'd1;
            min_ones = min_count - 6'd10;
        end else if (min_count < 6'd30) begin
            min_tens = 4'd2;
            min_ones = min_count - 6'd20;
        end else if (min_count < 6'd40) begin
            min_tens = 4'd3;
            min_ones = min_count - 6'd30;
        end else if (min_count < 6'd50) begin
            min_tens = 4'd4;
            min_ones = min_count - 6'd40;
        end else begin
            min_tens = 4'd5;
            min_ones = min_count - 6'd50;
        end

        if (sec_count < 6'd10) begin
            sec_tens = 4'd0;
            sec_ones = sec_count[3:0];
        end else if (sec_count < 6'd20) begin
            sec_tens = 4'd1;
            sec_ones = sec_count - 6'd10;
        end else if (sec_count < 6'd30) begin
            sec_tens = 4'd2;
            sec_ones = sec_count - 6'd20;
        end else if (sec_count < 6'd40) begin
            sec_tens = 4'd3;
            sec_ones = sec_count - 6'd30;
        end else if (sec_count < 6'd50) begin
            sec_tens = 4'd4;
            sec_ones = sec_count - 6'd40;
        end else begin
            sec_tens = 4'd5;
            sec_ones = sec_count - 6'd50;
        end
    end

endmodule