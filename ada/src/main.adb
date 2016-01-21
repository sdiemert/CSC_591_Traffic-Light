with Ada.Text_IO; use Ada.Text_IO;
with Traffic; use Traffic;
with Control; use Control;

procedure Main is

    B : Boolean;
begin

    loop

        --Current := Clock;
        --Put_Line(Seconds_Count'Image(Make_Seconds(Current)));
        --Control_Traffic(S => S, Curr => Make_Seconds(Current));
        --Write_State(S.T_State);
        Main_Loop(B);

   end loop;


end Main;
