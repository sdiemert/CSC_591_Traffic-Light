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

    procedure Traffic_Loop(State  : in out Traffic_State) with SPARK_Mode
    is
        S, S_Prev, Next_Event_Time : Seconds_Count;
        V                          : Variant;
        Track                      : Tracker;
    begin

        S               := Get_Seconds;
        S_Prev          := Get_Seconds;
        Next_Event_Time := S + 2;
        V               := 0;
        Track           := (others => False);

        while Variant'Last - V > 0 loop

            if S = Next_Event_Time then

                case V is
                    when 0      => State := NS_Green(EW_Red(State));
                    when 1      => State := NS_Yellow(EW_Red(State));
                    when 3      => State := NS_Red(EW_Green(State));
                    when 4      => State := NS_Red(EW_Yellow(State));
                    when others => State := All_Red;
                end case;

                case V is
                    when 0|3      => Next_Event_Time := S + 5;
                    when others   => Next_Event_Time := S + 2;
                end case;

                V := V + 1;

                Track(V) := True;

            end if;

            if S > S_Prev then
                Write_State(State);
            end if;

            S_Prev := S;
            S := Get_Seconds;

            pragma Loop_Invariant(
                                  Safety_Traffic_Directions(State) and
                                  Liveliness(Track, V)
                                 );

            pragma Loop_Variant(Increases => V);

        end loop;

        State := All_Red;

    end Traffic_Loop;


    procedure Main_Loop(Result : out Boolean) with SPARK_Mode is
        State  : Traffic_State;
    begin

        Result := False;

        State := All_Red;

        loop

            Traffic_Loop (State);

            pragma Loop_Invariant(State_Is_All_Red(State));

        end loop;

    end Main_Loop;


end Control;
