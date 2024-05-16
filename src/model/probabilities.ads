with Ada.Numerics.Discrete_Random;

package Probabilities is

    type Path_Embranchments is new Natural range 0 .. 3;
    package Random_Embranchment is new Ada.Numerics.Discrete_Random (Path_Embranchments);
    use Random_Embranchment;

    -- for Now uniform, but later one will be like the following :
    -- the PDf is
    --  1
    -- .9
    -- .8
    -- .7
    -- .6
    -- .5             -
    -- .4             -
    -- .3             -
    -- .2             -    -
    -- .1   -    -    -    -
    -- .0   -    -    -    -
    -- ---  0 -- 1 -- 2 -- 3 -- 4
    -----------------------------------------------
    function Draw_Random return Path_Embranchments;


end Probabilities;