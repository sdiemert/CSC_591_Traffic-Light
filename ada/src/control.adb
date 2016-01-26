with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

package body Control

is

    procedure Traffic_Loop(State  : in out Traffic_State);

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


    ------------------
    -- Traffic_Loop --
    ------------------

    procedure Traffic_Loop(State  : in out Traffic_State)
    is
        S, S_Prev, Next_Event_Time : Seconds_Count := 0;
        V                          : Variant := 0;
        Track                      : Tracker;

    begin

        State := All_Red;
        S := Get_Seconds;
        S_Prev := Get_Seconds;
        Next_Event_Time := S + 2;

        while Event'Range_Length - V > 0 loop

            if S = Next_Event_Time then

                case V is
                    when 0 =>
                        State               := NS_Green(EW_Red(State => State));
                        Next_Event_Time     := S + 5;
                        Track.NS_Was_Green  := True;

                    when 1 =>
                        State               := NS_Yellow(EW_Red(State => State));
                        Next_Event_Time     := S + 2;
                        Track.NS_Was_Yellow := True;

                    when 2 =>
                        State               := All_Red;
                        Next_Event_Time     := S + 2;

                    when 3 =>
                        State               := NS_Red(EW_Green(State));
                        Next_Event_Time     := S + 5;
                        Track.EW_Was_Green  := True;

                    when 4 =>
                        State               := NS_Red(EW_Yellow(State));
                        Next_Event_Time     := S + 2;
                        Track.EW_Was_Yellow := True;

                    when 5 =>
                        State               := All_Red;

                    when others =>
                        State               := All_Red;
                end case;

                V := V + 1;

            end if;

            pragma Loop_Invariant(Safety_Traffic_Directions(State));

            if S > S_Prev then
                Write_State(State);
            end if;

            S_Prev := S;
            S := Get_Seconds;

        end loop;

    end Traffic_Loop;


    procedure Main_Loop(Result : out Boolean) with SPARK_Mode is
        State  : System_State;
    begin

        Result := False;

        loop

            Traffic_Loop (State.T_State);

        end loop;

    end Main_Loop;


end Control;
