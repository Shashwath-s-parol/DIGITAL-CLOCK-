module min_counter (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       min_tick,
    output reg        hr_tick,
    output reg  [5:0] count
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
          begin
            count   <= 6'd0;
            hr_tick <= 1'b0;
        end 
      else 
        begin
            hr_tick <= 1'b0;
            if (min_tick)
              begin
                if (count == 6'd59)
                  begin
                    count   <= 6'd0;
                    hr_tick <= 1'b1;
                end 
                else 
                  begin
                    count <= count + 6'd1;
                end
            end
        end
    end

endmodule