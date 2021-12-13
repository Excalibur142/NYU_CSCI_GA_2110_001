
with Text_Io;
use Text_Io;

with Sorting;
use Sorting;


procedure objmain is

--Directive Space--

    package Int_Io is new integer_io(integer);
    use Int_Io;

    --(Define Printing task)
    task PrintingTask is
        entry BeginPrint;
        entry ContinueAdd(sum : integer);
    end PrintingTask;
    --(Define Sorting task)
    task SortingTask is
        entry BeginSort(bool:Boolean);
    end SortingTask;
    --(Define adding task)
    task AddingTask is
        entry BeginAdd(bool : Boolean);
    end AddingTask;
    --(Define ReadArray)
    procedure ReadArray(Array_To_Read : in out Limited_Array) is
    begin
        for I of Array_To_Read loop
            Get(I);
        end loop;
    end ReadArray;
    --(Define PrintArray)
    procedure PrintArray(Array_To_Print: in Limited_Array) is
    begin
        New_Line;
        Put("Printing Array: ");
        for I in 1..Array_To_Print'Length loop
            New_Line;
            Put(Array_To_Print(I));
        end loop;
    end PrintArray;
    
    --(Task Bodies)
    task body PrintingTask is
    begin
        accept BeginPrint do
            null;
        end BeginPrint;
        PrintArray (Numbers_Array);
        SortingTask.BeginSort(True);
        PrintArray (Numbers_Array);
        accept ContinueAdd(sum: integer) do 
            New_Line;
            Put("The Value of the Array Summed is: " & Sum'Image);
        end ContinueAdd;
    end PrintingTask;
    
    task body SortingTask is
    begin
        accept BeginSort(bool : Boolean) do 
            if bool = True then
                QSort (low => Numbers_Array'First, high => Numbers_Array'Last);
            end if;
        end BeginSort;
        AddingTask.BeginAdd(True);
    end SortingTask;
    
    task body AddingTask is
    Sum_Value : Integer := 0;
    begin
        accept BeginAdd(bool: Boolean) do
            if (bool = True) then
                for I of Numbers_Array loop
                    Sum_Value := Sum_Value + I;
                end loop;
            end if;
        end BeginAdd;
        PrintingTask.ContinueAdd(Sum_Value);
    end AddingTask;
--End Directive Space--


begin
--(Read Numbers into Program) -> store them in sorting array 
ReadArray(Numbers_Array);
--(Run printing task -> Should start after numbers are read)
PrintingTask.BeginPrint;
--(Run adding task -> handled by entries)
--(Run Sorting task -> handled by entries)


end objmain;