with Map;           use Map;
with FourTree;      use FourTree;
with Probabilities; use Probabilities;
with Unicode;       use Unicode;

package controller is

    procedure Generate_Random_Map   (Root : in out Acc_Node);
    procedure Update_Map            (Map : in out Maze_Map;
                                     Root : Acc_Node;
                                     Cumulative_Direction : String;
                                     Translation_Table : Cumulative_Direction_Table.Map);

private

    function Calculate_Displacement (Index  : Integer) return Point;
    function Int_To_Direction       (Number : Integer) return Character;
    function Is_In_Map              (Coords : Point) return Boolean;
    function Is_Finished            (Number : Path_Embranchments) return Boolean;
    function Is_Not_Going_Back (Idx : Integer; Root : Acc_Node) return Boolean;

    function Cumulative_Direction_To_Unicode (C_Dir : String;
                                              Nb_Path : Path_Embranchments;
                                              Translation_Table : Cumulative_Direction_Table.Map)
    return String;

    function Get_Cumulative_Direction (Root : Acc_Node;
                                       Nb_Path : Path_Embranchments)
    return String;


end controller;