with Unicode;

package Map is

    Size : Natural := 10;

    type Rows is new Natural range 1 .. Size;
    type Cols is new Natural range 1 .. 2*Size;

    type Point is
    record
        x : Rows;
        y : Cols;
    end record;

    type Maze_Map is tagged private;

    procedure Modify (M : in out Maze_Map; coords : Point; Part : String); -- a externaliser autre par dans le modèle
    procedure Show (M : Maze_Map);

private

    type Display is array (Rows, Cols) of String (1 .. Unicode.UCL'Length);

    type Maze_Map is
    tagged record

        Representation : Display := (
            1       => (1 => Unicode.UCL,   20 => Unicode.UCR,   others => Unicode.HB),
            10      => (1 => Unicode.LCL,   20 => Unicode.LCR,   others => Unicode.HB),
            others  => (1 => Unicode.VB,    20 => Unicode.VB,    others => Unicode.CR));

    end record;

end Map;