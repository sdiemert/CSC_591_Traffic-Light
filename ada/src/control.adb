with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

package body Control

is

    procedure Write_State( State : in Traffic_State) is
    begin

        Put_Line(Integer'Image(State_To_Number(State.Light_NS))&","
                 &Integer'Image(State_To_Number(State.Light_SN))&","
                 &Integer'Image(State_To_Number(State.Light_EW))&","
                 &Integer'Image(State_To_Number(State.Light_WE)));

    end Write_State;

    function Get_Seconds return Seconds_Count is
        Other : Time_Span;
        Secs  : Seconds_Count;
        T : Time;
    begin
        T := Clock;
        Split(T  => T,
              SC => Secs,
              TS => Other);
        return Secs;
    end Get_Seconds;


    procedure Main_Loop(Result : out Boolean) with SPARK_Mode is
        S: Seconds_Count;
        S_Prev : Seconds_Count := 0;
        State  : System_State;
    begin

        Result := False;
        State.Next_Event := EVENT_NS_GREEN;
        State.Next_Event_Time := Get_Seconds + 3;
        S := Get_Seconds;

        while S < (Seconds_Count'Last - THRU_TRAFFIC_TIME) loop

            if S = State.Next_Event_Time then
                Control_Traffic(S => State, Curr => S);
            end if;

            if S > S_Prev then Write_State(State.T_State); end if;

            pragma Loop_Invariant(Safety_Traffic_Directions(State.T_State));

            S_Prev := S;
            S := Get_Seconds;

        end loop;

    end Main_Loop;


end Control;
