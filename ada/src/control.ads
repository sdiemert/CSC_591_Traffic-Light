with Ada.Real_Time; use Ada.Real_Time;
with Traffic; use Traffic;

package Control
   with SPARK_Mode
is

    function Get_Seconds return Seconds_Count
      with
        Pre => True,
        Post => Get_Seconds'Result > 0;

    procedure Main_Loop(Result : out Boolean) with SPARK_Mode;

    procedure Write_State( State : in Traffic_State)
      with
        Pre => True;

end Control;
