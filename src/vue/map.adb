with Ada.Text_IO; use Ada.Text_IO;

package body Map is

    ------------
    -- Modify --
    ------------

    procedure Modify (M : in out Maze_Map; Coords : Point; Part : String) is

        -- there is a need for translation because what is seen as (x, y) in the
        -- model is (y, x) in the vue.
        X : Cols := Cols (coords.x);
        Y : Rows := Rows (coords.y);

    begin

        M.Representation (Y, X) := Part;

    end Modify;

    ----------
    -- Show --
    ----------

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