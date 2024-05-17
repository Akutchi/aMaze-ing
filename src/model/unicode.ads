with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

package Unicode is

   WS : constant String := "─";

   HB : constant String := "═";
   VB : constant String := "║";

   UCL : constant String := "╔";
   UCR : constant String := "╗";
   LCL : constant String := "╚";
   LCR : constant String := "╝";

   TL : constant String := "╣";
   TR : constant String := "╠";
   TU : constant String := "╩";
   TD : constant String := "╦";

   CR : constant String := "╬";

   Unicode_Lenght : constant Integer := WS'Length;

   function Equ_Keys(Left  : String;
                     Right : String)
                     return Boolean;

   package Cumulative_Direction_Table is new Ada.Containers.Indefinite_Hashed_Maps
   (Key_Type        => String,
      Element_Type    => String,
      Hash => Ada.Strings.Hash,
      Equivalent_Keys => Equ_Keys);
   use Cumulative_Direction_Table;

   function Init_Map return Cumulative_Direction_Table.Map;

end Unicode;