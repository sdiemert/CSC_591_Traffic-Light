with Ada.Real_Time; use Ada.Real_Time;
with Traffic; use Traffic;

package Control
   with SPARK_Mode
is

    type Variant is range 0 .. 6;

    type Tracker is record
        NS_Was_Green  : Boolean := False;
        NS_Was_Yellow : Boolean := False;
        EW_Was_Green  : Boolean := False;
        EW_Was_Yellow : Boolean := False;
    end record;


    function Get_Seconds return Seconds_Count
      with
        Pre => True,
        Post => (
                   Get_Seconds'Result > 0 and
                     Seconds_Count'Last - Get_Seconds'Result > THRU_TRAFFIC_TIME
                );

    procedure Main_Loop(Result : out Boolean) with SPARK_Mode;

    procedure Write_State( State : in Traffic_State)
      with
        Pre => True;

end Control;
