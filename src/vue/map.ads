with Unicode; use Unicode;

package Map is

    Size : Natural := 10;

    type Rows is new Natural range 1 .. Size;
    type Cols is new Natural range 1 .. 2*Size;

    type Point is
    record
        x : Integer;
        y : Integer;
    end record;

    type Maze_Map is tagged private;

    procedure Modify (M : in out Maze_Map; coords : Point; Part : String);
    procedure Show (M : Maze_Map);

private

    type Display is array (Rows, Cols) of String (1 .. Unicode_Lenght);

    type Maze_Map is
    tagged record

        Representation : Display := (
            1       => (1 => UCL,   10 => CR,   20 => UCR,  others => HB),
            10      => (1 => LCL,   20 => LCR,              others => HB),
            others  => (1 => VB,    20 => VB,               others => PE));

    end record;

end Map;