with Map;           use Map;
with Probabilities; use Probabilities;

with Ada.Containers.Vectors;

package FourTree is

    type Node is tagged private;
    type Acc_Node is access all Node;

    package NodeList is new Ada.Containers.Vectors
      (Index_Type   => Positive,
       Element_Type => Acc_Node);
    use NodeList;

    function Get_Coordinates    (N : Node) return Point;
    function Get_Direction      (N : Node) return Character;
    function Get_Embranchments  (N : Node) return NodeList.Vector;

    procedure Set_Coordinates (N : in out Node;
                               Root_Coords : Point;
                               Displacement : Point);

    procedure Set_Direction (N : in out Node; D : Character);
    procedure Set_Embranchments (N : in out Node; L : NodeList.Vector);

private

    type Node is
    tagged record

        Coords : Point;
        Direction : Character;
        Embranchments : NodeList.Vector;

    end record;

end FourTree;