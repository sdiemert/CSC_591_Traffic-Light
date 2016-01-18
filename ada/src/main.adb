with Ada.Text_IO; use Ada.Text_IO;
with Traffic; use Traffic;

procedure Main is

    I : Integer := 0;

    procedure Write_State( State : Traffic_State) is

    begin

        Put_Line(Integer'Image(State_To_Number(State.Light_NS))&","
                 &Integer'Image(State_To_Number(State.Light_SN))&","
                 &Integer'Image(State_To_Number(State.Light_EW))&","
                 &Integer'Image(State_To_Number(State.Light_WE)));

    end Write_State;

    S : Traffic_State;

begin

   loop

        if I = 1 then
            S := NS_Green(EW_Red(S));
        elsif I = 2 then
            S := EW_Green(NS_Red(S));
        else
            S := EW_Red(NS_Red(S));
        end if;

        Write_State(S);

        I := (I + 1) mod 3;


      delay 1.0;

   end loop;


end Main;
