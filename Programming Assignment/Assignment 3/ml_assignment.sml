Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(*Problem 1*)
fun insert x [] = [x]
    | insert x (y::ys) = if (x<y) then x::y::ys else y :: insert x ys

(*Problem 2*)
fun sort [] = []
    | sort (x::y) = insert x (sort y);
(*Problem 3*)

fun polySort (op <) [] = []
    | polySort (op <) (x::y) = 
        let fun polyInsert x [] = [x]
            | polyInsert x (h::t) =
                if(x<h) then x::h::t
                else h :: polyInsert x t
        in polyInsert x (polySort (op <) y)
        end

(* Problem 4 *)
fun fold (op +) [] b = b
    | fold (op +) (x::y) b = x + fold (op +) y b

(*Problem 5*)
datatype 'a tree = leaf of 'a | node of 'a tree list

(*Problem 6*)
fun fringe (leaf x) = [x]
    | fringe ( node a ) = fold (op @) (map (fringe) (a) ) []

(*Problem 7*)
fun mapTree f (leaf x) = leaf (f x)
    | mapTree f (node a) = node (map (mapTree f) a)

(*Problem 8*)
fun sortTree (op <) t = mapTree (polySort (op <)) t

(*Problem 9*)
fun mergeList (op <) L1 [] = L1 
    | mergeList (op <) [] L2 = L2
    | mergeList (op <) (x::y) (xs::ys) = 
        if(x < xs)
        then x :: mergeList (op <) y (xs::ys)
        else xs :: mergeList (op <) (x::y) ys


(*Problem 10*)
fun mergeTree (op <) t = polySort (op <) (fold (op @) (fringe t) [])

fun testFun x (xs::ys) = xs
fun ex1 h (x::xs) (y::ys) = (h x,y)::ex1 h xs ys


fun foo (op <) f g (x,y) z = if f(x,y) < g x then z + 1 else z - 1
fun comp F G = let fun C x = G(F(x)) in C end
fun ff f x y = if (f x y) then (f 3 y) else (f x "zero")
fun pow [] = [[]]
 |  pow (x::xs) = let val powxs = pow xs
                  in (map (fn mem => x::mem) powxs) @ powxs
                  end

fun map f [] = []
    | map f (x::xs) = f x :: map f xs

('a -> 'b list) -> ('b -> 'c list) -> ('c -> 'd) -> 'a -> 'd list
fun compose f h g x = [g(h (f x))]
fun ex2 x = ex2 x
infix ++;