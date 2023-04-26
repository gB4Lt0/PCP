with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Semaphores; use GNAT.Semaphores;

procedure Lab_4 is

   num_of_philosophers : constant Integer := 3;
   num_of_repetitions : constant Integer := 2;
   delay_in_reflection : constant Duration := 2.0;
   time_to_eat: constant Duration := 2.0;

   forks: array(1..num_of_philosophers) of Counting_Semaphore(1,Default_Ceiling);

   task type Philosopher is
      entry Process(phil_id, cur_left_fork_id, cur_right_fork_id : Integer);
   end Philosopher;

   task body Philosopher is

      id : Integer;
      left_fork_id : Integer;
      right_fork_id : Integer;

   begin

      accept Process (phil_id, cur_left_fork_id, cur_right_fork_id : Integer) do

         id := phil_id;
         left_fork_id := cur_left_fork_id;
         right_fork_id := cur_right_fork_id;

      end Process;

      for I in 1..num_of_repetitions loop

         Put_Line("Philosopher_ID: " & id'Img & " || thinking " & I'Img & " time");
         delay delay_in_reflection;

         forks(left_fork_id).Seize;
         Put_Line("Philosopher_ID: " & id'Img & " || took left fork");
         forks(right_fork_id).Seize;
         Put_Line("Philosopher_ID: " & id'Img & " || took right fork");

         Put_Line("Philosopher_ID: " & id'Img & " || eating " & I'Img & " time");
         delay time_to_eat;

         forks(right_fork_id).Release;
         Put_Line("Philosopher_ID: " & id'Img & " || put right fork");
         forks(left_fork_id).Release;
         Put_Line("Philosopher_ID: " & id'Img & " || put left fork");
      end loop;

   end Philosopher;


   philosophers : array(1..num_of_philosophers) of Philosopher;

begin
   for I in 1..num_of_philosophers loop

      if(I = num_of_philosophers) then
         philosophers(I).Process(I, I rem num_of_philosophers + 1, I);
      else
         philosophers(I).Process(I, I, I + 1);
      end if;
   end loop;
end Lab_4;
