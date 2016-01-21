package body Traffic
  with SPARK_Mode
is

    procedure Control_Traffic(S : in out System_State; Curr : in Seconds_Count) is
    begin

        case S.Next_Event is
            when EVENT_NS_GREEN  => S.T_State := NS_Green(State => S.T_State);
            when EVENT_NS_YELLOW => S.T_State := NS_Yellow(State => S.T_State);
            when EVENT_NS_RED    => S.T_State := NS_Red(State => S.T_State);
            when EVENT_EW_RED    => S.T_State := EW_Red(State => S.T_State);
            when EVENT_EW_GREEN  => S.T_State := EW_Green(State => S.T_State);
            when EVENT_EW_YELLOW => S.T_State := EW_Yellow(State => S.T_State);
            when others          => S.T_State := All_Red;
        end case;

        S := Schedule_Next_Event(S => S, Curr => Curr);


    end Control_Traffic;


    function Schedule_Next_Event(S : System_State; Curr : Seconds_Count) return System_State
    is
        Next_State : System_State;
    begin
        case S.Next_Event is
            when EVENT_NS_GREEN  => Next_State :=  Make_State( EVENT_NS_YELLOW, Curr + THRU_TRAFFIC_TIME, S.T_State);
            when EVENT_NS_YELLOW => Next_State :=  Make_State( EVENT_NS_RED, Curr + PAUSE_TRAFFIC_TIME, S.T_State);
            when EVENT_NS_RED    => Next_State :=  Make_State (EVENT_EW_GREEN, Curr + PAUSE_TRAFFIC_TIME, S.T_State);
            when EVENT_EW_GREEN  => Next_State :=  Make_State (EVENT_EW_YELLOW, Curr + THRU_TRAFFIC_TIME, S.T_State);
            when EVENT_EW_YELLOW => Next_State := Make_State (EVENT_EW_RED, Curr + PAUSE_TRAFFIC_TIME, S.T_State);
            when EVENT_EW_RED    => Next_State :=  Make_State (EVENT_NS_GREEN, Curr + THRU_TRAFFIC_TIME, S.T_State);
            when others          => Next_State := Make_State(NO_EVENT, Curr, S.T_State);
        end case;
        return Next_State;

    end Schedule_Next_Event;

    function Copy_State(S: System_State) return System_State is
        To_Return : System_State;
    begin

        To_Return := Make_State(NE      => S.Next_Event,
                                NET     => S.Next_Event_Time,
                                T_State => S.T_State);

        return To_Return;

    end Copy_State;

    function Make_State(NE  : Event;
                        NET     : Seconds_Count;
                        T_State : Traffic_State ) return System_State
    is
        To_Return : System_State;
    begin
        To_Return.Next_Event := NE;
        To_Return.Next_Event_Time := NET;
        To_Return.T_State := Make_State(NS => T_State.Light_NS,
                                       SN => T_State.Light_SN,
                                       EW => T_State.Light_EW,
                                        WE => T_State.Light_WE);

        return To_Return;
    end Make_State;



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

    function All_Red return Traffic_State is
    begin
        return Make_State(RED, RED, RED, RED);
    end All_Red;

    function State_To_Number(S : Light_State) return Natural is
    begin
        return (case S is
                    when GREEN => 0,
                    when YELLOW => 1,
		    when RED => 2
               );
    end State_To_Number;

end Traffic;
