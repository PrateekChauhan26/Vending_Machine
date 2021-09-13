`include "vending_machine.v"
module vending_machine_tb;
    
    reg clock,reset;
    reg [2:0] coin;
    
    wire vend;
    wire [2:0] state;
    wire [2:0] change;

   parameter [2:0] IDLE= 3'b001;
   parameter [2:0] FIVE= 3'b001;
   parameter [2:0] TEN= 3'b001;
   parameter [2:0] FIFTEEN= 3'b001;
   parameter [2:0] TWENTY= 3'b001;
   parameter [2:0] TWENTYFIVE= 3'b001;
   parameter [2:0] NICKEL= 3'b001;
   parameter [2:0] DIME = 3'b010;
   parameter [2:0] NICKEL_DIME = 3'b011;
   parameter [2:0] DIME_DIME=3'b101;
   parameter [2:0] QUARTER=3'b101;

   initial begin
       
       $display("Time\tcoin\tdrink\treset\tclock\tstate\tchange");
       $monitor("%g\t%b\t%b\t%b\t%b\t%d\t%d",$time,coin,vend,,reset,clock,state,change);   
       $dumpfile("vmfsm.vcd");
       $dumpvars; 
       clock=0;
       reset=1;
        #2 reset=0;
       coin=NICKEL;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=DIME ;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=QUARTER;
        #2 reset=1; coin=2'b00;
        #2 reset=0; 
        //reset and check for state 5
       coin=NICKEL;
        #2 coin=NICKEL; 
        #2 coin=NICKEL; 
        #2 coin=NICKEL; 
        #2 coin=NICKEL; 
        #2 reset=1; coin=2'b00;
        #2 reset=0;
        //reset again and check state 5 and so on
       coin=NICKEL;
        #2 coin=DIME;
        #2 coin=DIME;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=NICKEL;
        #2 coin=DIME;
        #2 coin=QUARTER;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=NICKEL;
        #2 coin=NICKEL; 
        #2 coin=NICKEL; 
        #2 coin=DIME;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=NICKEL;
        #2 coin=NICKEL; 
        #2 coin=NICKEL; 
        #2 coin=NICKEL;
        #2 coin=DIME;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=NICKEL;
        #2 coin=NICKEL; 
        #2 coin=QUARTER;
        #2 reset=1; coin=2'b00;
        #2 reset=0;
       coin=NICKEL;
        #2 coin=QUARTER;
        #2 reset=1; coin=2'b00;
        #2 $finish;
   end
   always
        #1 clock=~clock;
        initial begin
         if (reset)
         coin=2'b00;   
         end
         vending_machine inst1(clock,reset,coin,vend,state,change);
endmodule         