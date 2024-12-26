module ALU(input A,
              input B,
              input Cin,//carryIn
              input [3:0] OpCode,
              output reg result,
              output reg Cout//carryOut
);

        always@(*) begin 
          case(OpCode)
            4'b0000:begin
              result=A&B;
              Cout=0;
            end
            
            4'b0001:begin
              result=A|B;
              Cout=0;
            end
            
            4'b0010:begin//xor
              result=A^B;
              Cout=0;
            end
            
            4'b0011:begin//nor
              result=~(A|B);
              Cout=0;
            end
            
            4'b0100:begin//nand
              result=~(A&B);
              Cout=0;
            end
            
            4'b0101:begin
              {Cout,result} = A+B+Cin;
            end
            
            4'b0110:begin
              result=A-B;
            end
            
            4'b0111:begin
              result=A*B;
            end
            
            4'b1000:begin
              result=A/B;
            end
            
            4'b1001:begin//shift 1 bit to left
              result=A<<1;
            end
            
            4'b1010:begin//shift 1 bit to right
              result=A>>1;
            end
            
            default:begin
              Cout=0;
              result=0;
            end
          endcase
        end
      endmodule
      
module ALU_testbench;
  reg [7:0] A , B;
  reg [3:0] OpCode;
  wire [7:0] result;
  wire Cout;
  
  function [31:0] get_name(input [3:0] op);
    begin
      case(op)
        4'b0000: get_name = "AND";
        4'b0001: get_name = "OR";
        4'b0010: get_name = "XOR";
        4'b0011: get_name = "NOR";
        4'b0100: get_name = "NAND";
        4'b0101: get_name = "ADD";
        4'b0110: get_name = "SUBTRACT";
        4'b0111: get_name = "MULTIPLY";            
        4'b1000: get_name = "DIVIDE";
        4'b1001: get_name = "SHIFT LEFT";
        4'b1010: get_name = "SHIFT RIGHT";
        default: get_name = "INVALID OPERATION";
      endcase
    end
  endfunction
              
            
  
  ALU ALU_init(.A(A), .B(B), .OpCode(OpCode), .result(result), .Cout(Cout));//ALU instantiate
  
  initial begin
    //test shift right
    A=8'b1110;
    OpCode=4'b1010;
    #5;
    $display("OpName:%s, Operand=%b, Result=%b,",get_name(OpCode), result);
  end
endmodule
    
    