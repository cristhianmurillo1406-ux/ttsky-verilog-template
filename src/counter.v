`timescale 1ns/1ps

module tb;

  // Señales
  reg clk;
  reg rst;
  wire [3:0] count;

  // Instancia del contador (DUT = Device Under Test)
  contador dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  // Generador de reloj
  // Cada 5 ns cambia el valor de clk
  // Periodo completo = 10 ns
  always #5 clk = ~clk;

  initial begin
    // Inicialización
    clk = 0;
    rst = 1;

    // $display imprime UNA sola vez
    $display("Tiempo\tcount");

    // $monitor imprime AUTOMÁTICAMENTE cada vez que cambia alguna señal
    // %0t → tiempo de simulación
    // %b  → valor en binario
    $monitor("%0t\t%b", $time, count);

    // #10 significa: esperar 10 unidades de tiempo (aquí 10 ns)
    #10;
    rst = 0;   // quitamos reset

    // Dejar correr el contador por 100 ns
    #100;

    $finish;
  end

endmodule