`timescale 1ns/10ps
module can_crc1 (clk, rst, data_in_1,enable,crc_frm);
input clk;
input rst;
input data_in_1;
input enable;
output reg [14:0] crc_frm;
reg [14:0]crc_frm_d;
logic crc_tmp;

always@(posedge clk)
	begin
	if(rst)begin
		crc_frm<= #1 0;
	end
	else begin
        if(enable)
            crc_frm<=#1 crc_frm_d;
		else
            crc_frm <=#1 0;
	end
end
always @ (*)
begin
    crc_frm_d=crc_frm;

    if (enable)
    begin
        crc_frm_d = ((crc_frm[14]^data_in_1)?(crc_frm<<1)^15'h4599:(crc_frm<<1));
    end
	
    else begin
        crc_frm_d =crc_frm;
    end

end
endmodule 
