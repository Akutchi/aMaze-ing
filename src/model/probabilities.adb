package body Probabilities is

    function Draw_Random_Path_Number return Path_Embranchments is

        G : Random_Embranchment.Generator;

    begin

        Random_Embranchment.Reset (G);

        return Random_Embranchment.Random (G);

    end Draw_Random_Path_Number;

    function Draw_Random_Directions (Number : Path_Embranchments)
    return Direction_Vector.Vector
    is

        G : Random_Direction.Generator;
        Is_Visited : array (Positive range 1 .. 4) of Boolean := (others => False);
        Dir_Array : Vector;
        Idx : Path_Embranchments := 0;
    begin

        Random_Direction.Reset (G);

        while Idx < Number loop

            declare
                Rnd_Dir : Integer := Integer (Random_Direction.Random (G));
            begin

                if not Is_Visited (Rnd_Dir) then
                    Dir_Array.Append (Rnd_Dir);
                    Is_Visited (Rnd_Dir) := True;
                    Idx := Idx + 1;
                end if;
            end;

        end loop;

        return Dir_Array;

    end Draw_Random_Directions;


end Probabilities;