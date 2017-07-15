module arbitrator(AHBIF.AHBMa bma0, AHBIF.AHBSa bsa0,
                  AHBIF.AHBMa bma1, AHBIF.AHBSa bsa1,
                  AHBIF.AHBMa bma2, AHBIF.AHBSa bsa2,
                  AHBIF.AHBMa bma3, AHBIF.AHBSa bsa3,
                  AHBIF.AHBMa bma4, AHBIF.AHBSa bsa4,
                  AHBIF.AHBMa bma5, AHBIF.AHBSa bsa5,
                  AHBIF.AHBMa bma6, AHBIF.AHBSa bsa6,
                  AHBIF.AHBMa bma7, AHBIF.AHBSa bsa7,
                  AHBIF.AHBMa atb_ma, AHBIF.AHBSa atb_sa);

reg [3:0] p_state,n_state;                  
reg [7:0] bus_req,bus_req_d;
    always@(posedge atb_ma.HCLK)
    begin
        if(atb_ma.HRESET)begin
            bus_req_d <= #1 8'd0;
            p_state <= #1 1;
        end
        else begin
            bus_req_d=bus_req;     
            p_state <= #1 n_state;
        end
    end
    always@(*)begin
    case(atb_ma.mHADDR[31:16])
                16'hF000 :begin
                            bsa0.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa0.HADDR;
                            bsa0.HWDATA=atb_ma.mHWDATA;
                            bsa0.HTRANS=atb_ma.mHTRANS;
                            bsa0.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa0.HRDATA;
//                             bma0.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
                16'hF001 :begin
                            bsa1.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa1.HADDR;
                            bsa1.HWDATA=atb_ma.mHWDATA;
                            bsa1.HTRANS=atb_ma.mHTRANS;
                            bsa1.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa1.HRDATA;
//                             bma1.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
                16'hF002 :begin
                            bsa2.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa2.HADDR;
                            bsa2.HWDATA=atb_ma.mHWDATA;
                            bsa2.HTRANS=atb_ma.mHTRANS;
                            bsa2.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa2.HRDATA;
//                             bma2.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
                16'hF003 :begin
                            bsa3.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa3.HADDR;
                            bsa3.HWDATA=atb_ma.mHWDATA;
                            bsa3.HTRANS=atb_ma.mHTRANS;
                            bsa3.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa3.HRDATA;
                            //bma3.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
                16'hF004 :begin
                            bsa4.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa4.HADDR;
                            bsa4.HWDATA=atb_ma.mHWDATA;
                            bsa4.HTRANS=atb_ma.mHTRANS;
                            bsa4.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa4.HRDATA;
//                             bma4.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
                16'hF005 :begin
                            bsa5.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa5.HADDR;
                            bsa5.HWDATA=atb_ma.mHWDATA;
                            bsa5.HTRANS=atb_ma.mHTRANS;
                            bsa5.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa5.HRDATA;
//                             bma5.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
                16'hF006 :begin
                            bsa6.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa6.HADDR;
                            bsa6.HWDATA=atb_ma.mHWDATA;
                            bsa6.HTRANS=atb_ma.mHTRANS;
                            bsa6.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa6.HRDATA;
//                             bma6.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end    
                16'hF007 :begin
                            bsa7.HADDR=atb_ma.mHADDR;
//                             atb_sa.HADDR=bsa0.HADDR;
                            bsa7.HWDATA=atb_ma.mHWDATA;
                            bsa7.HTRANS=atb_ma.mHTRANS;
                            bsa7.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa7.HRDATA;
//                             bma7.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b1;
//                             n_state=4'd0;
                        end
            endcase
    end
    
    always@(*)begin 
    n_state=p_state;
    bus_req={bma7.mHBUSREQ,bma6.mHBUSREQ,bma5.mHBUSREQ,bma4.mHBUSREQ,bma3.mHBUSREQ,bma2.mHBUSREQ,bma1.mHBUSREQ,bma0.mHBUSREQ};
        
    case(p_state)
