with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

package body Control

is

    function Get_Time return Time is
    begin
        return Clock;
    end Get_Time;

    function Get_Next_Second_Time(T : Time) return Time is
    begin
        return T + Seconds(1);
    end Get_Next_Second_Time;

    function Wait_One_Second return Boolean with SPARK_Mode is
        Q  : Integer := Integer'Last;
        T1 : Time    := Get_Time;
        T2 : Time    := Get_Next_Second_Time(T1);
    begin

        -- Closest approxmiation to a one-second
        -- timer I could make while still being able
        -- to prove termination of the loop.

        while Q > 0 and T1 <= T2 loop

            T1 := Get_Time;
            Q  := Q - 1;

            pragma Loop_Invariant(Q >= 0);
            pragma Loop_Variant(Decreases => Q);

        end loop;

        return True;

    end Wait_One_Second;


    function Wait_For_Seconds (S : Natural) return Boolean with SPARK_Mode is
        I : Natural := S;
        B : Boolean := False;
    begin

        while I > 0 loop
            B := Wait_One_Second;
            I := I - 1;

            pragma Loop_Invariant(I >= 0);
            pragma Loop_Variant(Decreases => I);

        end loop;

        return B;

    end Wait_For_Seconds;

    procedure Write_State( State : in Traffic_State) is
    begin

        Put_Line(Integer'Image(State_To_Number(State.Light_NS))&","
                 &Integer'Image(State_To_Number(State.Light_SN))&","
                 &Integer'Image(State_To_Number(State.Light_EW))&","
                 &Integer'Image(State_To_Number(State.Light_WE)));

    end Write_State;

    procedure Traffic_Loop(State  : in out Traffic_State) with SPARK_Mode
    is
        Delay_Time : Natural;
        V          : Variant := 0;
        Track      : Tracker := (others => False);
        B          : Boolean := False;
    begin

        while Variant'Last - V > 0 loop

            case V is
                when 0      => State := NS_Green(EW_Red(State));
                when 1      => State := NS_Yellow(EW_Red(State));
                when 3      => State := NS_Red(EW_Green(State));
                when 4      => State := NS_Red(EW_Yellow(State));
                when others => State := All_Red;
            end case;

            case V is
                when 0|3      => Delay_Time := 5;
                when others   => Delay_Time := 2;
            end case;

            Track(V) := True;

            V := V + 1;

            Write_State(State);

            B := Wait_For_Seconds(Delay_Time);

            pragma Loop_Invariant(Safety_Traffic_Directions(State) and Liveliness(Track, V));
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
