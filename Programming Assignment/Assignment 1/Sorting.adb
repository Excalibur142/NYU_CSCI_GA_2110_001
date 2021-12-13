--Sorting Package Body
with Text_Io;
use Text_Io;

package body Sorting is
    procedure QSort(low, high: in Integer) is
    M, I, J : integer;
    --Recursive Procedure
    procedure RecursiveCall is
    --Create Tasks to call
    Task CallOne is
        entry AcceptCall;
    end CallOne;
    Task CallTwo is
        entry AcceptCall;
    end CallTwo;

    --Create Recursive Task Body
    Task body CallOne is
    begin
        accept AcceptCall do
            QSort (low, I-1);
        end AcceptCall;
    end CallOne;
    Task body CallTwo is
    begin
        accept AcceptCall do
            QSort (J+1, high);
        end AcceptCall;
    end CallTwo;

    begin
        if(low >= high) then
            return;
        end if;
        --Define Split
        --If only two elements of array, get smallest value
        if(Numbers_Array'Length = 2) then
            if(Numbers_Array'First < Numbers_Array'Last) then
                M := Numbers_Array'First;
            else
                M:= Numbers_Array'Last;
            end if;
        else
            --Get Median of A(Low) A(High) and A((low+high)/2)
            M := Median (A => Numbers_Array(low), B => ((Numbers_Array(low)+Numbers_Array(high))/2), C => Numbers_Array(high));
        end if;
        I := low;
        J := high;
        while I < J loop
            while Numbers_Array(I) <= M loop
                I := I + 1;
            end loop;
            while Numbers_Array(J) > M loop
                J := J - 1;
            end loop;
            if I < J then
                declare
                temp : Integer;
                begin
                    temp := Numbers_Array(I);
                    Numbers_Array(I) := Numbers_Array(J);
                    Numbers_Array(J) := temp;
                end;
            end if;
        end loop;
        CallOne.AcceptCall;
        CallTwo.AcceptCall;
    end;
    --recursively call quicksort now for sequential 
    ----QSort (low => low, high => I-1);
    ----QSort (low => J+1, high => high);
    begin
        --Base Case for wrapper recursive procedure
        if(low < high) then
            RecursiveCall;
        end if; 
    end QSort;

    --Define Median
    Function Median(A,B,C : Integer) return Integer is
    begin
        if ((A < B and B < C) or (C < B and B < A)) then
            return B;
        elsif ((B < A and A < C) or (C < A and A < B)) then
            return A;
        else
            return C;
        end if;
    end;
end Sorting;


