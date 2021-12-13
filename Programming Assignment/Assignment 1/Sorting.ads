--Sorting Package Specification

package Sorting is

Size: constant Integer := 40;

   
subtype Int_Range is Integer range 0 .. 500;
type Limited_Array is array (1..Size) of Int_Range;

Numbers_Array : Limited_Array;

procedure QSort(low, high: in Integer);

function Median(A,B,C : Integer) return Integer;

end Sorting;
