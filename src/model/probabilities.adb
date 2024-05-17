package body Probabilities is


    function Inverse_CDF (U : Ada.Numerics.Float_Random.Uniformly_Distributed)
    return Path_Embranchments is

        Uf : Float := Float (U);
    begin

        if Uf >= 0.0 and Uf < 0.3 then
            return 0;

        elsif Uf >= 0.3 and Uf < 0.8 then
            return 1;

        elsif Uf >= 0.8 and Uf < 0.9 then
            return 2;

        else
            return 3;

        end if;

    end Inverse_CDF;

    function Draw_Random_Path_Number return Path_Embranchments is

        G : Ada.Numerics.Float_Random.Generator;
        U : Ada.Numerics.Float_Random.Uniformly_Distributed;

    begin

        Ada.Numerics.Float_Random.Reset (G);
        U := Ada.Numerics.Float_Random.Random (G);

        return Inverse_CDF (U);

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