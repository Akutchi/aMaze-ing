package body FourTree is

    function Get_Coordinates (N : Node) return Point is
    begin
        return N.Coords;
    end Get_Coordinates;

    function Get_Direction (N : Node) return Character is
    begin
        return N.Direction;
    end Get_Direction;

    function Get_Embranchments (N : Node) return NodeList.Vector is
    begin
        return N.Embranchments;
    end Get_Embranchments;

    procedure Set_Coords (N : in out Node;
                          Root_Coords : Point;
                          Displacement : Point)
    is
    begin

        N.Coords := (Root_Coords.x + Displacement.x,
                    Root_Coords.y + Displacement.y);

    end Set_Coords;

    procedure Set_Direction (N : in out Node; D : Character) is
    begin
        N.Direction := D;
    end Set_Direction;

    procedure Set_Embranchments (N : in out Node; L : NodeList.Vector) is
    begin
        N.Embranchments := L;
    end Set_Embranchments;

end FourTree;