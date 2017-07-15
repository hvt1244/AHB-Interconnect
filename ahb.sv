module ahb(AHBIF.AHBM bm,AHBIF.AHBS bs,cantintf.tox n);

logic [31:0] DH,DH_d;
logic [31:0] DL,DL_d;
logic [31:0] CMD,CMD_d;
logic [31:0] ID,ID_d;
logic [31:0] ST_BUSY,ST_BUSY_d;
logic [31:0] bm_base;
logic [31:0] bm_status;
logic [31:0] c_addr,c_data,bm_link;
reg [7:0] p_state,n_state;

always@(posedge bs.HCLK)
begin
if(bs.HRESET)begin
    DH_d <= #1 0;
    DL_d <= #1 0;
    CMD_d <=#1 0;
    ID_d <=#1 0;
    ST_BUSY_d <=#1 0;
    p_state <=#1 0;
end

else begin
    DH_d <=#1 DH;
    DL_d <=#1 DL;
    CMD_d <=#1 CMD;
    ID_d <=#1 ID;
    ST_BUSY_d <=#1 ST_BUSY;
    p_state <=#1 n_state;
    end
end

always@(*)begin

n_state=p_state;
DH=DH_d;
DL=DL_d;
CMD= CMD_d;
ID=ID_d;
ST_BUSY=ST_BUSY_d;
    case(p_state)
        5'd0:begin
                bm.mHBUSREQ=1'b0;
                if(bs.HWRITE==1'b1)begin
                case(bs.HADDR[15:0])
                16'hFF00:begin
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                16'hFF14:begin
                            n_state=5'd7;            
                        end        
                16'hFF18:begin
                            n_state=5'd7;            
                        end                
                endcase
                end
            else begin
                n_state=5'd0;
            end
            end
        5'd1:begin
            if(bs.HWRITE==1'b1)begin
//                 DH=bs.HWDATA;
                case(bs.HADDR[15:0])
                16'hFF00:begin
                            DH=bs.HWDATA;
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                endcase
                end
            else begin
                DH=bs.HWDATA;
                n_state=5'd1;
            end
        end
        5'd2:begin
            if(bs.HWRITE==1'b1)begin
//                 DL=bs.HWDATA;
                case(bs.HADDR[15:0])
                16'hFF00:begin
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            DL=bs.HWDATA;
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                endcase
                end
            else begin
                DL=bs.HWDATA;
                n_state=5'd2;
            end 
        end
        5'd3:begin
            if(bs.HWRITE==1'b1)begin
//                 CMD=bs.HWDATA;
                case(bs.HADDR[15:0])
                16'hFF00:begin
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            CMD=bs.HWDATA;
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                endcase
                end
            else begin
                CMD=bs.HWDATA;
                n_state=5'd3;
            end        
        end
        5'd4:begin
            if(bs.HWRITE==1'b1)begin
//                 ID=bs.HWDATA;
                case(bs.HADDR[15:0])
                16'hFF00:begin
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            ID=bs.HWDATA;
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                endcase
                end
            else begin
                ID=bs.HWDATA;
                n_state=5'd4;
            end
        end
        5'd5:begin
                DL = DL_d;
                n.xmitdata={DH,DL};
                CMD = CMD_d;
                ID = ID_d;
                n.id = ID[31:3];
                n.startXmit =1'b1;
                bs.HREADY = 1'b1;
                n.quantaDiv = CMD[31:24];
                n.propQuanta = CMD[23:18];
                n.seg1Quanta = CMD[17:12];
                n.datalen = CMD[11:8];
                n.format = CMD[7];
                n.frameType = CMD[6:5];                                    
                ST_BUSY = {31'b000_0000_0000_0000_0000_0000_0000_0000,n.busy};
                n_state=5'd6;            
            end
         5'd6:begin
            if(bs.HWRITE==1'b0)begin
            case(bs.HADDR[15:0])
            16'hFF00:begin
                            DH = DH_d;
                            DL = DL_d;
                            CMD = CMD_d;
                            ID =ID_d;
                            n.startXmit =1'b0;
                            bs.HREADY =1'b1;
                            bs.HRDATA = DH;
                            n_state=5'd6;
                            end
            16'hFF04:begin
                            DL = DL_d;
                            DH = DH_d;
                            CMD = CMD_d;
                            ID =ID_d;
                            n.startXmit =1'b0;
                            bs.HREADY =1'b1;
                            bs.HRDATA = DL;
                            n_state=5'd6;
                            end
            16'hFF08:begin
                            CMD = CMD_d;
                            DH = DH_d;
                            DL = DL_d;
                            ID =ID_d;
                            n.startXmit =1'b0;
                            bs.HREADY =1'b1;
                            bs.HRDATA = CMD;
                            n_state=5'd6;
                            end
            16'hFF0C:begin
                            ID = ID_d;
                            DH = DH_d;
                            DL = DL_d;
                            CMD = CMD_d;
                            n.startXmit =1'b0;
                            bs.HREADY =1'b1;
                            bs.HRDATA = ID;
                            n_state=5'd6;
                            end
            16'hFF10:begin
                            DH = DH_d;
                            DL = DL_d;
                            CMD = CMD_d;
                            ID = ID_d;
                            n.startXmit =1'b0;
                            bs.HREADY = 1'b1;
                            bs.HRDATA = {31'b000_0000_0000_0000_0000_0000_0000_0000,n.busy};
                            n_state=5'd6;
                            end
            16'hFF14:begin
                            n_state=5'd7;            
                        end                
                        endcase
            end
            else begin
            case(bs.HADDR[15:0])
                16'hFF00:begin
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                16'hFF14:begin
                            n_state=5'd7;            
//                             bm_base=bs.HWDATA;
                        end
                16'hFF18:begin
                            n_state=5'd9;            
                        end
                endcase
            end
         end
        5'd7:begin
//          bm_base=bs.HWDATA;
//          bm.mHADDR=bs.HWDATA;
//             bs.HRDATA=
                bm.mHBUSREQ=1'b0;
            case(bs.HADDR[15:0])
                16'hFF00:begin
                            n_state=5'd1;            
                        end
                16'hFF04:begin
                            n_state=5'd2;            
                        end
                16'hFF08:begin
                            n_state=5'd3;            
                        end
                16'hFF0C:begin
                            n_state=5'd4;            
                        end
                16'hFF10:begin
                            n_state=5'd5;            
                        end
                16'hFF14:begin
                            n_state=5'd7;  ///old 7
                            bm_base=bs.HWDATA;
                        end 
                16'hFF18:begin
                            bm_status={31'b000_0000_0000_0000_0000_0000_0000_0000,1'b1};
//                             bm.mHBUSREQ=1'b1;
                            bs.HRDATA={31'b000_0000_0000_0000_0000_0000_0000_0000,1'b1};
                            n_state=5'd9;            
                        end        
                endcase
        end
        5'd8:begin
//             bm_base=bs.HWDATA;
//             bm_status={31'b000_0000_0000_0000_0000_0000_0000_0000,1'b1};
//             bm.mHADDR=bm_base;
// //             if(bm_base<32'h8000_0000)begin
//                 bm.mHBUSREQ=1'b1;
//                 bm.mHADDR=bm_base;
                n_state=6'd9;
//             end    
//             else begin
//                 bm.mHBUSREQ=1'b0;
                //bm.mHADDR=0;
//                 n_state=5'd7;
//             end
//             bs.HRDATA=bm_status;
            //bm.mHADDR=bm_base;
        end
//         6'd50:begin
//             if(bm.mHGRANT==1'b1)begin
//                 bs.HRDATA=bm_status;
//                 n_state=5'd9;
//             end
//             else begin
//                 n_state=6'd50;
//             end
//         end
        5'd9:begin
//             bm.mHADDR=bm_base;
//             bm.mHTRANS=2'b10;
//             bm.mHWRITE=1'b0;//0
//             n_state=5'd10;
                bm.mHBUSREQ=1'b1;

            if(bm.mHGRANT==1'b1)begin
                bm.mHWRITE=1'b0;
                bm.mHTRANS=2'b10;
//                 bm.mHADDR=c_addr;
                bm.mHADDR=bm_base;
                n_state=5'd10;
            end
            else begin
//                 bm.mHWRITE=1'b0;
                n_state=5'd9;
                bm.mHTRANS=2'b00;
//                 bm.mHADDR=bm_base;
            end
            
        end
        5'd10:begin
        DH=bm.mHRDATA;
        bm.mHWRITE=1'b0;
        n_state=5'd11;
        end
        5'd11:begin
        n_state=5'd12;
        end
        5'd12:begin
        n_state=5'd13;
        bm.mHADDR=bm_base+4'd4;
        end
        
        5'd13:begin
            if(bm.mHGRANT==1'b1)begin
                bm.mHTRANS=2'b10;
//                 bm.mHWRITE=1'b1;
//                 DL=bm.mHRDATA;
                n_state=5'd14;
            end
            else begin
                bm.mHTRANS=2'b00;
//                 bm.mHWRITE=1'b0;
                n_state=5'd13;
            end
        end
        5'd14:begin
        DL=bm.mHRDATA;
        n_state=5'd15;
        end
        5'd15:begin
        n_state=5'd16;
        end
        5'd16:begin
        n_state=5'd17;
        bm.mHADDR=bm_base+4'd8;
        end
        
        5'd17:begin
            if(bm.mHGRANT==1'b1)begin
                bm.mHTRANS=2'b10;
                bm.mHWRITE=1'b0;
//                 CMD=bm.mHRDATA;
                n_state=5'd18;
            end
            else begin
                bm.mHTRANS=2'b00;
            end
        end
        5'd18:begin
        CMD=bm.mHRDATA;
        n_state=5'd19;
        end
        5'd19:begin
        n_state=5'd20;
        end
        5'd20:begin
        n_state=5'd21;
        bm.mHADDR=bm_base+4'hC;
        end
        
        5'd21:begin
            if(bm.mHGRANT==1'b1)begin
                bm.mHTRANS=2'b10;
                bm.mHWRITE=1'b0;
//                 ID=bm.mHRDATA;
                n_state=5'd22;
            end
            else begin
                bm.mHTRANS=2'b00;
            end
        end
        5'd22:begin
        ID=bm.mHRDATA;
        n_state=5'd23;
        end
        5'd23:begin
        n_state=5'd24;
        end
        5'd24:begin
        n_state=5'd25;
        bm.mHADDR=bm_base+8'h10;
        end
        
        5'd25:begin
            if(bm.mHGRANT==1'b1)begin
                bm.mHTRANS=2'b10;
                bm.mHWRITE=1'b0;
                c_addr=bm.mHRDATA;
                n_state=5'd26;
            end
            else begin
                bm.mHTRANS=2'b00;
            end
        end
        5'd26:begin
        n_state=5'd27;
        end
        5'd27:begin
        n_state=5'd28;
        end
        5'd28:begin
        n_state=5'd29;
        bm.mHADDR=bm_base+8'h14;
        end
        
        5'd29:begin
            if(bm.mHGRANT==1'b1)begin
                bm.mHTRANS=2'b10;
                bm.mHWRITE=1'b0;
                c_data=bm.mHRDATA;
                n_state=6'd30;
            end
            else begin
                bm.mHTRANS=2'b00;
            end
        end
        6'd30:begin
        n_state=6'd31;
        end
        6'd31:begin
        n_state=6'd32;
        end
        6'd32:begin
        n_state=6'd33;
        bm.mHADDR=bm_base+8'h18;
        end
        
         6'd33:begin
            if(bm.mHGRANT==1'b1)begin
                bm.mHTRANS=2'b10;
                bm.mHWRITE=1'b0;
                bm_link=bm.mHRDATA;
                n_state=6'd34;
            end
            else begin
                bm.mHTRANS=2'b00;
            end
        end
        6'd34:begin
        n_state=6'd35;
        end
        6'd35:begin
        n_state=6'd36;
        end
        6'd36:begin
        n_state=6'd37;
//        bm.mHADDR=bm_base+8'h18;
        end
        6'd37:begin
                DL = DL_d;
                n.xmitdata={DH,DL};
                CMD = CMD_d;
                ID = ID_d;
                n.id = ID[31:3];
                n.startXmit =1'b1;
                bs.HREADY = 1'b1;
                n.quantaDiv = CMD[31:24];
                n.propQuanta = CMD[23:18];
                n.seg1Quanta = CMD[17:12];
                n.datalen = CMD[11:8];
                n.format = CMD[7];
                n.frameType = CMD[6:5];                                    
                ST_BUSY = {31'b000_0000_0000_0000_0000_0000_0000_0000,n.busy};
                n_state=6'd38;
                bm.mHBUSREQ=1'b0;
//                 bm_base=bm.mHRDATA;
        end
        6'd38:begin/*
            n.startXmit=1'b0;
            bm.mHBUSREQ=1'b0;
            bm_base=bm.mHRDATA;
// //             bm.mHADDR=c_addr;
            if(n.busy==1'b0)begin
//                  bm.mHADDR=c_addr; /// old design
//                 bm_base=bm.mHRDATA;
//                 bm.mHWRITE=1'b1;
                bm.mHWDATA=c_data;
                n_state=6'd39;
            end
            else begin
                n_state=6'd38;
                end
            end*/

            n.startXmit=1'b0;
//              bm.mHBUSREQ=1'b0;
//             bm_base=bm.mHRDATA;
            if(n.busy==1'b0)begin
            bm.mHBUSREQ=1'b1;
//                 bm.mHADDR=c_addr;
//                 bm_base=bm.mHRDATA;
//                 bm.mHWRITE=1'b0;
//                 bm.mHWDATA=c_data;
                n_state=6'd39;
            end
            else begin
                n_state=6'd38;
                end
            end
        6'd39: begin
//                 bm.mHADDR=c_addr; /// old design
//                 bm_base=bm.mHRDATA;
// //                 bm.mHWRITE=1'b1;
                if(bm.mHGRANT==1'b1)begin
//                     bm.mHWDATA=c_data;
                    bm.mHWRITE=1'b1;
                    bm.mHADDR=c_addr;
                    n_state=6'd40;
                end
                else begin
                    n_state=6'd39;
                end
        end
        6'd40:begin
//             bm.mHADDR=bm_base;
//             bm.mHADDR=c_addr;
            bm.mHWRITE=1'b0;
            bm.mHWDATA=c_data;
//             bm.mHBUSREQ=1'b0;
            if(bm_link==32'd0)begin
                bm_base=32'd0;
                bm.mHTRANS=2'b00;
//                 bm.mHBUSREQ=1'b0;
                bm_status=0;
                 bs.HRDATA=0;

                n_state=5'd0;//////old 8
            end
            else begin
                bm.mHTRANS=2'b10;
                bm_base=bm_link;
                n_state=5'd7;
            end
//             if(bm_base==0)
//             begin
//             bm.mHTRANS=2'b00;
//             bm_status=0;
//             bs.HRDATA=0;
//             end
//             else begin
//             bm.mHTRANS=2'b10;
//             end
        end
    endcase 
    end
endmodule
