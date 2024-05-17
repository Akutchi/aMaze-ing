package body Probabilities is

    -----------------
    -- Inverse_CDF --
    -----------------

    function Path_Inverse_CDF (U : Uniformly_Distributed)
    return Path_Embranchments is

        Uf : Float := Float (U);
    begin

        if Uf >= 0.0 and Uf < 0.1 then
            return 0;

        elsif Uf >= 0.1 and Uf < 0.5 then
            return 1;

        elsif Uf >= 0.5 and Uf < 0.9 then
            return 2;

        else
            return 3;

        end if;

    end Path_Inverse_CDF;

        -----------------
    -- Inverse_CDF --
    -----------------

    function Direction_Inverse_CDF (U : Uniformly_Distributed)
    return Directions is

        Uf : Float := Float (U);
    begin

        if Uf >= 0.0 and Uf < 0.1 then
            return 1;

        elsif Uf >= 0.1 and Uf < 0.3 then
            return 4;

        elsif Uf >= 0.3 and Uf < 0.5 then
            return 2;

        else
            return 3;

        end if;

    end Direction_Inverse_CDF;

    -----------------------------
    -- Draw_Random_Path_Number --
    -----------------------------

    function Draw_Random_Path_Number return Path_Embranchments is

        G : Generator;
        U : Uniformly_Distributed;

    begin

        Reset (G);
        U := Random (G);

        return Path_Inverse_CDF (U);

    end Draw_Random_Path_Number;

    ----------------------------
    -- Draw_Random_Directions --
    ----------------------------

    function Draw_Random_Directions (Number : Path_Embranchments)
    return Direction_Vector.Vector
    is

        G : Generator;
        U : Uniformly_Distributed;

        Is_Visited : array (Positive range 1 .. 4) of Boolean := (others => False);
        Dir_Array : Vector;
        Idx : Path_Embranchments := 0;
    begin

        Reset (G);

        while Idx < Number loop

            U := Random (G);

            declare
                Rnd_Dir : Directions := Direction_Inverse_CDF (U);
            begin

                if not Is_Visited (Integer (Rnd_Dir)) then
                    Dir_Array.Append (Rnd_Dir);
                    Is_Visited (Integer (Rnd_Dir)) := True;
                    Idx := Idx + 1;
                end if;
            end;

        end loop;

        return Dir_Array;

    end Draw_Random_Directions;


end Probabilities;