with Ada.Text_IO; use Ada.Text_IO;

with controller; use controller;
with FourTree;   use FourTree;

procedure main is

    R : Acc_Node := new Node;
begin

    R.Set_Direction ('B');
    R.Set_Coords ((1, 5), (0, 0));
    Generate_Random_Map (R);

end main;
