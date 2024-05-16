package FourTree is

    type Node is tagged private;
    type Acc_Node is access all Node;

    type DirectionList is array (Positive range 1 .. 4) of Acc_Node;

    function Get_Direction (N : Node) return Character;
    function Get_Embranchments (N : Node) return DirectionList;

    procedure Set_Direction (N : in out Node; D : Character);
    procedure Set_Embranchments (N : in out Node; L : DirectionList);

private

    type Node is
    tagged record

        Direction : Character;
        Embranchments : DirectionList;

    end record;

end FourTree;