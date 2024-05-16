with Ada.Text_IO; use Ada.Text_IO;

package body controller is

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

    function Int_To_Direction (Number : Integer) return Character is
    begin

        case Number is

            when 1      => return 'H';
            when 2      => return 'D';
            when 3      => return 'B';
            when 4      => return 'G';
            when others => return 'H';

        end case;
    end Int_To_Direction;

    function Is_In_Map (Coords : Point) return Boolean is

        Is_In_X : Boolean := Coords.x >= Integer (Rows'First) and
                             Coords.x <= Integer (Rows'Last);

        Is_In_Y : Boolean := Coords.y >= Integer (Cols'First) and
                             Coords.y <= Integer (Cols'Last);
    begin

        return Is_In_X and Is_In_Y;

    end Is_In_Map;

    function Is_Finished (Number : Path_Embranchments) return Boolean is
    begin
        return Number = 0;
    end Is_Finished;

    procedure Generate_Random_Map (Root : in out Acc_Node) is

        Coords : Point := Root.Get_Coordinates;

        Number_Of_Embranchments : Path_Embranchments := Draw_Random_Path_Number;

        Direction_List : Direction_Vector.Vector :=
            Draw_Random_Directions (Number_Of_Embranchments);

        Embranchments_List : NodeList.Vector;

    begin

        if Is_In_Map (Coords) and not Is_Finished (Number_Of_Embranchments) then

                for I of Direction_List loop

                    declare
                        Idx          : Integer := Integer (I);
                        T            : Acc_Node := new Node;
                        Displacement : Point := Calculate_Displacement (Integer (I));
                    begin
                        T.Set_Direction (Int_To_Direction (Idx));
                        T.Set_Coords (Coords, Displacement);
                        Generate_Random_Map (T);

                        Embranchments_List.Append (T);

                    end;

                    Root.Set_Embranchments (Embranchments_List);

                end loop;

        end if;

    end Generate_Random_Map;

    function Cumulative_Direction_To_Unicode (C_Dir : String;
                                              Nb_Path : Path_Embranchments;
                                              Translation_Table : Cumulative_Direction_Table.Map)
    return String is
    begin

        if Nb_Path = 0 then
            return ".";

        elsif Nb_Path = 3 then
            return "╬";
        end if;

        return Translation_Table (C_Dir);

    end Cumulative_Direction_To_Unicode;

    function Get_CD (Root : Acc_Node; Nb_Path : Path_Embranchments)
    return String is

        Next_Cumulative_Direction : String (1 .. 3);
        Embranchments_List : NodeList.Vector := Root.Get_Embranchments;
    begin

        if Nb_Path = 1 then
            Next_Cumulative_Direction :=
                Root.Get_Direction &
                Embranchments_List (1).all.Get_Direction'Image & " ";

        else
            Next_Cumulative_Direction (1) := Root.Get_Direction;
            for I in 2 .. Nb_Path loop
                Next_Cumulative_Direction (Integer (I)) :=
                    Embranchments_List (Integer (I)).all.Get_Direction;
            end loop;

        end if;

        return Next_Cumulative_Direction;

    end Get_CD;

    procedure Update_Map (Map : in out Maze_Map;
                          Root : Acc_Node;
                          Cumulative_Direction : String;
                          Translation_Table : Cumulative_Direction_Table.Map) is

        Nb_Path : Path_Embranchments :=
            Path_Embranchments (Root.Get_Embranchments.Length);
    begin

        if Root /= null then

            -- first direction is guaranted ║ which is easier to create the
            -- cumulative_direction
            Modify (M => Map,
                    coords => Root.Get_Coordinates,
                    Part => Cumulative_Direction_To_Unicode
                                (Cumulative_Direction, Nb_Path, Translation_Table));

            for E of Root.Get_Embranchments loop

                -- not optimised. It will Modify (uselessly) the part for every
                -- embranchments
                declare
                    Next_Cumulative_Direction : String (1 .. 3) :=
                        Get_CD (Root, Nb_Path);
                begin
                    Update_Map (Map, E, Cumulative_Direction, Translation_Table);
                end;
            end loop;

        end if;

    end Update_Map;


end controller;