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
        State.Next_Event_Time := Get_Seconds + 5;

        loop

            S := Get_Seconds;

            if S = State.Next_Event_Time then
                Control_Traffic(S    => State,
                                Curr => S);
            end if;

            -- Print the state once a second.
            if S > S_Prev then Write_State(State.T_State); end if;

            S_Prev := S;

        end loop;

    end Main_Loop;


end Control;
