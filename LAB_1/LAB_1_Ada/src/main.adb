with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Main is

   --num_threads : Integer := 8;
   --time_of_work : array (1..num_threads) of Duration :=  (1.0,2.0,5.0,4.0,7.0,3.0,6.0,8.0);
   --steps: array (1..num_threads) of Long_Long_Integer := (1,2,3,4,6,8,12,16);

   num_threads : Integer := 4;
   time_of_work : array (1..num_threads) of Duration :=  (1.0,2.0,5.0,4.0);
   steps: array (1..num_threads) of Long_Long_Integer := (1,2,3,4);

   can_stop: array (1..num_threads) of Boolean := (others => False);

   pragma Atomic(can_stop);

   task type counter is
      entry Init(id_in : Integer; step_in : Long_Long_Integer);
   end counter;

   task body counter is

      id : Integer;
      step: Long_Long_Integer;

      sum_of_sequence : Long_Long_Integer := 0;
      items_used : Long_Long_Integer := 0;

   begin
      accept Init (id_in : in Integer; step_in : in Long_Long_Integer) do
         begin
            id := id_in;
            step := step_in;
         end;
      end Init;

      loop
         sum_of_sequence := sum_of_sequence + step;
         items_used := items_used + 1;
         exit when can_stop(id);
      end loop;

      Put_Line ("ID: " & id'Img & " || sum_of_sequence: " & sum_of_sequence'Img & " || items_used: " & items_used'Img);
   end counter;

   task type thread_breaker is
      entry Init(id_in : Integer; time_in : Duration);
   end thread_breaker;

   task body thread_breaker is

      id : Integer;
      time : Duration;

   begin

      accept Init (id_in : in Integer; time_in : in Duration) do
         begin
            time := time_in;
            id := id_in;
         end;
      end Init;

      delay time;
      can_stop(id) := True;

   end thread_breaker;

   counters : array (1..num_threads) of counter;
   thread_breakers : array (1..num_threads) of thread_breaker;

begin
   for I in counters'Range loop
      counters(I).Init(i,steps(I));
      thread_breakers(I).Init(i,time_of_work(I));
   end loop;
end Main;
