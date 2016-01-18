with Ada.Text_IO; use Ada.Text_IO;
with Traffic; use Traffic;
with Ada.Real_Time; use Ada.Real_Time;

procedure Main is

    procedure Write_State( State : Traffic_State) is

    begin

        Put_Line(Integer'Image(State_To_Number(State.Light_NS))&","
                 &Integer'Image(State_To_Number(State.Light_SN))&","
                 &Integer'Image(State_To_Number(State.Light_EW))&","
                 &Integer'Image(State_To_Number(State.Light_WE)));

    end Write_State;

    function Make_Seconds(T : in Time) return Seconds_Count
    is
        Other : Time_Span;
        Secs : Seconds_Count;
    begin

        Split(T, Secs, Other);

        return Secs;

    end Make_Seconds;

    S : System_State;
    Current : Time;

begin

    loop

        Current := Clock;
        Put_Line(Seconds_Count'Image(Make_Seconds(Current)));
        Control_Traffic(S => S, Curr => Make_Seconds(Current));
        Write_State(S.T_State);
        delay 0.25;

   end loop;


end Main;
