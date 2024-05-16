package body Unicode is


    function Equ_Keys(Left  : String; Right : String) return Boolean is
    begin
      return Left = Right;
    end Equ_Keys;

    function Init_Map return Cumulative_Direction_Table.Map is
        Translation_Table : Cumulative_Direction_Table.Map;
    begin
        Translation_Table.Insert ("D  ", Unicode.VB);
        Translation_Table.Insert ("U  ", Unicode.VB);
        Translation_Table.Insert ("L  ", Unicode.HB);
        Translation_Table.Insert ("R  ", Unicode.HB);

        Translation_Table.Insert ("DD ", Unicode.VB);
        Translation_Table.Insert ("UU ", Unicode.VB);
        Translation_Table.Insert ("LL ", Unicode.HB);
        Translation_Table.Insert ("RR ", Unicode.HB);

        Translation_Table.Insert ("DL ", Unicode.LCR);
        Translation_Table.Insert ("DR ", Unicode.LCL);
        Translation_Table.Insert ("UL ", Unicode.UCR);
        Translation_Table.Insert ("UR ", Unicode.UCL);


        Translation_Table.Insert ("ULD", Unicode.TL);
        Translation_Table.Insert ("DLU", Unicode.TL);

        Translation_Table.Insert ("URD ", Unicode.TR);
        Translation_Table.Insert ("DRU",  Unicode.TR);

        Translation_Table.Insert ("LUR", Unicode.TU);
        Translation_Table.Insert ("RUL", Unicode.TU);

        Translation_Table.Insert ("LDR", Unicode.TD);
        Translation_Table.Insert ("RDL", Unicode.TD);

        return Translation_Table;
    end Init_Map;

end Unicode;