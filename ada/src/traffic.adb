package body Traffic
  with SPARK_Mode
is

    function Make_State(NS, SN, EW, WE : Light_State) return Traffic_State
    is
        Ts : Traffic_State;
    begin
        Ts.Light_NS := NS;
        Ts.Light_SN := SN;
        Ts.Light_EW := EW;
        Ts.Light_WE := WE;
        return Ts;
    end Make_State;

    function NS_Green(State : Traffic_State) return Traffic_State is
    begin
        return Make_State(GREEN, GREEN, State.Light_EW, State.Light_WE);
    end NS_Green;

    function NS_Red(State : Traffic_State) return Traffic_State is
    begin
        return Make_State(RED, RED, State.Light_EW, State.Light_WE);
    end NS_Red;

    function NS_Yellow(State : Traffic_State) return Traffic_State is
    begin
        return Make_State(YELLOW, YELLOW, State.Light_EW, State.Light_WE);
    end NS_Yellow;

    function EW_Green(State : Traffic_State) return Traffic_State is
    begin
        return Make_State(State.Light_NS, State.Light_SN, GREEN, GREEN);
    end EW_Green;

    function EW_Red(State : Traffic_State) return Traffic_State is
    begin
        return Make_State(State.Light_NS, State.Light_SN, RED, RED);
    end EW_Red;

    function EW_Yellow(State : Traffic_State) return Traffic_State is
    begin
        return Make_State(State.Light_NS, State.Light_SN, YELLOW, YELLOW);
    end EW_Yellow;

    function State_To_Number(S : Light_State) return Natural is
    begin
        return (case S is
                    when GREEN => 0,
                    when YELLOW => 1,
		            when RED => 2
               );
    end State_To_Number;

end Traffic;
