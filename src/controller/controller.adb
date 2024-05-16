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

        Number_Of_Embranchments : Path_Embranchments :=
                    Draw_Random;

        Embranchments_List : DirectionList := (null, null, null, null);

    begin

        if Is_In_Map (Coords) and not Is_Finished (Number_Of_Embranchments) then

                for I in 1 .. Number_Of_Embranchments loop

                    declare
                        Idx          : Integer := Integer (I);
                        T            : Acc_Node := new Node;
                        Displacement : Point := Calculate_Displacement (Integer (I));
                    begin
                        T.Set_Direction (Int_To_Direction (Idx));
                        T.Set_Coords (Coords, Displacement);
                        Generate_Random_Map (T);

                        Embranchments_List (Idx) := T;

                    end;

                    Root.Set_Embranchments (Embranchments_List);

                end loop;

        end if;

    end Generate_Random_Map;


    procedure Update_Map (M : in out Maze_Map) is
    begin

        null;

    end Update_Map;


end controller;