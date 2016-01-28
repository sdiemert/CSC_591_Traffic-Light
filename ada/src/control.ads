with Ada.Real_Time; use Ada.Real_Time;
with Traffic; use Traffic;

package Control
   with SPARK_Mode
is

    type Variant is range 0 .. 6;

    type Tracker is array (Variant) of Boolean;

    --------------------------
    -- System Properties
    --   These should be met during every
    --   state of the system.
    --------------------------

    function Liveliness(T : Tracker; V : Variant) return Boolean
    is (for all I in Variant'Range => (if I < V then T(I) = True));

    function NS_Safety_Traffic_Directions(S : Traffic_State) return Boolean
    is ( if S.Light_NS = GREEN or S.Light_SN = Green or S.Light_NS = YELLOW or
          S.LIGHT_SN = YELLOW then S.Light_EW = RED and S.Light_WE = RED);

    function EW_Safety_Traffic_Directions(S : Traffic_State) return Boolean
    is ( if S.Light_EW = GREEN or S.Light_WE = Green or S.Light_EW=YELLOW or
          S.LIGHT_WE=YELLOW then S.Light_NS = RED and S.Light_SN = RED);

    function Safety_Traffic_Directions(S : Traffic_State) return Boolean
    is ( NS_Safety_Traffic_Directions(S) and EW_Safety_Traffic_Directions(S));

    ---------------------------
    -- Helper Time Functions
    ---------------------------

    function Get_Time return Time
      with
        Pre => True,
        Post => Get_Time'Result < Time_Last and Get_Time'Result > Time_First;

    function Get_Next_Second_Time(T : Time) return Time
      with
        Pre => T < Time_Last and T >= Time_First,
        Post => Get_Next_Second_Time'Result <= Time_Last;

    -----------------------------
    -- Used for writing to the console.
    -----------------------------

    Procedure Write_State( State : in Traffic_State)
      with
        Pre => True;

    procedure Main_Loop(Result : out Boolean) with SPARK_Mode;

    procedure Traffic_Loop(State  : in out Traffic_State)
      with
        Pre => State_Is_All_Red(State) and Safety_Traffic_Directions(State),
        Post => State_Is_All_Red(State) and Safety_Traffic_Directions(State);


end Control;
