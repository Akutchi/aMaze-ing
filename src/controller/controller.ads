with Map;           use Map;
with FourTree;      use FourTree;
with Probabilities; use Probabilities;
with Unicode;       use Unicode;

package controller is

    procedure Generate_Random_Map   (Root : in out Acc_Node);
    procedure Update_Map            (M : in out Maze_Map);

private

    function Calculate_Displacement (Index  : Integer) return Point;
    function Int_To_Direction       (Number : Integer) return Character;
    function Is_In_Map              (Coords : Point) return Boolean;
    function Is_Finished            (Number : Path_Embranchments) return Boolean;

end controller;