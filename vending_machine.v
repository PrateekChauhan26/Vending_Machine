module vending_machine(clock,reset,coin,vend,state,change);

   input [2:0] coin;
   input clock;
   input reset;

   output vend;
   output [2:0] state;
   output [2:0] change;

   reg vend;
   reg [2:0] change;
   wire coin;


   parameter [2:0] NICKEL= 3'b001;
   parameter [2:0] DIME = 3'b010;
   parameter [2:0] NICKEL_DIME = 3'b011;
   parameter [2:0] DIME_DIME=3'b101;
   parameter [2:0] QUARTER=3'b101;

   parameter [2:0] IDLE= 3'b001;
   parameter [2:0] FIVE= 3'b001;
   parameter [2:0] TEN= 3'b001;
   parameter [2:0] FIFTEEN= 3'b001;
   parameter [2:0] TWENTY= 3'b001;
   parameter [2:0] TWENTYFIVE= 3'b001;

   reg [2:0] state,next_state;

      always @(state or coin)
         begin
            next_state=0;
            case (state)
               IDLE   : case (coin)
               NICKEL : next_state = FIVE;
               DIME   : next_state = TEN;
               QUARTER: next_state = TWENTYFIVE;
               default:  next_state = IDLE;
            endcase 
               FIVE   : case (coin)
               NICKEL : next_state = TEN;
               DIME   : next_state = FIFTEEN;
               QUARTER: next_state = TWENTYFIVE;
               default:  next_state = FIVE;
            endcase
               TEN    : case (coin)
               NICKEL : next_state = FIFTEEN;
               DIME   : next_state = TWENTY;
               QUARTER: next_state = TWENTYFIVE;
               default:  next_state = TEN;
            endcase
               FIFTEEN: case (coin)
               NICKEL : next_state = TWENTY;
               DIME   : next_state = TWENTYFIVE;
               QUARTER: next_state = TWENTYFIVE;
               default:  next_state = FIFTEEN;
            endcase
               TWENTY : case(coin)
               NICKEL : next_state = TWENTYFIVE;
               DIME   : next_state = TWENTYFIVE;
               QUARTER: next_state = TWENTYFIVE;
               default:  next_state = TWENTY;
            endcase
               TWENTYFIVE : next_state = IDLE;
               default : next_state = IDLE;
            endcase
      end

      always @(clock)
         begin
            if (reset) begin
            state <= IDLE;
            vend  <= 1'b0;   
         end
            else state <= next_state;
            case (state)
               IDLE      : begin vend <= 1'b0; change <=3'd0; end 
               FIVE      : begin vend <= 1'b0; if (coin == QUARTER) change <=NICKEL; else change <= 3'd0; end
               TEN       : begin vend <= 1'b0; if (coin == QUARTER) change <=DIME  ; else change <= 3'd0; end
               FIFTEEN   : begin vend <= 1'b0; if (coin == QUARTER) change <=NICKEL_DIME; else change <= 3'd0; end
               TWENTY    : begin vend <= 1'b0; if (coin == DIME) change <=NICKEL; else if (coin == QUARTER); else change <= 3'd0; end
               TWENTYFIVE: begin vend <= 1'b1; change <= 3'd0; end
               default   : state <= IDLE;
            endcase
      end
endmodule