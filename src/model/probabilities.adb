package body Probabilities is

    function Draw_Random return Path_Embranchments is

        G : Generator;

    begin

        Reset (G);

        return Random(G);

    end Draw_Random;


end Probabilities;