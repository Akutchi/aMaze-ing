package body FourTree is

    function Get_Direction (N : Node) return Character is
    begin
        return N.Direction;
    end Get_Direction;

    function Get_Embranchments (N : Node) return DirectionList is
    begin
        return N.Embranchments;
    end Get_Embranchments;

    procedure Set_Direction (N : in out Node; D : Character) is
    begin
        N.Direction := D;
    end Set_Direction;

    procedure Set_Embranchments (N : in out Node; L : DirectionList) is
    begin
        N.Embranchments := L;
    end Set_Embranchments;

end FourTree;