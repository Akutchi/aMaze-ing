with Ada.Text_IO; use Ada.Text_IO;

with controller;    use controller;
with FourTree;      use FourTree;
with Map;           use Map;
with Unicode;       use Unicode;

with Probabilities; use Probabilities;

procedure main is

    procedure Go_Deep (Root : Acc_Node) is
    begin

        if Root /= null then

            Put_Line ("* " & Root.Get_Direction'Image);
            for E of Root.Get_Embranchments loop
                Put (E.Get_Direction'Image & " ");
            end loop;
            Put_Line ("");

            for E of Root.Get_Embranchments loop
                Go_Deep (E);
            end loop;
        end if;

    end Go_Deep;

    Entry_Point : Acc_Node := new Node;
    Map : Maze_Map;
    Translation_Table : Cumulative_Direction_Table.Map := Init_Map;
begin

    Entry_Point.Set_Direction ('D');
    Entry_Point.Set_Coordinates ((10, 1), (0, 0));
    Generate_Random_Map (Entry_Point);

    Go_Deep (Entry_Point);

    Update_Map (Map, Entry_Point, "D  ", Translation_Table);
    Show (Map);

end main;
