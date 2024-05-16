with Ada.Text_IO; use Ada.Text_IO;

with controller;    use controller;
with FourTree;      use FourTree;
with Map;           use Map;
with Unicode;       use Unicode;

procedure main is

    R   : Acc_Node := new Node;
    Map : Maze_Map;
    Translation_Table : Cumulative_Direction_Table.Map := Init_Map;
begin

    R.Set_Direction ('B');
    R.Set_Coords ((5, 1), (0, 0));
    Generate_Random_Map (R);

    Update_Map (Map, R, "D  ", Translation_Table);
    Show (Map);

end main;
