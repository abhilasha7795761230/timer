module timer_counter
      #(
          parameter COUNTER_SIZE  = 8    // counter size
        )(
           input   logic                     clk,
                                             en,
                                             rst,
                                             cnt_mode,
                                             free,
                                             init_cnt,
           input   logic [COUNTER_SIZE-1:0]  min,
           input   logic [COUNTER_SIZE-1:0]  max,
           input   logic [COUNTER_SIZE-1:0]  init,                      
           output  logic [COUNTER_SIZE-1:0]  value,
                   logic                     overflow_set
       );

logic overflow_up;
logic overflow_dwn;
logic up,down,down_p;

assign up   = cnt_mode ==1;
assign down = cnt_mode ==0;


always @(posedge clk or posedge rst)
begin
  if (rst)
      value = 0;
  else if (init_cnt)
      value = init;
  else
  begin
    if (en)
    begin
       if ( (up|free) & ~down )
       begin
          if (~free)
          begin
            if (value < max)
              value = value + 1;
            else if (value >= max)
              value = min;
          end
          else
          begin
             value = value + 1;
          end
       end
       else if ( (down|free) & ~up )
       begin
          if (~free)
          begin
            if (value > min)
              value = value - 1;
            else if (value <= min)
              value = max;
          end
          else
          begin
             value = value - 1;
          end
       end
       else
         value = value;
    end
  end      
end

// as max/min value reached and enabled 
// next cycle count restarts
// overflow set

assign overflow_up_set  = (value == {COUNTER_SIZE{1'b1}}) & en;
assign overflow_dwn_set = (value == {COUNTER_SIZE{1'b0}}) & en;

assign overflow_set =  cnt_mode?overflow_up_set:overflow_dwn_set;

endmodule