//     4'd0:begin
//         if(bus_req==8'b0000_0000)begin
// //         case(atb_ma.mHADDR[31:16])
// //                 16'hF000 :begin
// //                             bsa0.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa0.HADDR;
// //                             bsa0.HWDATA=atb_ma.mHWDATA;
// //                             bsa0.HTRANS=atb_ma.mHTRANS;
// //                             bsa0.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa0.HRDATA;
// // //                             bma0.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //                 16'hF001 :begin
// //                             bsa1.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa1.HADDR;
// //                             bsa1.HWDATA=atb_ma.mHWDATA;
// //                             bsa1.HTRANS=atb_ma.mHTRANS;
// //                             bsa1.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa1.HRDATA;
// // //                             bma1.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //                 16'hF002 :begin
// //                             bsa2.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa2.HADDR;
// //                             bsa2.HWDATA=atb_ma.mHWDATA;
// //                             bsa2.HTRANS=atb_ma.mHTRANS;
// //                             bsa2.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa2.HRDATA;
// // //                             bma2.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //                 16'hF003 :begin
// //                             bsa3.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa3.HADDR;
// //                             bsa3.HWDATA=atb_ma.mHWDATA;
// //                             bsa3.HTRANS=atb_ma.mHTRANS;
// //                             bsa3.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa3.HRDATA;
// //                             //bma3.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //                 16'hF004 :begin
// //                             bsa4.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa4.HADDR;
// //                             bsa4.HWDATA=atb_ma.mHWDATA;
// //                             bsa4.HTRANS=atb_ma.mHTRANS;
// //                             bsa4.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa4.HRDATA;
// // //                             bma4.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //                 16'hF005 :begin
// //                             bsa5.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa5.HADDR;
// //                             bsa5.HWDATA=atb_ma.mHWDATA;
// //                             bsa5.HTRANS=atb_ma.mHTRANS;
// //                             bsa5.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa5.HRDATA;
// // //                             bma5.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //                 16'hF006 :begin
// //                             bsa6.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa6.HADDR;
// //                             bsa6.HWDATA=atb_ma.mHWDATA;
// //                             bsa6.HTRANS=atb_ma.mHTRANS;
// //                             bsa6.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa6.HRDATA;
// // //                             bma6.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end    
// //                 16'hF007 :begin
// //                             bsa7.HADDR=atb_ma.mHADDR;
// // //                             atb_sa.HADDR=bsa0.HADDR;
// //                             bsa7.HWDATA=atb_ma.mHWDATA;
// //                             bsa7.HTRANS=atb_ma.mHTRANS;
// //                             bsa7.HWRITE=atb_ma.mHWRITE;
// //                             atb_ma.mHRDATA=bsa7.HRDATA;
// // //                             bma7.mHGRANT=1'b0;
// //                             atb_sa.HSEL=1'b1;
// //                             n_state=4'd0;
// //                         end
// //             endcase
//                     n_state=1'b0;
//             end
//             else begin
//                 case(atb_ma.mHADDR[31:16])
//                 16'hF000:atb_ma.mHRDATA=bsa0.HRDATA;
//                 16'hF001:atb_ma.mHRDATA=bsa1.HRDATA;
//                 16'hF002:atb_ma.mHRDATA=bsa2.HRDATA;
//                 16'hF003:atb_ma.mHRDATA=bsa3.HRDATA;
//                 16'hF004:atb_ma.mHRDATA=bsa4.HRDATA;
//                 16'hF005:atb_ma.mHRDATA=bsa5.HRDATA;
//                 16'hF006:atb_ma.mHRDATA=bsa6.HRDATA;
//                 16'hF007:atb_ma.mHRDATA=bsa7.HRDATA;
//                 endcase
//                 n_state=4'd1;
//             end
//         end
    4'd1:begin    
            if(bus_req[0]==1'b1)begin
                            bma0.mHGRANT=1'b1;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            ///
                            bsa0.HSEL=1'b1;
                                    atb_sa.HADDR=bma0.mHADDR;
                                    atb_sa.HWRITE=bma0.mHWRITE;
                                    atb_sa.HTRANS=bma0.mHTRANS;
                                    bma0.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma0.mHWDATA;
                                    bsa0.HWDATA=atb_ma.mHWDATA;                           
                            

//                             end
                            n_state=4'd1;
            end
            else begin
                                  bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                                n_state=4'd2;
            end
        end    
    4'd2:begin        
          if(bus_req[1]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b1;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            bsa1.HSEL=1'b1;
                             atb_sa.HADDR=bma1.mHADDR;
                                    atb_sa.HWRITE=bma1.mHWRITE;
                                    atb_sa.HTRANS=bma1.mHTRANS;
                                    bma1.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma1.mHWDATA;
                                    bsa1.HWDATA=atb_ma.mHWDATA;  
                            n_state=4'd2;
                        end
            else begin
                            n_state=4'd3;
            end
        end
    4'd3:begin        
          if(bus_req[2]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b1;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
//                             bus_req[3]=1'b0;
//                             atb_sa.HSEL=1'b1;
                            bsa2.HSEL=1'b1;
                             atb_sa.HADDR=bma2.mHADDR;
                                    atb_sa.HWRITE=bma2.mHWRITE;
                                    atb_sa.HTRANS=bma2.mHTRANS;
                                    bma2.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma2.mHWDATA;
                                    bsa2.HWDATA=atb_ma.mHWDATA;  
//                             bsa3.HSEL=1'b1;
                            
                            
                            n_state=4'd3;
                        end
            else begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd4;
            end
        end
    4'd4:begin        
          if(bus_req[3]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b1;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd4;
                             bsa3.HSEL=1'b1;
//                             if(atb_ma.mHADDR[31:16]==16'hF003)begin
//                             bsa3.HADDR=atb_ma.mHADDR;
                                    atb_sa.HADDR=bma3.mHADDR;
                                    atb_sa.HWRITE=bma3.mHWRITE;
                                    atb_sa.HTRANS=bma3.mHTRANS;
                                    bma3.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma3.mHWDATA;
                                    bsa3.HWDATA=atb_ma.mHWDATA;                            
                            

//                             end
                        end
            else begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd5;
            end
        end    
    4'd5:begin        
          if(bus_req[4]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b1;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            bsa4.HSEL=1'b1;
                              atb_sa.HADDR=bma4.mHADDR;
                                    atb_sa.HWRITE=bma4.mHWRITE;
                                    atb_sa.HTRANS=bma4.mHTRANS;
                                    bma4.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma4.mHWDATA;
                                    bsa4.HWDATA=atb_ma.mHWDATA;  
                            n_state=4'd5;
                        end
            else begin
                              bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd6;
            end
        end
    4'd6:begin        
          if(bus_req[5]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b1;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            bsa5.HSEL=1'b1;
                             atb_sa.HADDR=bma5.mHADDR;
                                    atb_sa.HWRITE=bma5.mHWRITE;
                                    atb_sa.HTRANS=bma5.mHTRANS;
                                    bma5.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma5.mHWDATA;
                                    bsa5.HWDATA=atb_ma.mHWDATA;  
                            n_state=4'd6;
                        end
            else begin
                              bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd7;
                            
            end
        end
    4'd7:begin        
          if(bus_req[6]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b1;
                            bma7.mHGRANT=1'b0;
                            bsa6.HSEL=1'b1;
                             atb_sa.HADDR=bma6.mHADDR;
                                    atb_sa.HWRITE=bma6.mHWRITE;
                                    atb_sa.HTRANS=bma6.mHTRANS;
                                    bma6.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma6.mHWDATA;
                                    bsa6.HWDATA=atb_ma.mHWDATA;  
                            n_state=4'd7;
                        end
            else begin
                              bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd8;
            end
        end    
    4'd8:begin        
          if(bus_req[7]==1'b1)begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b1;
                            bsa7.HSEL=1'b1;
                             atb_sa.HADDR=bma7.mHADDR;
                                    atb_sa.HWRITE=bma7.mHWRITE;
                                    atb_sa.HTRANS=bma7.mHTRANS;
                                    bma7.mHRDATA=atb_sa.HRDATA;
//                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma7.mHWDATA;
                                    bsa7.HWDATA=atb_ma.mHWDATA;  
                            n_state=4'd8;
                        end
            else begin
                            bma0.mHGRANT=1'b0;
                            bma1.mHGRANT=1'b0;
                            bma2.mHGRANT=1'b0;
                            bma3.mHGRANT=1'b0;
                            bma4.mHGRANT=1'b0;
                            bma5.mHGRANT=1'b0;
                            bma6.mHGRANT=1'b0;
                            bma7.mHGRANT=1'b0;
                            n_state=4'd1;
            end
        end
        ///////
         endcase   
//          end
    end/*
    always@(*)begin
    bus_req={bma7.mHBUSREQ,bma6.mHBUSREQ,bma5.mHBUSREQ,bma4.mHBUSREQ,bma3.mHBUSREQ,bma2.mHBUSREQ,bma1.mHBUSREQ,bma0.mHBUSREQ};
        casex(bus_req)
        8'bxxxx_xxx1:begin
                            bsa0.HSEL=1'b1;
                            if(atb_ma.mHADDR[31:16]==16'hF000)begin
                                bsa0.HADDR=atb_ma.mHADDR;
                            end
                            else begin
                                n_state=4'd1;
                            end
                            atb_sa.HADDR=bma0.mHADDR;
                            
//                             bsa0.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HWRITE=bma0.mHWRITE;
                            
                            atb_sa.HTRANS=bma0.mHTRANS;
                            bma0.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa0.HRDATA;
                            
                            atb_sa.HWDATA=bma0.mHWDATA;// doubt
                            bsa0.HWDATA=atb_ma.mHWDATA;
                          
                        end
            8'bxxxx_xx10:begin
                          
                            bsa1.HSEL=1'b1;// new
                            
                            bsa1.HADDR=atb_ma.mHADDR;
//                             bsa1.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HADDR=bma1.mHADDR;
                            atb_sa.HWRITE=bma1.mHWRITE;
                            atb_sa.HTRANS=bma1.mHTRANS;
                            bma1.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa1.HRDATA;
                            
                            atb_sa.HWDATA=bma1.mHWDATA;
                            bsa1.HWDATA=atb_ma.mHWDATA;
                          
                        end
            8'bxxxx_x100:begin
                            
                            atb_sa.HSEL=1'b1;
                            bsa2.HSEL=1'b1;
                            
                            bsa2.HADDR=atb_ma.mHADDR;
//                             bsa2.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HADDR=bma2.mHADDR;
                            atb_sa.HWRITE=bma2.mHWRITE;
                            atb_sa.HTRANS=bma2.mHTRANS;
                            bma2.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa2.HRDATA;
                            
                            atb_sa.HWDATA=bma2.mHWDATA;
                            bsa2.HWDATA=atb_ma.mHWDATA;
                            
                        end
            8'bxxxx_1000:begin
                            
                            atb_sa.HSEL=1'b1;
//                             bsa3.HSEL=1'b1;
                            
                            if(atb_ma.mHADDR[31:16]==16'hF003)begin
//                             bsa3.HADDR=atb_ma.mHADDR;
                                    atb_sa.HADDR=bma3.mHADDR;
                                    atb_sa.HWRITE=bma3.mHWRITE;
                                    atb_sa.HTRANS=bma3.mHTRANS;
                                    bma3.mHRDATA=atb_sa.HRDATA;
                                    atb_ma.mHRDATA=bsa3.HRDATA;
                                    
                                    atb_sa.HWDATA=bma3.mHWDATA;
                                    bsa3.HWDATA=atb_ma.mHWDATA;                            
                            

                            end
//                             else begin
//                                 n_state=4'd1;
//                             end

                            
//                             bsa3.HADDR=atb_ma.mHADDR;
//                             bsa3.HWRITE=atb_ma.mHWRITE;
//                             atb_sa.HADDR=bma3.mHADDR;
//                             atb_sa.HWRITE=bma3.mHWRITE;
//                             atb_sa.HTRANS=bma3.mHTRANS;
//                             bma3.mHRDATA=atb_sa.HRDATA;
//                             atb_ma.mHRDATA=bsa3.HRDATA;
//                             
//                             atb_sa.HWDATA=bma3.mHWDATA;
//                             bsa3.HWDATA=atb_ma.mHWDATA;                            
//                             n_state=4'd1;
                        end
            8'bxxx1_0000:begin
                            
                            atb_sa.HSEL=1'b1;
                            bsa4.HSEL=1'b1;
                            
                            bsa4.HADDR=atb_ma.mHADDR;
//                             bsa4.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HADDR=bma4.mHADDR;
                            atb_sa.HWRITE=bma4.mHWRITE;
                            atb_sa.HTRANS=bma4.mHTRANS;
                            bma4.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa4.HRDATA;
                            
                            atb_sa.HWDATA=bma4.mHWDATA;
                            bsa4.HWDATA=atb_ma.mHWDATA;                            
                            
                        end
            8'bxx10_0000:begin
                            
                            atb_sa.HSEL=1'b1;
                            bsa5.HSEL=1'b1;
                            
                            bsa5.HADDR=atb_ma.mHADDR;
//                             bsa5.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HADDR=bma5.mHADDR;
                            atb_sa.HWRITE=bma5.mHWRITE;
                            atb_sa.HTRANS=bma5.mHTRANS;
                            bma5.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa5.HRDATA;
                            
                            atb_sa.HWDATA=bma5.mHWDATA;
                            bsa5.HWDATA=atb_ma.mHWDATA;
                            
                        end
            8'bx100_0000:begin
                            
                            
                            atb_sa.HSEL=1'b1;
                            bsa6.HSEL=1'b1;
                            
                            bsa6.HADDR=atb_ma.mHADDR;
//                             bsa6.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HADDR=bma6.mHADDR;
                            atb_sa.HWRITE=bma6.mHWRITE;
                            atb_sa.HTRANS=bma6.mHTRANS;
                            bma6.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa6.HRDATA;
                            
                            atb_sa.HWDATA=bma6.mHWDATA;
                            bsa6.HWDATA=atb_ma.mHWDATA;
                            
                        end
            8'b1000_0000:begin
                            
                            
                            atb_sa.HSEL=1'b1;
                            bsa7.HSEL=1'b1;
                            
                            bsa7.HADDR=atb_ma.mHADDR;
//                             bsa7.HWRITE=atb_ma.mHWRITE;
                            atb_sa.HADDR=bma7.mHADDR;
                            atb_sa.HWRITE=bma7.mHWRITE;
                            atb_sa.HTRANS=bma7.mHTRANS;
                            bma7.mHRDATA=atb_sa.HRDATA;
                            atb_ma.mHRDATA=bsa7.HRDATA;
                            
                            atb_sa.HWDATA=bma7.mHWDATA;
                            bsa7.HWDATA=atb_ma.mHWDATA;
                            
                        end
            default:begin
//                         atb_sa.HSEL=1'b0;
                        bsa0.HSEL=1'b1;
                        bsa1.HSEL=1'b0;
                        bsa2.HSEL=1'b1;
                        bsa3.HSEL=1'b0;
                        bsa4.HSEL=1'b1;
                        bsa5.HSEL=1'b1;
                        bsa6.HSEL=1'b1;
                        bsa7.HSEL=1'b1;
                    end
                        
            endcase
            
    end*/
        /*if(bma0.mHBUSREQ || bma1.mHBUSREQ || bma2.mHBUSREQ || bma3.mHBUSREQ
        || bma4.mHBUSREQ || bma5.mHBUSREQ || bma6.mHBUSREQ || bma7.mHBUSREQ)begin
            if(bma0.mHBUSREQ)begin
                bma0.mHGRANT=1'b1;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                
                atb_sa.HSEL=1'b0;
                bsa0.HADDR=atb_ma.mHADDR;
                bsa0.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma0.mHADDR;
                atb_sa.HWRITE=bma0.mHWRITE;
                atb_sa.HTRANS=bma0.mHTRANS;
                bma0.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma0.mHWDATA;
            end
            else if(bma1.mHBUSREQ)begin
            
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b1;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                
                atb_sa.HSEL=1'b1;
                bsa1.HADDR=atb_ma.mHADDR;
                bsa1.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma1.mHADDR;
                atb_sa.HWRITE=bma1.mHWRITE;
                atb_sa.HTRANS=bma1.mHTRANS;
                bma1.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma1.mHWDATA;
            end
           else if(bma2.mHBUSREQ)begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b1;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                
                atb_sa.HSEL=1'b1;
                bsa2.HADDR=atb_ma.mHADDR;
                bsa2.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma2.mHADDR;
                atb_sa.HWRITE=bma2.mHWRITE;
                atb_sa.HTRANS=bma2.mHTRANS;
                bma2.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma2.mHWDATA;
            end
           else if(bma3.mHBUSREQ==1'b1)begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b1;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                
                atb_sa.HSEL=1'b1;
                bsa3.HADDR=atb_ma.mHADDR;
                bsa3.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma3.mHADDR;
                atb_sa.HWRITE=bma3.mHWRITE;
                atb_sa.HTRANS=bma3.mHTRANS;
                bma3.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma3.mHWDATA;
            end
            else if(bma4.mHBUSREQ)begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b1;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                
                atb_sa.HSEL=1'b1;
                bsa4.HADDR=atb_ma.mHADDR;
                bsa4.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma4.mHADDR;
                atb_sa.HWRITE=bma4.mHWRITE;
                atb_sa.HTRANS=bma4.mHTRANS;
                bma4.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma4.mHWDATA;
            end
            else if(bma5.mHBUSREQ)begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b1;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                atb_sa.HSEL=1'b1;
                bsa5.HADDR=atb_ma.mHADDR;
                bsa5.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma5.mHADDR;
                atb_sa.HWRITE=bma5.mHWRITE;
                atb_sa.HTRANS=bma5.mHTRANS;
                bma5.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma5.mHWDATA;
            end
            else if(bma6.mHBUSREQ)begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b1;
                bma7.mHGRANT=1'b0;
                
                atb_sa.HSEL=1'b1;
                bsa6.HADDR=atb_ma.mHADDR;
                bsa6.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma6.mHADDR;
                atb_sa.HWRITE=bma6.mHWRITE;
                atb_sa.HTRANS=bma6.mHTRANS;
                bma6.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma6.mHWDATA;
            end 
            else if(bma7.mHBUSREQ)begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b1;
                
                atb_sa.HSEL=1'b1;
                bsa7.HADDR=atb_ma.mHADDR;
                bsa7.HWRITE=atb_ma.mHWRITE;
                atb_sa.HADDR=bma7.mHADDR;
                atb_sa.HWRITE=bma7.mHWRITE;
                atb_sa.HTRANS=bma7.mHTRANS;
                bma7.mHRDATA=atb_sa.HRDATA;
                atb_sa.HWDATA=bma7.mHWDATA;
            end
            else begin
                bma0.mHGRANT=1'b0;
                bma1.mHGRANT=1'b0;
                bma2.mHGRANT=1'b0;
                bma3.mHGRANT=1'b0;
                bma4.mHGRANT=1'b0;
                bma5.mHGRANT=1'b0;
                bma6.mHGRANT=1'b0;
                bma7.mHGRANT=1'b0;
                atb_sa.HSEL=1'b0;
                
            end
        end
        else begin
                case(atb_ma.mHADDR[31:16])
                16'hF000 :begin
                            bsa0.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa0.HADDR;
                            bsa0.HWDATA=atb_ma.mHWDATA;
                            bsa0.HTRANS=atb_ma.mHTRANS;
                            bsa0.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa0.HRDATA;
//                             bma0.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                16'hF001 :begin
                            bsa1.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa1.HADDR;
                            bsa1.HWDATA=atb_ma.mHWDATA;
                            bsa1.HTRANS=atb_ma.mHTRANS;
                            bsa1.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa1.HRDATA;
//                             bma1.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                16'hF002 :begin
                            bsa2.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa2.HADDR;
                            bsa2.HWDATA=atb_ma.mHWDATA;
                            bsa2.HTRANS=atb_ma.mHTRANS;
                            bsa2.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa2.HRDATA;
//                             bma2.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                16'hF003 :begin
                            bsa3.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa3.HADDR;
                            bsa3.HWDATA=atb_ma.mHWDATA;
                            bsa3.HTRANS=atb_ma.mHTRANS;
                            bsa3.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa3.HRDATA;
                            //bma3.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                16'hF004 :begin
                            bsa4.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa4.HADDR;
                            bsa4.HWDATA=atb_ma.mHWDATA;
                            bsa4.HTRANS=atb_ma.mHTRANS;
                            bsa4.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa4.HRDATA;
//                             bma4.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                16'hF005 :begin
                            bsa5.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa5.HADDR;
                            bsa5.HWDATA=atb_ma.mHWDATA;
                            bsa5.HTRANS=atb_ma.mHTRANS;
                            bsa5.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa5.HRDATA;
//                             bma5.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                16'hF006 :begin
                            bsa6.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa6.HADDR;
                            bsa6.HWDATA=atb_ma.mHWDATA;
                            bsa6.HTRANS=atb_ma.mHTRANS;
                            bsa6.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa6.HRDATA;
//                             bma6.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end    
                16'hF007 :begin
                            bsa7.HADDR={16'hF000,atb_ma.mHADDR[15:0]};
//                             atb_sa.HADDR=bsa0.HADDR;
                            bsa7.HWDATA=atb_ma.mHWDATA;
                            bsa7.HTRANS=atb_ma.mHTRANS;
                            bsa7.HWRITE=atb_ma.mHWRITE;
                            atb_ma.mHRDATA=bsa7.HRDATA;
//                             bma7.mHGRANT=1'b0;
                            atb_sa.HSEL=1'b0;
                        end
                default:begin
                    atb_ma.mHRDATA=0;
                end
            endcase
                
            end
        end */   
endmodule
