with Ada.Text_IO; use Ada.Text_IO;

package body controller is

    ----------------------------
    -- Calculate_Displacement --
    ----------------------------

    function Calculate_Displacement (Index : Integer) return Point is
    begin

        case Index is

            when 1      => return (0, -1);
            when 2      => return (1, 0);
            when 3      => return (0, 1);
            when 4      => return (-1, 0);
            when others => return (0, 0);

        end case;

    end Calculate_Displacement;

    ----------------------
    -- Int_To_Direction --
    ----------------------

    function Int_To_Direction (Number : Integer) return Character is
    begin

        case Number is

            when 1      => return 'U';
            when 2      => return 'R';
            when 3      => return 'D';
            when 4      => return 'L';
            when others => return 'U';

        end case;
    end Int_To_Direction;

    ---------------
    -- Is_In_Map --
    ---------------

    function Is_In_Map (Coords : Point) return Boolean is

        Is_In_X : Boolean := Coords.x >= Integer (Rows'First) and
                             Coords.x <= Integer (Rows'Last);

        Is_In_Y : Boolean := Coords.y >= Integer (Cols'First) and
                             Coords.y <= Integer (Cols'Last);
    begin

        return Is_In_X and Is_In_Y;

    end Is_In_Map;

    -----------------
    -- Is_Finished --
    -----------------

    function Is_Finished (Number : Path_Embranchments) return Boolean is
    begin
        return Number = 0;
    end Is_Finished;

    -----------------------
    -- Is_Not_Going_Back --
    -----------------------

    function Is_Not_Going_Back (Idx : Integer; Root : Acc_Node) return Boolean is
    begin
        return Int_To_Direction (Idx) /= Root.Get_Direction;
    end Is_Not_Going_Back;

    -------------------------
    -- Generate_Random_Map --
    -------------------------

    procedure Generate_Random_Map (Root : in out Acc_Node) is

        Coords : Point := Root.Get_Coordinates;

        Number_Of_Embranchments : Path_Embranchments := Draw_Random_Path_Number;

        Direction_List : Direction_Vector.Vector :=
            Draw_Random_Directions (Number_Of_Embranchments);

        Embranchments_List : NodeList.Vector;

    begin

        if not Is_Finished (Number_Of_Embranchments) then

                for I of Direction_List loop

                    declare
                        Idx          : Integer := Integer (I);
                        T            : Acc_Node := new Node;
                        Displacement : Point := Calculate_Displacement (Integer (I));
                    begin

                        T.Set_Direction (Int_To_Direction (Idx));
                        T.Set_Coordinates (Coords, Displacement);

                        if Is_Not_Going_Back (Idx, Root)
                            and Is_In_Map (T.Get_Coordinates) then

                            Generate_Random_Map (T);
                            Embranchments_List.Append (T);
                        end if;
                    end;
                end loop;

                Root.Set_Embranchments (Embranchments_List);


        end if;

    end Generate_Random_Map;

    -------------------------------------
    -- Cumulative_Direction_To_Unicode --
    -------------------------------------

    function Cumulative_Direction_To_Unicode (C_Dir : String;
                                              Nb_Path : Path_Embranchments;
                                              Translation_Table : Cumulative_Direction_Table.Map)
    return String is
    begin

        if Nb_Path = 0 then
            return PE;

        elsif Nb_Path = 3 then
            return CR;
        end if;

        return Translation_Table (C_Dir);

    end Cumulative_Direction_To_Unicode;

    ------------------------------
    -- Get_Cumulative_Direction --
    ------------------------------

    function Get_Cumulative_Direction (Root : Acc_Node;
                                       Nb_Path : Path_Embranchments)
    return String is

        Next_Cumulative_Direction : String (1 .. 3);
        Embranchments_List : NodeList.Vector := Root.Get_Embranchments;
    begin

        if Nb_Path = 1 then
            Next_Cumulative_Direction := Root.Get_Direction &
                Embranchments_List (1).all.Get_Direction & ' ';

        else
            Next_Cumulative_Direction (1) := Root.Get_Direction;
            for I in 2 .. Nb_Path loop
                Next_Cumulative_Direction (Integer (I)) :=
                    Embranchments_List (Integer (I)).all.Get_Direction;
            end loop;

        end if;

        return Next_Cumulative_Direction;

    end Get_Cumulative_Direction;

    ----------------
    -- Update_Map --
    ----------------

    procedure Update_Map (Map : in out Maze_Map;
                          Root : Acc_Node;
                          Cumulative_Direction : String;
                          Translation_Table : Cumulative_Direction_Table.Map) is

        Nb_Path : Path_Embranchments :=
            Path_Embranchments (Root.Get_Embranchments.Length);

        Part : String (1 .. Unicode_Lenght) :=
            Cumulative_Direction_To_Unicode (Cumulative_Direction, Nb_Path,
                                             Translation_Table);

        Root_Coords : Point := Root.Get_Coordinates;
    begin

        if Root /= null then

            -- first direction is guaranted ╦ which is easier to create the
            -- cumulative_direction
            Modify (M => Map,
                    coords => Root_Coords,
                    Part => (if Root_Coords = (10, 1) then CR else Part));

            for E of Root.Get_Embranchments loop

                -- not optimised. It will Modify (uselessly) the part for every
                -- embranchments
                declare
                    Next_Cumulative_Direction : String (1 .. Unicode_Lenght) :=
                        Get_Cumulative_Direction (Root, Nb_Path);
                begin
                    Update_Map (Map, E, Cumulative_Direction, Translation_Table);
                end;
            end loop;

        end if;

    end Update_Map;


end controller;