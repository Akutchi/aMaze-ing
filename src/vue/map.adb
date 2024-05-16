with Ada.Text_IO; use Ada.Text_IO;

package body Map is

    procedure Modify (M : in out Maze_Map; Coords : Point; Part : String) is

        X : Rows := Rows (coords.x);
        Y : Cols := Cols (coords.y);
    begin

        M.Representation (X, Y) := Part;

    end Modify;

    procedure Show (M : Maze_Map) is
    begin

        for R in Rows loop
            for C in Cols loop

                Put (M.Representation (R, C));
            end loop;
                Put_Line ("");
        end loop;

    end Show;

end Map;