 `include "can_crc0.sv"
 `include "can_crc0_r.sv"
 `include "can_crc1.sv"

module canxmit(cantintf.xmit n);


        reg [3:0] p_state,n_state;
        reg [4:0] frame_length,frame_length_d;
        reg dout_d,busy_d;

        
        reg [82:0] frame_08,frame_08_d;
        reg [74:0] frame_07,frame_07_d;
        reg [66:0] frame_06,frame_06_d;
        reg [58:0] frame_05,frame_05_d;
        reg [50:0] frame_04,frame_04_d;
        reg [42:0] frame_03,frame_03_d;
        reg [34:0] frame_02,frame_02_d;
        reg [26:0] frame_01,frame_01_d;
        reg [18:0] frame_00,frame_00_d;
        
        reg [82:0] crc_frame_08,crc_frame_08_d;
        reg [74:0] crc_frame_07,crc_frame_07_d;
        reg [66:0] crc_frame_06,crc_frame_06_d;
        reg [58:0] crc_frame_05,crc_frame_05_d;
        reg [50:0] crc_frame_04,crc_frame_04_d;
        reg [42:0] crc_frame_03,crc_frame_03_d;
        reg [34:0] crc_frame_02,crc_frame_02_d;
        reg [26:0] crc_frame_01,crc_frame_01_d;
        reg [18:0] crc_frame_00,crc_frame_00_d;
        
        reg [18:0] frame_00_r0,frame_00_r0_d;
        reg [38:0] frame_10_r1,frame_10_r1_d;
////////////////////////////////////////////////////////////////////////////////////
        reg [102:0] frame_18,frame_18_d;
        reg [94:0] frame_17,frame_17_d;
        reg [86:0] frame_16,frame_16_d;
        reg [78:0] frame_15,frame_15_d;
        reg [70:0] frame_14,frame_14_d;
        reg [62:0] frame_13,frame_13_d;
        reg [54:0] frame_12,frame_12_d;
        reg [46:0] frame_11,frame_11_d;
        reg [38:0] frame_10,frame_10_d;
        
        reg [102:0] crc_frame_18,crc_frame_18_d;
        reg [94:0] crc_frame_17,crc_frame_17_d;
        reg [86:0] crc_frame_16,crc_frame_16_d;
        reg [78:0] crc_frame_15,crc_frame_15_d;
        reg [70:0] crc_frame_14,crc_frame_14_d;
        reg [62:0] crc_frame_13,crc_frame_13_d;
        reg [54:0] crc_frame_12,crc_frame_12_d;
        reg [46:0] crc_frame_11,crc_frame_11_d;
        reg [38:0] crc_frame_10,crc_frame_10_d;
//////////////////////////////////////////////////////////////////////////////////////////        

        reg [43:0] final_frame_00,final_frame_00_d;
        reg [51:0] final_frame_01,final_frame_01_d;
        reg [59:0] final_frame_02,final_frame_02_d;
        reg [67:0] final_frame_03,final_frame_03_d;
        reg [75:0] final_frame_04,final_frame_04_d;
        reg [83:0] final_frame_05,final_frame_05_d;
        reg [91:0] final_frame_06,final_frame_06_d;
        reg [99:0] final_frame_07,final_frame_07_d;
        reg [107:0] final_frame_08,final_frame_08_d;
        
        reg [63:0] final_frame_10,final_frame_10_d;
        reg [71:0] final_frame_11,final_frame_11_d;
        reg [79:0] final_frame_12,final_frame_12_d;
        reg [87:0] final_frame_13,final_frame_13_d;
        reg [95:0] final_frame_14,final_frame_14_d;
        reg [103:0] final_frame_15,final_frame_15_d;
        reg [111:0] final_frame_16,final_frame_16_d;
        reg [119:0] final_frame_17,final_frame_17_d;
        reg [127:0] final_frame_18,final_frame_18_d;

        reg [43:0] final_frame_00_r;
        reg [14:0] crc_frame_0,crc_frame_0_r,crc_frame_1;

        reg [10:0] crc_count_00,crc_count_00_d;
        reg [10:0] count_01,count_01_d;
        reg [10:0] count_00,count_00_d;
        reg [10:0] count_wait,count_wait_d;
        reg [10:0] count_frame,count_frame_d;

        reg [3:0] r_datalen,r_datalen_d;
        reg crc_enable0,crc_enable0_r,crc_enable0_d,crc_enable0_r_d;
        reg crc_enable1,crc_enable1_d;
        reg data_in,data_in_d;

        reg[14:0]crc_frame_001,crc_frame_000,crc_frame_001_d,crc_frame_000_d;
        
    can_crc0 crc0(.clk(n.clk),.rst(n.rst),.data_in_0(data_in),.enable(crc_enable0),.crc_frm(crc_frame_0));
    can_crc1 crc1(.clk(n.clk),.rst(n.rst),.data_in_1(data_in),.enable(crc_enable1),.crc_frm(crc_frame_1));
    can_crc0_r crc_r(.clk(n.clk),.rst(n.rst),.data_in_r(data_in),.enable(crc_enable0_r),.crc_frm(crc_frame_0_r));

/////////////////////////////////////////////////////////////////////////////////////////

 always@(posedge n.clk)
 begin
        if(n.rst)
        begin
                p_state <= #1 0;
                count_00_d <= #1 0;
                crc_enable1_d <=#1 0; 
                count_01_d <= #1 0;
                count_wait_d <= #1 0;
                final_frame_00_d <=#1 0;
                final_frame_01_d <=#1 0;
                final_frame_02_d <=#1 0;
                final_frame_03_d <=#1 0;
                final_frame_04_d <=#1 0;
                final_frame_05_d <=#1 0;
                final_frame_06_d <=#1 0;
                final_frame_07_d <=#1 0;
                final_frame_08_d <=#1 0;

                final_frame_10_d <=#1 0;
                final_frame_11_d <=#1 0;
                final_frame_12_d <=#1 0;
                final_frame_13_d <=#1 0;
                final_frame_14_d <=#1 0;
                final_frame_15_d <=#1 0;
                final_frame_16_d <=#1 0;
                final_frame_17_d <=#1 0;
                final_frame_18_d <=#1 0;
                count_frame_d <= #1 0;

                frame_00_r0_d <= #1 0;
                frame_10_r1_d <=#1 0;

                frame_08_d<=#1 0;
                frame_07_d<=#1 0;
                frame_06_d<=#1 0;
                frame_05_d<=#1 0;
                frame_04_d<=#1 0;
                frame_03_d<=#1 0;
                frame_02_d<=#1 0;
                frame_01_d<=#1 0;
                frame_00_d<=#1 0;
                
                frame_18_d<=#1 0;
                frame_17_d<=#1 0;
                frame_16_d<=#1 0;
                frame_15_d<=#1 0;
                frame_14_d<=#1 0;
                frame_13_d<=#1 0;
                frame_12_d<=#1 0;
                frame_11_d<=#1 0;
                frame_10_d<=#1 0;
                
                crc_frame_08_d<=#1 0;
                crc_frame_07_d<=#1 0;
                crc_frame_06_d<=#1 0;
                crc_frame_05_d<=#1 0;
                crc_frame_04_d<=#1 0;
                crc_frame_03_d<=#1 0;
                crc_frame_02_d<=#1 0;
                crc_frame_01_d<=#1 0;
                crc_frame_00_d<=#1 0;
                
                crc_frame_18_d<=#1 0;
                crc_frame_17_d<=#1 0;
                crc_frame_16_d<=#1 0;
                crc_frame_15_d<=#1 0;
                crc_frame_14_d<=#1 0;
                crc_frame_13_d<=#1 0;
                crc_frame_12_d<=#1 0;
                crc_frame_11_d<=#1 0;
                crc_frame_10_d<=#1 0;
                
                crc_frame_000_d<=#1 0;
                crc_frame_001_d<=#1 0;
                
                crc_count_00_d<=#1 0;
                r_datalen_d <=#1 0;
                
                crc_enable0_d <=#1 0;
                crc_enable0_r_d <=#1 0;
                frame_length_d <=#1 0;
                dout_d <=#1 1;
                busy_d <=#1 0;
                data_in_d <= #1 0;
  
                
        end
        else
        begin
                p_state <= #1 n_state;
                count_00_d <= #1 count_00;
                count_01_d <= #1 count_01;
                count_wait_d <=#1 count_wait;
                crc_count_00_d<=#1 crc_count_00;
                data_in_d <= #1 data_in;
                
                final_frame_00_d <=#1 final_frame_00;
                final_frame_01_d <=#1 final_frame_01;
                final_frame_02_d <=#1 final_frame_02;
                final_frame_03_d <=#1 final_frame_03;
                final_frame_04_d <=#1 final_frame_04;
                final_frame_05_d <=#1 final_frame_05;
                final_frame_06_d <=#1 final_frame_06;
                final_frame_07_d <=#1 final_frame_07;
                final_frame_08_d <=#1 final_frame_08;

                final_frame_10_d <=#1 final_frame_10;
                final_frame_11_d <=#1 final_frame_11;
                final_frame_12_d <=#1 final_frame_12;
                final_frame_13_d <=#1 final_frame_13;
                final_frame_14_d <=#1 final_frame_14;
                final_frame_15_d <=#1 final_frame_15;
                final_frame_16_d <=#1 final_frame_16;
                final_frame_17_d <=#1 final_frame_17;
                final_frame_18_d <=#1 final_frame_18;
                frame_00_r0_d <=#1 frame_00_r0;
                frame_10_r1_d <=#1 frame_10_r1;
                
                
                frame_08_d<=#1 frame_08;
                frame_07_d<=#1 frame_07;
                frame_06_d<=#1 frame_06;
                frame_05_d<=#1 frame_05;
                frame_04_d<=#1 frame_04;
                frame_03_d<=#1 frame_03;
                frame_02_d<=#1 frame_02;
                frame_01_d<=#1 frame_01;
                frame_00_d<=#1 frame_00;
                
                crc_frame_00_d <=#1  crc_frame_00;
                crc_frame_01_d <=#1  crc_frame_01;
                crc_frame_02_d <=#1  crc_frame_02;
                crc_frame_03_d <=#1  crc_frame_03;
                crc_frame_04_d <=#1  crc_frame_04;
                crc_frame_05_d <=#1  crc_frame_05;
                crc_frame_06_d <=#1  crc_frame_06;
                crc_frame_07_d <=#1  crc_frame_07;
                crc_frame_08_d <=#1  crc_frame_08;
                
                frame_10_d <= #1 frame_10;
                frame_11_d <= #1 frame_11;
                frame_12_d <= #1 frame_12;
                frame_13_d <= #1 frame_13;
                frame_14_d <= #1 frame_14;
                frame_15_d <= #1 frame_15;
                frame_16_d <= #1 frame_16;
                frame_17_d <= #1 frame_17;
                frame_18_d <= #1 frame_18;

                crc_frame_10_d <=#1  crc_frame_10;
                crc_frame_11_d <=#1  crc_frame_11;
                crc_frame_12_d <=#1  crc_frame_12;
                crc_frame_13_d <=#1  crc_frame_13;
                crc_frame_14_d <=#1  crc_frame_14;
                crc_frame_15_d <=#1  crc_frame_15;
                crc_frame_16_d <=#1  crc_frame_16;
                crc_frame_17_d <=#1  crc_frame_17;
                crc_frame_18_d <=#1  crc_frame_18;

                count_frame_d <=#1 count_frame;
                
                r_datalen_d <=#1 r_datalen;
                crc_enable0_d <=#1 crc_enable0;
                crc_enable1_d <=#1 crc_enable1;
                
                crc_enable0_d <=#1 crc_enable0;
                crc_enable0_r_d <=#1 crc_enable0_r;
                
                frame_length_d <=#1 frame_length;
                dout_d <= #1 n.dout;
                busy_d <=#1 n.busy;
                
                crc_frame_000_d<=#1 crc_frame_000;
                crc_frame_001_d<=#1 crc_frame_001;

        end
 end
 /////////////////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////////////////

always@(*)
begin
n.dout=dout_d;
n.busy=busy_d;
count_00 = count_00_d;
count_01 = count_01_d;
crc_count_00 = crc_count_00_d;

final_frame_00 =final_frame_00_d;
final_frame_01 =final_frame_01_d;
final_frame_02 =final_frame_02_d;
final_frame_03 =final_frame_03_d;
final_frame_04 =final_frame_04_d;
final_frame_05 =final_frame_05_d;
final_frame_06 =final_frame_06_d;
final_frame_07 =final_frame_07_d;
final_frame_08 =final_frame_08_d;

final_frame_10= final_frame_10_d;
final_frame_11= final_frame_11_d;
final_frame_12= final_frame_12_d;
final_frame_13= final_frame_13_d;
final_frame_14= final_frame_14_d;
final_frame_15= final_frame_15_d;
final_frame_16= final_frame_16_d;
final_frame_17= final_frame_17_d;
final_frame_18= final_frame_18_d;

frame_00 =  frame_00_d;
frame_01 =  frame_01_d;
frame_02 =  frame_02_d;
frame_03 =  frame_03_d;
frame_04 =  frame_04_d;
frame_05 =  frame_05_d;
frame_06 =  frame_06_d;
frame_07 =  frame_07_d;
frame_08 =  frame_08_d;


frame_10 =  frame_10_d;
frame_11 =  frame_11_d;
frame_12 =  frame_12_d;
frame_13 =  frame_13_d;
frame_14 =  frame_14_d;
frame_15 =  frame_15_d;
frame_16 =  frame_16_d;
frame_17 =  frame_17_d;
frame_18 =  frame_18_d;

crc_frame_00 =  crc_frame_00_d;
crc_frame_01 =  crc_frame_01_d;
crc_frame_02 =  crc_frame_02_d;
crc_frame_03 =  crc_frame_03_d;
crc_frame_04 =  crc_frame_04_d;
crc_frame_05 =  crc_frame_05_d;
crc_frame_06 =  crc_frame_06_d;
crc_frame_07 =  crc_frame_07_d;
crc_frame_08 =  crc_frame_08_d;

crc_frame_10 =  crc_frame_10_d;
crc_frame_11 =  crc_frame_11_d;
crc_frame_12 =  crc_frame_12_d;
crc_frame_13 =  crc_frame_13_d;
crc_frame_14 =  crc_frame_14_d;
crc_frame_15 =  crc_frame_15_d;
crc_frame_16 =  crc_frame_16_d;
crc_frame_17 =  crc_frame_17_d;
crc_frame_18 =  crc_frame_18_d;

crc_frame_000 = crc_frame_000_d;
crc_frame_001 = crc_frame_001_d;


frame_00_r0 =frame_00_r0_d;
frame_10_r1 =frame_10_r1_d;            

count_wait=count_wait_d;
count_frame=count_frame_d;
n_state =p_state;
crc_enable0=crc_enable0_d;
crc_enable1=crc_enable1_d;
crc_enable0_r=crc_enable0_r_d;
r_datalen =r_datalen_d;

frame_length =frame_length_d;

data_in =data_in_d;

case(p_state)
4'd0:begin
        n.dout=1'b1;
                if(n.startXmit)
                begin
                        n.busy =1'b1;
                        if(n.frameType==0)
                        begin
                        //////////////////////////////////////////////////////////////////////////////////////
                                        if(n.format==0)
										begin
                                                case(n.datalen)
                                                4'd0:begin
                                                                frame_00={1'b0,n.id[28:18],3'b000,n.datalen};
                                                                crc_frame_00={1'b0,n.id[28:18],3'b000,n.datalen};
                                                                crc_count_00=10'd18;
                                                                frame_length =4'd0;
                                                                n_state=5'd15;
                                                        end
                                                4'd1:begin
                                                                frame_01={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:56]};
                                                                crc_frame_01={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:56]};
                                                                crc_count_00=10'd26;
                                                                frame_length =4'd1;
                                                                n_state=5'd15;
                                                        end
                                                4'd2:begin
                                                                frame_02={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:48]};
                                                                crc_frame_02={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:48]};
                                                                crc_count_00=10'd34;
                                                                frame_length =4'd2;
                                                                n_state=5'd15;
                                                        end
                                                4'd3:begin
                                                                frame_03={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:40]};
                                                                crc_frame_03={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:40]};
                                                                crc_count_00=10'd42;
                                                                frame_length =4'd3;
                                                                n_state=5'd15;
                                                        end
                                                4'd4:begin
                                                                frame_04={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:32]};
                                                                crc_frame_04={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:32]};
                                                                crc_count_00=10'd50;
                                                                frame_length =4'd4;
                                                                n_state=5'd15;
                                                        end
                                                4'd5:begin
                                                                frame_05={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:24]};
                                                                crc_frame_05={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:24]};
                                                                crc_count_00=10'd58;
                                                                frame_length =4'd5;
                                                                n_state=5'd15;
                                                        end
                                                4'd6:begin
                                                                frame_06={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:16]};
                                                                crc_frame_06={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:16]};
                                                                crc_count_00=10'd66;
                                                                frame_length =4'd6;
                                                                n_state=5'd15;
                                                    end
                                                4'd7:begin
                                                                frame_07={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:8]};
                                                                crc_frame_07={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata[63:8]};
                                                                crc_count_00=10'd74;
                                                                frame_length =4'd7;
                                                                n_state=5'd15;
                                                        end
                                                4'd8:begin
                                                                frame_08={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata};
                                                                crc_frame_08={1'b0,n.id[28:18],3'b000,n.datalen,n.xmitdata};
                                                                crc_count_00=10'd82;
                                                                frame_length =4'd8;
                                                                n_state=5'd15;
                                                        end
                                                endcase
                                        end

                                        else
                                        begin
                                                case(n.datalen)
                                                4'd0:begin
                                                                frame_10={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen};
                                                                crc_frame_10={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen};
                                                                crc_count_00=10'd38;                                                                
                                                                frame_length =4'd0;
                                                                n_state = 5'd15;
                                                        end
                                                4'd1:begin
                                                                frame_11={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:56]};
                                                                crc_frame_11={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:56]};
                                                                crc_count_00=10'd46;
                                                                frame_length =4'd1;
                                                                n_state = 5'd15;
                                                        end
                                                4'd2:begin
                                                                frame_12={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:48]};
                                                                crc_frame_12={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:48]};
                                                                crc_count_00=10'd54;
                                                                frame_length =4'd2;
                                                                n_state = 5'd15;
                                                        end
                                                4'd3:begin
                                                                frame_13={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:40]};
                                                                crc_frame_13={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:40]};
                                                                crc_count_00=10'd62;
                                                                frame_length =4'd3;
                                                                n_state = 5'd15;
                                                        end
                                                4'd4:begin
                                                                frame_14={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:32]};
                                                                crc_frame_14={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:32]};
                                                                crc_count_00=10'd70;
                                                                frame_length =4'd4;
                                                                n_state = 5'd15;
                                                        end
                                                4'd5:begin
                                                                frame_15={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:24]};
                                                                crc_frame_15={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:24]};
                                                                crc_count_00=10'd78;
                                                                frame_length =4'd5;
                                                                n_state = 5'd15;
                                                        end
                                                4'd6:begin
                                                                frame_16={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:16]};
                                                                crc_frame_16={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:16]};
                                                                crc_count_00=10'd86;
                                                                frame_length =4'd6;
                                                                n_state = 5'd15;
                                                        end
                                                4'd7:begin
                                                                frame_17={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:8]};
                                                                crc_frame_17={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:8]};
                                                                crc_count_00=10'd94;
                                                                frame_length =4'd7;
                                                                n_state = 5'd15;
                                                        end
                                                4'd8:begin
                                                                frame_18={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:0]};
                                                                crc_frame_18={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b000,n.datalen,n.xmitdata[63:0]};
                                                                crc_count_00=10'd102;
                                                                frame_length =4'd8;
                                                                n_state = 5'd15;
                                                        end
                                                endcase
                                        end
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        end
                        else
                        begin//xmitFrameType /// modify for remote frame
                                        if(n.format==0)
                                        begin
                                                    frame_00_r0={1'b0,n.id[28:18],3'b100,n.datalen};
                                                    crc_frame_00={1'b0,n.id[28:18],3'b100,n.datalen};
                                                    crc_count_00=10'd18;
                                                    frame_length =4'd0;
                                                    n_state = 5'd15;
                                            
                                        end

                                        else
                                        begin
                                                    frame_10_r1={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b100,n.datalen};
                                                    crc_frame_10={1'b0,n.id[28:18],2'b10,n.id[17:0],3'b100,n.datalen};
                                                    crc_count_00=10'd38;
                                                    frame_length =4'd0;
                                                    n_state = 5'd15;
                                        end
                        end
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                end
                else//startXmit
                begin
                        n.busy = 1'b0;
                        n_state =1'b0;
                        crc_count_00=crc_count_00_d;
                        frame_length =4'd0;
                end
        end//case 0
4'd15:begin
    if(n.frameType==0 && n.format==0)
    begin
    case(frame_length)
    4'd0:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_00 = crc_frame_00_d;
                    data_in = crc_frame_00[18];
                   // crc_count_00 = crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    //crc_enable0=1'b0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_00 = crc_frame_00_d<<1;
                    data_in = crc_frame_00[18];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_frame_000 = 0;
                    crc_enable0=1'b1;
                    n_state=5'd15;
            end
    end
    4'd1:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_01 = crc_frame_01_d;
                    data_in = crc_frame_01[26];
                   // crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    //crc_enable0=1'b0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_01 = crc_frame_01_d<<1;
                    data_in = crc_frame_01[26];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_frame_000 = 0;
                    crc_enable0=1'b1;
                    n_state=5'd15;
            end
    end
    4'd2:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_02 = crc_frame_02_d;
                    data_in = crc_frame_02[34];
                    //crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_02 = crc_frame_02_d<<1;
                    data_in = crc_frame_02[34];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_frame_000 = 0;
                    crc_enable0=1'b1;
                    n_state=5'd15;
            end
    end
    4'd3:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_03 = crc_frame_03_d;
                    data_in = crc_frame_03[42];
                    //crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_03 = crc_frame_03_d<<1;
                    data_in = crc_frame_03[42];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_frame_000 = 0;
                    crc_enable0=1'b1;
                    n_state=5'd15;
            end
    end
    4'd4:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_04 = crc_frame_04_d;
                    data_in = crc_frame_04[50];
                   // crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_04 = crc_frame_04_d<<1;
                    data_in = crc_frame_04[50];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_enable0=1'b1;
                    crc_frame_000 = 0;
                    n_state=5'd15;
            end
    end
    4'd5:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_05 = crc_frame_05_d;
                    data_in = crc_frame_05[58];
                   // crc_count_00= crc_count_00_d;
                  crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_05 = crc_frame_05_d<<1;
                    data_in = crc_frame_05[58];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_enable0=1'b1;
                    crc_frame_000 = 0;
                    n_state=5'd15;
            end
    end
    4'd6:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_06 = crc_frame_06_d;
                    data_in = crc_frame_06[66];
                  //  crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_06 = crc_frame_06_d<<1;
                    data_in = crc_frame_06[66];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_enable0=1'b1;
                    crc_frame_000 = 0;
                    n_state=5'd15;
            end
    end
    4'd7:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_07 = crc_frame_07_d;
                    data_in = crc_frame_07[74];
                   // crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_07 = crc_frame_07_d<<1;
                    data_in = crc_frame_07[74];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_enable0=1'b1;
                    crc_frame_000 = 0;
                    n_state=5'd15;
            end
    end
    4'd8:
    begin
            if(crc_count_00==0)
            begin
                    crc_frame_08 = crc_frame_08_d;
                    data_in = crc_frame_08[82];
                   // crc_count_00= crc_count_00_d;
                    crc_frame_000 = crc_frame_0;
                    n_state=5'd1;
            end
            else 
            begin
                    crc_frame_08 = crc_frame_08_d<<1;
                    data_in = crc_frame_08[82];
                    crc_count_00= crc_count_00_d-1'b1;
                    crc_enable0=1'b1;
                    crc_frame_000 = 0;
                    n_state=5'd15;
            end
    end
    endcase
    end
    else if(n.frameType==0 && n.format==1)
    begin
        case(frame_length)
        4'd0:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_10 = crc_frame_10_d;
                        data_in = crc_frame_10[38];
                       // crc_count_00= crc_count_00_d;
                        crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_10 = crc_frame_10_d<<1;
                        data_in = crc_frame_10[38];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd1:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_11 = crc_frame_11_d;
                        data_in = crc_frame_11[46];
                        //crc_count_00= crc_count_00_d;
                  crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_11 = crc_frame_11_d<<1;
                        data_in = crc_frame_11[46];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd2:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_12 = crc_frame_12_d;
                        data_in = crc_frame_12[54];
                       // crc_count_00= crc_count_00_d;
                 crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_12 = crc_frame_12_d<<1;
                        data_in = crc_frame_12[54];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        n_state=5'd15;
                        crc_frame_001 = 0;
                end
        end
        4'd3:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_13 = crc_frame_13_d;
                        data_in = crc_frame_13[62];
                        //crc_count_00= crc_count_00_d;
                  crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_13 = crc_frame_13_d<<1;
                        data_in = crc_frame_13[62];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd4:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_14 = crc_frame_14_d;
                        data_in = crc_frame_14[70];
                       // crc_count_00= crc_count_00_d;
                 crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_14 = crc_frame_14_d<<1;
                        data_in = crc_frame_14[70];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd5:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_15 = crc_frame_15_d;
                        data_in = crc_frame_15[78];
                        //crc_count_00= crc_count_00_d;
                   crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_15 = crc_frame_15_d<<1;
                        data_in = crc_frame_15[78];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd6:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_16 = crc_frame_16_d;
                        data_in = crc_frame_16[86];
                      //  crc_count_00= crc_count_00_d;
                 crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_16 = crc_frame_16_d<<1;
                        data_in = crc_frame_16[86];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd7:
         begin
                if(crc_count_00==0)
                begin
                        crc_frame_17 = crc_frame_17_d;
                        data_in = crc_frame_17[94];
                      //  crc_count_00= crc_count_00_d;
                 crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_17 = crc_frame_17_d<<1;
                        data_in = crc_frame_17[94];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        4'd8:
        begin
                if(crc_count_00==0)
                begin
                        crc_frame_18 = crc_frame_18_d;
                        data_in = crc_frame_18[102];
                        //crc_count_00= crc_count_00_d;
                        crc_frame_001 = crc_frame_1;
                        n_state=5'd1;
                end
                else 
                begin
                        crc_frame_18 = crc_frame_18_d<<1;
                        data_in = crc_frame_18[102];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable1=1'b1;
                        crc_frame_001 = 0;
                        n_state=5'd15;
                end
        end
        endcase    
    end
        else if(n.frameType==1 && n.format==1)
        begin 
                if(crc_count_00==0)
                    begin
                            crc_frame_10 = crc_frame_10_d;
                            //data_in = crc_frame_10[38];
                          //  crc_count_00= crc_count_00_d;
                            crc_enable0_r=1'b0;
                            crc_frame_001 = crc_frame_0_r;
                            n_state=5'd1;
                    end
                    else 
                    begin 
                            crc_frame_10 = crc_frame_10_d<<1;
                            data_in = crc_frame_10[38];
                            crc_count_00= crc_count_00_d-1'b1;
                            crc_enable0_r=1'b1;
                            crc_frame_001 = 0;
                            n_state=5'd15;
                    end

        end
        else
        begin 
                if(crc_count_00==0)
                begin
                        crc_frame_00 = crc_frame_00_d;
                        data_in = crc_frame_00[18];
                        crc_enable0_r =1'b0;
                       // crc_count_00= crc_count_00_d;
                        crc_frame_000 = crc_frame_0_r;
                        n_state=5'd1;
                end
                else 
                begin   
                        crc_frame_00 = crc_frame_00_d<<1;
                        data_in = crc_frame_00[18];
                        crc_count_00= crc_count_00_d-1'b1;
                        crc_enable0_r=1'b1;
                        crc_frame_000 = 0;
                        n_state=5'd15;
                end
        
        end
end
4'd1:begin
        crc_enable0=1'b0;
        crc_enable0_r=1'b0;
        crc_enable1=1'b0;
                if(n.frameType==0 && n.format==0)
                begin
                        case(frame_length)
                        4'd0:begin
                                        final_frame_00 = {frame_00,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd44;
                                end
                        4'd1:begin
                                        final_frame_01 = {frame_01,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd52;
                                end
                        4'd2:begin
                                        final_frame_02 = {frame_02,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd60;
                                end
                        4'd3:begin
                                        final_frame_03 = {frame_03,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd68;
                                end
                        4'd4:begin
                                        final_frame_04 = {frame_04,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd76;
                                end
                        4'd5:begin
                                        final_frame_05 = {frame_05,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd84;
                                end
                        4'd6:begin
                                        final_frame_06 = {frame_06,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd92;
                                end
                        4'd7:begin
                                        final_frame_07 = {frame_07,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd100;
                                end
                        4'd8:begin
                                        final_frame_08 = {frame_08,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd108;
                                                                                                 
                   end
                        endcase
                end

                else if(n.frameType==0 && n.format==1)
                begin
                        case(frame_length)
                        4'd0:begin
                                        final_frame_10 = {frame_10,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd64;
                                        n_state = 4'd2;
                                end
                        4'd1:begin
                                        final_frame_11 = {frame_11,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd72;
                                        n_state = 4'd2;
                                end
                        4'd2:begin
                                        final_frame_12 = {frame_12,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd80;
                                        n_state = 4'd2;
                                end
                        4'd3:begin
                                        final_frame_13 = {frame_13,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd88;
                                        n_state = 4'd2;
                                end
                        4'd4:begin
                                        final_frame_14 = {frame_14,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd96;
                                        n_state = 4'd2;
                                end
                        4'd5:begin
                                        final_frame_15 = {frame_15,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd104;
                                        n_state = 4'd2;
                                end
                        4'd6:begin
                                        final_frame_16 = {frame_16,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd112;
                                        n_state = 4'd2;
                                end
                        4'd7:begin
                                        final_frame_17 = {frame_17,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd120; 
                                        n_state = 4'd2;
                                end
                        4'd8:begin
                                        final_frame_18 = {frame_18,crc_frame_001,10'b11_1111_1111};
                                        count_frame=10'd128;
                                        n_state = 4'd2;
                                end
                                                                                    
                        endcase
                end
                else if(n.frameType==1 && n.format==0)///modify this for remote frame
                begin
                                        final_frame_00 = {frame_00_r0,crc_frame_000,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd44;
                end
                                                         
                else
                begin
                                        final_frame_10 = {frame_10_r1,crc_frame_001,10'b11_1111_1111};
                                        n_state = 4'd2;
                                        count_frame=10'd64;
                end
end
4'd2:
begin   
        if(n.format==0)
        begin
        case(frame_length)
        5'd0:begin
					if(final_frame_00[43]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_00= final_frame_00_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_00=final_frame_00_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_00= final_frame_00_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_00=final_frame_00_d<<1;
								end
					end
				end
        5'd1:begin
					if(final_frame_01[51]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_01= final_frame_01_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_01=final_frame_01_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_01= final_frame_01_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_01=final_frame_01_d<<1;
								end
					end
				end
            5'd2:begin
					if(final_frame_02[59]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_02= final_frame_02_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_02=final_frame_02_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_02= final_frame_02_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_02=final_frame_02_d<<1;
								end
					end
				end
				5'd3:begin
					if(final_frame_03[67]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_03= final_frame_03_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_03=final_frame_03_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_03= final_frame_03_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_03=final_frame_03_d<<1;
								end
					end
				end
				5'd4:begin
					if(final_frame_04[75]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_04= final_frame_04_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_04=final_frame_04_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_04= final_frame_04_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_04=final_frame_04_d<<1;
								end
					end
				end
				5'd5:begin
					if(final_frame_05[83]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_05= final_frame_05_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_05=final_frame_05_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_05= final_frame_05_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_05=final_frame_05_d<<1;
								end
					end
				end
				5'd6:begin
					if(final_frame_06[91]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_06= final_frame_06_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_06=final_frame_06_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_06= final_frame_06_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_06=final_frame_06_d<<1;
								end
					end
				end
				5'd7:begin
					if(final_frame_07[99]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_07= final_frame_07_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_07=final_frame_07_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_07= final_frame_07_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_07=final_frame_07_d<<1;
								end
					end
				end
            5'd8:begin
					if(final_frame_08[107]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_08= final_frame_08_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_08=final_frame_08_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_08= final_frame_08_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_08=final_frame_08_d<<1;
								end
					end
				end
        endcase
        end
        else ///// format extended
        begin
        case(frame_length)
        5'd0:begin
					if(final_frame_10[63]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_10= final_frame_10_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_10=final_frame_10_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_10= final_frame_10_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_10=final_frame_10_d<<1;
								end
					end
				end
        5'd1:begin
					if(final_frame_11[71]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_11= final_frame_11_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_11=final_frame_11_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_11= final_frame_11_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_11=final_frame_11_d<<1;
								end
					end
				end
            5'd2:begin
					if(final_frame_12[79]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_12= final_frame_12_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_12=final_frame_12_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_12= final_frame_12_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_12=final_frame_12_d<<1;
								end
					end
				end
				5'd3:begin
					if(final_frame_13[87]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_13= final_frame_13_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_13=final_frame_13_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_13= final_frame_13_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_13=final_frame_13_d<<1;
								end
					end
				end
				5'd4:begin
					if(final_frame_14[95]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_14= final_frame_14_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_14=final_frame_14_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_14= final_frame_14_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_14=final_frame_14_d<<1;
								end
					end
				end
				5'd5:begin
					if(final_frame_15[103]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_15= final_frame_15_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_15=final_frame_15_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_15= final_frame_15_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_15=final_frame_15_d<<1;
								end
					end
				end
				5'd6:begin
					if(final_frame_16[111]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_16= final_frame_16_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_16=final_frame_16_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_16= final_frame_16_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_16=final_frame_16_d<<1;
								end
					end
				end
				5'd7:begin
					if(final_frame_17[119]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_17= final_frame_17_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_17=final_frame_17_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_17= final_frame_17_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_17=final_frame_17_d<<1;
								end
					end
				end
            5'd8:begin
					if(final_frame_18[127]==1)
					begin
								if(count_01>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b0;
									n_state = 4'd3;
									count_wait =0;
									count_00=count_00_d;
									count_frame=count_frame_d;
									count_01 =0;
									final_frame_18= final_frame_18_d;
								end
								else
								begin
									n.dout = 1'b1;
									count_01=count_01_d+1'b1;
									count_00=0;
									n_state =4'd3;
									count_wait =0;
									count_frame=count_frame_d-1'b1;
									final_frame_18=final_frame_18_d<<1;
								end
					end
					else
					begin
								if(count_00>5'd4 && count_frame >4'd10)
								begin
									n.dout = 1'b1;
									n_state =4'd3;
									count_01=0;
									count_00=0;
									count_wait =0;
									count_frame=count_frame_d;
									final_frame_18= final_frame_18_d;
								end
																			
								else
								begin
									n.dout = 1'b0;
									n_state =4'd3;
									count_wait =0;
									count_01=0;
									count_00=count_00_d+1'b1;
									count_frame=count_frame_d-1'b1;
									final_frame_18=final_frame_18_d<<1;
								end
					end
				end
        endcase
        end

end
4'd3:begin
        count_wait=count_wait_d+1'b1;
        
		if(count_wait==(n.quantaDiv*(1+n.seg1Quanta+n.seg1Quanta+n.propQuanta))-1'b1)
        begin
// 		n_state=4'd2;
            if(count_frame==0)
            begin
                n_state=4'd0;
                count_frame=0;
            end
            else 
            begin
                n_state=4'd2;
                count_frame=count_frame_d;
            end
        end
        else begin
            n_state =4'd3;
        end
    end
4'd4:begin
    n.busy=1'b0;
    end
endcase

//////////////////////////////////////////////////////////////////////////////////////////////////////
end
 /////////////////////////////////////////////////////////////////////////////////////////

endmodule
                                                                     															
                                                                     															
                                                                                                                                                                               
