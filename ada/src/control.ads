with Ada.Real_Time; use Ada.Real_Time;
with Traffic; use Traffic;

package Control
   with SPARK_Mode
is

    type Variant is range 0 .. 6;

    type Tracker is array (Variant) of Boolean;

    function Liveliness(T : Tracker; V : Variant) return Boolean
       is (for all I in Variant'Range => (if I <= V then T(I) = True));


    procedure Main_Loop(Result : out Boolean) with SPARK_Mode;

    procedure Write_State( State : in Traffic_State)
      with
        Pre => True;

    procedure Traffic_Loop(State  : in out Traffic_State)
      with
        Pre => State_Is_All_Red(State),
        Post => State_Is_All_Red(State);


end Control;
