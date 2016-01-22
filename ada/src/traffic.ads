with Ada.Real_Time; use Ada.Real_Time;
package Traffic
    with SPARK_Mode
is

    type Light_State is (GREEN, YELLOW, RED);

    type Event is (
                   EVENT_NS_GREEN, EVENT_NS_RED, EVENT_NS_YELLOW,
                   EVENT_EW_GREEN, EVENT_EW_RED, EVENT_EW_YELLOW,
                   NO_EVENT
                  );

    THRU_TRAFFIC_TIME : constant Seconds_Count  := 5;
    PAUSE_TRAFFIC_TIME : constant Seconds_Count := 2;

    type Traffic_State is record

        Light_NS : Light_State := RED;
        Light_SN : Light_State := RED;
        Light_EW : Light_State := RED;
        Light_WE : Light_State := RED;

    end record;

    type System_State is record

        T_State         : Traffic_State;
        Next_Event_Time : Seconds_Count := 0;
        Next_Event      : Event   := NO_EVENT;

    end record;



    function NS_Safety_Traffic_Directions(S : Traffic_State) return Boolean
    is ( if S.Light_NS = GREEN or S.Light_SN = Green or S.Light_NS = YELLOW or
          S.LIGHT_SN = YELLOW then S.Light_EW = RED and S.Light_WE = RED);

    function EW_Safety_Traffic_Directions(S : Traffic_State) return Boolean
    is ( if S.Light_EW = GREEN or S.Light_WE = Green or S.Light_EW=YELLOW or
          S.LIGHT_WE=YELLOW then S.Light_NS = RED and S.Light_SN = RED);

    function Safety_Traffic_Directions(S : Traffic_State) return Boolean
      is ( NS_Safety_Traffic_Directions(S) and EW_Safety_Traffic_Directions(S));

    function Is_Equal(S1 : Traffic_State; S2 : Traffic_State) return Boolean
      is (
          S1.Light_NS = S2.Light_NS and
            S1.Light_SN = S2.Light_SN and
              S1.Light_EW = S2.Light_EW and
                S1.Light_WE = S2.Light_WE
        );

    procedure Control_Traffic(S : in out System_State; Curr : in Seconds_Count)
      with
        Pre => (
                  S.Next_Event_Time = Curr and
                  (Curr > 0 and then Seconds_Count'Last - Curr > THRU_TRAFFIC_TIME) and
                      Safety_Traffic_Directions(S.T_State)
               ),
        Post => (
                   Safety_Traffic_Directions(S.T_State)
                );

    function Schedule_Next_Event(S: System_State; Curr : Seconds_Count) return System_State
      with
        Pre => (
                  S.Next_Event_Time = Curr and
                  (Curr > 0 and then Seconds_Count'Last - Curr > THRU_TRAFFIC_TIME)
               ),
        Post => (
                   Schedule_Next_Event'Result.Next_Event_Time >= Curr and
                   Schedule_Next_Event'Result.Next_Event_Time >= S.Next_Event_Time and
                   Is_Equal(Schedule_Next_Event'Result.T_State, S.T_State) and
                   (if S.Next_Event /= NO_EVENT then Schedule_Next_Event'Result.Next_Event /= S.Next_Event)

                );


    function Make_State( NS, SN, EW, WE : Light_State) return Traffic_State
      with
        Pre => True,
        Post => (
                    Make_State'Result.Light_NS = NS and
                    Make_State'Result.Light_SN = SN and
                    Make_State'Result.Light_EW = EW and
                    Make_State'Result.Light_WE = WE
                );

    function Make_State(NE  : Event;
                        NET     : Seconds_Count;
                        T_State : Traffic_State ) return System_State
      with
        Pre => True,
        Post => (
                   Make_State'Result.Next_Event = NE and
                   Make_State'Result.Next_Event_Time = NET and
                   Is_Equal(Make_State'Result.T_State, T_State)
                );

    function Copy_State( S : System_State) return System_State
      with
        Pre => True,
        Post => (
                   Copy_State'Result.Next_Event = S.Next_Event and
                   Copy_State'Result.Next_Event_Time = S.Next_Event_Time and
                   Is_Equal(Copy_State'Result.T_State, S.T_State)
                );


    function NS_Green( State : Traffic_State ) return Traffic_State
      with
        Pre => True,
        Post => (
                    NS_Green'Result.Light_NS = GREEN and
                    NS_Green'Result.Light_SN = GREEN and
                    NS_Green'Result.Light_EW = State.Light_EW and
                    NS_Green'Result.Light_WE = State.Light_WE
                );


    function NS_Red( State : Traffic_State ) return Traffic_State
      with
        Pre => True,
        Post => (
                    NS_Red'Result.Light_NS = RED and
                    NS_Red'Result.Light_SN = RED and
                    NS_Red'Result.Light_EW = State.Light_EW and
                    NS_Red'REsult.Light_WE = State.Light_WE
                );

    function NS_Yellow( State : Traffic_State ) return Traffic_State
      with
        Pre => True,
        Post => (
                    NS_Yellow'Result.Light_NS = YELLOW and
                    NS_Yellow'Result.Light_SN = YELLOW and
                    NS_Yellow'Result.Light_EW = State.Light_EW and
                    NS_Yellow'REsult.Light_WE = State.Light_WE
                );

    function EW_Green( State : Traffic_State ) return Traffic_State
      with
        Pre => True,
        Post => (
                    EW_Green'Result.Light_NS = State.Light_NS and
                    EW_Green'Result.Light_SN = State.Light_SN and
                    EW_Green'Result.Light_EW = GREEN and
                    EW_Green'Result.Light_WE = GREEN
                );


    function EW_Red( State : Traffic_State ) return Traffic_State
      with
        Pre => True,
        Post => (
                    EW_Red'Result.Light_NS = State.Light_NS and
                    EW_Red'Result.Light_SN = State.Light_SN and
                    EW_Red'Result.Light_EW = RED and
                    EW_Red'Result.Light_WE = RED
                );
    function EW_Yellow( State : Traffic_State ) return Traffic_State
      with
        Pre => True,
        Post => (
                    EW_Yellow'Result.Light_NS = State.Light_NS and
                    EW_Yellow'Result.Light_SN = State.Light_SN and
                    EW_Yellow'Result.Light_EW = YELLOW and
                    EW_Yellow'Result.Light_WE = YELLOW
                );

    function All_Red return Traffic_State
      with
        Pre => True,
        Post => (
                    All_Red'Result.Light_NS = RED and
                    All_Red'Result.Light_SN = RED and
                    All_Red'Result.Light_EW = RED and
                    All_Red'Result.Light_WE = RED
                );
    function State_To_Number(S : Light_State) return Natural
      with
        Contract_Cases => (
                           S = GREEN  => State_To_Number'Result = 0,
                           S = YELLOW => State_To_Number'Result = 1,
                           S = RED    => State_To_Number'Result = 2
                          );


end Traffic;
