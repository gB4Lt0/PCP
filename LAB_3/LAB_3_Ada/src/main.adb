with Ada.Text_IO, GNAT.Semaphores;
use Ada.Text_IO, GNAT.Semaphores;

with Ada.Containers.Indefinite_Doubly_Linked_Lists;
use Ada.Containers;

procedure Main is

package String_List is new Indefinite_Doubly_Linked_Lists(String);
   use String_List;

   Storage_Size : Integer := 10;
   Item_Count: Integer := 39;
   count_Of_Consumers: Integer := 8;
   count_Of_Producers: Integer := 4;


   Storage : List;
   Access_Storage : Counting_Semaphore(1,Default_Ceiling);
   Full_Storage : Counting_Semaphore(Storage_Size, Default_Ceiling);
   Empty_Storage : Counting_Semaphore(0,Default_Ceiling);

   task type Producer is
      entry Put_Item(max_Item : in Integer);
   end Producer;

   task body Producer is
      count_Of_Item: Integer;
   begin
      accept Put_Item(max_Item : in Integer)  do
         count_Of_Item := max_Item;
      end Put_Item;

      for i in 1..count_Of_Item loop
            Full_Storage.Seize;
            Access_Storage.Seize;

            Storage.Append("item " & i'Img);
            Put_Line("Added item " & i'Img);

            Access_Storage.Release;
            Empty_Storage.Release;
            delay 1.5;
      end loop;
   end Producer;

   task type Consumer is
      entry Take_Item(max_Item : in Integer);
   end Consumer;

   task body Consumer is
      count_Of_Item: Integer;
   begin
      accept Take_Item (max_Item : in Integer) do
        count_Of_Item := max_Item;
      end Take_Item;

       for i in 1..count_Of_Item loop
            Empty_Storage.Seize;
            Access_Storage.Seize;

            declare
               item : String := First_Element(Storage);
            begin
               Put_Line ("Took " & item);
            end;

            Storage.Delete_First;

            Access_Storage.Release;
            Full_Storage.Release;

            delay 2.0;
      end loop;
   end Consumer;

   item_To_Take: Integer := Item_Count;
   item_To_Put: Integer := Item_Count;
   item_For_One_Producer: Integer := Item_Count/count_Of_Producers;
   item_For_One_Consumer: Integer := Item_Count/count_Of_Consumers;
   amount_To_Add: Integer;
   amount_To_Take: Integer;

   producers : array(1..count_Of_Producers) of Producer;
   consumers : array(1..count_Of_Consumers) of Consumer;

begin
   for I in producers'Range loop
      if(I = (count_Of_Producers)) then
         amount_To_Add:= item_To_Put;
      else
         amount_To_Add:= item_For_One_Producer;
         item_To_Put := item_To_Put-amount_To_Add;
      end if;
      producers(I).Put_Item(amount_To_Add);
   end loop;

   for J in consumers'Range loop
      if(J = (count_Of_Consumers)) then
         amount_To_Take:= item_To_Take;
      else
         amount_To_Take:= item_For_One_Consumer;
         item_To_Take := item_To_Take-amount_To_Take;
      end if;
      consumers(J).Take_Item(amount_To_Take);
   end loop;
end Main;
