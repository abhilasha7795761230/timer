`SHOWM(DOWN counter mode);

reg_read(`TIMER_CTRL_ADDR);
//reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_write(`TIMER_CNT_MAX_ADDR,8'hAA);
reg_write(`TIMER_CNT_INIT_ADDR,8'hAA);
reg_write(`TIMER_CNT_MIN_ADDR,8'h2A);
reg_write(`TIMER_CTRL_ADDR,8'h02);
reg_write(`TIMER_CTRL_ADDR,8'h03);
delay(1000);
