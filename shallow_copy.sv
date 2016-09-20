
class c1;
  logic [3:0] a;
  logic [3:0] b;
  
  function new();  
    a = 2;
    b = 1;
    $display("object of c1 is called");
  endfunction
endclass

class c2;
  logic [3:0]c;
  logic [3:0]d;
  c1 h1;
  
  function new();
   c = 9;
   d = 10;
    $display("object of c2 is called");
   h1 = new();
    $display("object of c1 inside c2 is called");
  endfunction
  
endclass

module shallow_copy;
  initial begin
    c2 p1;
    c2 p2;
    c2 p3;
    
    p1 = new();
    
    p2 = new p1;
    //shallow copy - copies the variable and allocates diff memory
    $display("handle p1 of c2 is shallow copied by p2");
    
    p3 = p1;//assignment - shares same memory
    $display("handle p1 of c2 is assigned to p3");
    
    dis(p1.h1.a,p1.h1.b,p1.c,p1.d,p2.h1.a,p2.h1.b,p2.c,p2.d,p3.h1.a,p3.h1.b,p3.c,p3.d);
    
    #10;
    p1.c = 5;
    $display("variable c is updated by using p1");
    dis(p1.h1.a,p1.h1.b,p1.c,p1.d,p2.h1.a,p2.h1.b,p2.c,p2.d,p3.h1.a,p3.h1.b,p3.c,p3.d);
    
    #10;
    p2.c = 6;
    $display("variable c is updated by using p2");

    dis(p1.h1.a,p1.h1.b,p1.c,p1.d,p2.h1.a,p2.h1.b,p2.c,p2.d,p3.h1.a,p3.h1.b,p3.c,p3.d);
    
    #10;
    p2.h1.a = 3;// h1 is a common object handle so it has only one memory location and each tym it is called it vl update all the object corresponding instances.
    $display(" internal variable a is updated by using p3");
    
    dis(p1.h1.a,p1.h1.b,p1.c,p1.d,p2.h1.a,p2.h1.b,p2.c,p2.d,p3.h1.a,p3.h1.b,p3.c,p3.d);
    #10;
    p3.c = 2;// updates the p1.c value to 2 from 5 since p3 is direct assignment of p1
    $display("variable c is updated by using p3"); 
    // a and b variables are updated if p2 is updated or p1 but c and d have diff memory location for p1 and p2 hence induvidual values are assigned
    dis(p1.h1.a,p1.h1.b,p1.c,p1.d,p2.h1.a,p2.h1.b,p2.c,p2.d,p3.h1.a,p3.h1.b,p3.c,p3.d);
  end 
  
  
  
  task dis(int a,b,c,d,a2,b2,c2,d2,a3,b3,c3,d3);
    $display("handle 1\t",a,b,c,d);
    $display("handle 2\t",a2,b2,c2,d2);
    $display("handle 3\t",a3,b3,c3,d3);
  endtask
endmodule