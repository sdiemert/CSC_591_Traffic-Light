with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

   I : Integer := 0;

begin

   loop

      Put_Line(Integer'Image(I));

      I := (I + 1) mod 3;

      delay 1.0;

   end loop;


end Main;
