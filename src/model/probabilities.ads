with Ada.Numerics.Float_Random;
with Ada.Numerics.Discrete_Random;
with Ada.Containers.Vectors;

package Probabilities is

    type Path_Embranchments is new Natural range 0 .. 3;

    -- The convention is U = 1, R = 2, D = 3, L = 4
    type Directions is new Positive range 1 .. 4;

    package Direction_Vector is new Ada.Containers.Vectors
      (Index_Type   => Positive,
       Element_Type => Positive);
    use Direction_Vector;

    package Random_Direction is new
        Ada.Numerics.Discrete_Random (Directions);

    -- the PDF is
    --  1
    -- .9
    -- .8
    -- .7
    -- .6
    -- .5        -
    -- .4        -
    -- .3   -    -
    -- .2   -    -
    -- .1   -    -    -    -
    -- ---  0 -- 1 -- 2 -- 3 --
    ---------------------------

    -- the CDF is
    --  1                 -----
    -- .9            -----
    -- .8      ------
    -- .7      |
    -- .6      |
    -- .5      |
    -- .4      |
    -- .3 ------
    -- .2
    -- .1
    -- .0
    --    0 -- 1 -- 2 -- 3 -- 4
    ---------------------------

    function Draw_Random_Path_Number return Path_Embranchments;

    function Draw_Random_Directions (Number : Path_Embranchments)
    return Direction_Vector.Vector;

private

    function Inverse_CDF (U : Ada.Numerics.Float_Random.Uniformly_Distributed)
    return Path_Embranchments;


end Probabilities;