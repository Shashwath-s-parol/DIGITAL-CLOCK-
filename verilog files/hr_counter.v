module hr_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire hr_tick,
    output reg day_tick,
    output reg [4:0]count
);

    always @(posedge clk or negedge rst_n) 
      begin
        if (!rst_n) 
          begin
            count    <= 5'd0;
            day_tick <= 1'b0;
        end
        else 
          begin
            day_tick <= 1'b0;
            if (hr_tick)
              begin
                if (count == 5'd23)
                  begin
                    count    <= 5'd0;
                    day_tick <= 1'b1;
                end 
                else 
                  begin
                    count <= count + 5'd1;
                end
            end
        end
    end

endmodule