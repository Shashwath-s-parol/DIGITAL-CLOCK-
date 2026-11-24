`include "tick_gen.v"
`include "sec_counter.v"
`include "min_counter.v"
`include "hr_counter.v"
`include "display_ctrl.v"
`include "bcd_to_7seg.v"

module digital_clock_top #(
    parameter integer CLK_FREQ_HZ = 50000000
)(
    input  wire       clk,
    input  wire       rst_n,
    output wire       day_tick,
    output wire [6:0] seg_hr_tens,
    output wire [6:0] seg_hr_ones,
    output wire [6:0] seg_min_tens,
    output wire [6:0] seg_min_ones,
    output wire [6:0] seg_sec_tens,
    output wire [6:0] seg_sec_ones
);

    wire tick_1s;
    wire min_tick;
    wire hr_tick;
  	wire [5:0] sec_count, min_count;
    wire [4:0] hour_count;
  	wire [3:0] hour_tens,hour_ones,min_tens,min_ones,sec_tens,sec_ones;

tick_gen #(
        .CLK_FREQ_HZ (CLK_FREQ_HZ)
    ) u_tick_gen (
        .clk     (clk),
        .rst_n   (rst_n),
        .tick_1s (tick_1s)
    );

    sec_counter u_sec_counter (
        .clk      (clk),
        .rst_n    (rst_n),
        .tick_1s  (tick_1s),
        .min_tick (min_tick),
        .count    (sec_count)
    );

    min_counter u_min_counter (
        .clk      (clk),
        .rst_n    (rst_n),
        .min_tick (min_tick),
        .hr_tick  (hr_tick),
        .count    (min_count)
    );

    hr_counter u_hr_counter (
        .clk      (clk),
        .rst_n    (rst_n),
        .hr_tick  (hr_tick),
        .day_tick (day_tick),
        .count    (hour_count)
    );

    display_ctrl u_display_ctrl (
        .hour_count (hour_count),
        .min_count  (min_count),
        .sec_count  (sec_count),
        .hour_tens  (hour_tens),
        .hour_ones  (hour_ones),
        .min_tens   (min_tens),
        .min_ones   (min_ones),
        .sec_tens   (sec_tens),
        .sec_ones   (sec_ones)
    );

    bcd_to_7seg u_seg_hr_tens  (.bcd(hour_tens), .seg(seg_hr_tens));
    bcd_to_7seg u_seg_hr_ones  (.bcd(hour_ones), .seg(seg_hr_ones));
    bcd_to_7seg u_seg_min_tens (.bcd(min_tens),  .seg(seg_min_tens));
    bcd_to_7seg u_seg_min_ones (.bcd(min_ones),  .seg(seg_min_ones));
    bcd_to_7seg u_seg_sec_tens (.bcd(sec_tens),  .seg(seg_sec_tens));
    bcd_to_7seg u_seg_sec_ones (.bcd(sec_ones),  .seg(seg_sec_ones));

endmodule