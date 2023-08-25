dataprop FACT (int, int) =
   | FACTbas (0, 1)             // basic case: FACT(0, 1)
   | {n:int | n > 0} {r,r1:int} // inductive case
     FACTind (n, r) of (FACT (n-1, r1), MUL (n, r1, r))

       [FACT (n, r)] implies [fact (n) = r]
 [MUL (n, m, prod)] implies [n * m = prod]

       #include "share/atspre_staload.hats"

dataprop FACT (int, int) =
  | FACTbas (0, 1) of () // basic case
  | {n:nat}{r:int}       // inductive case
    FACTind (n+1, (n+1)*r) of (FACT (n, r))

(* note that int(x) , also int x, is the monovalued type of the int x value.

 The function signature below says:
 forall n:nat, exists r:int where fact( num: int(n)) returns (FACT (n, r) | int(r)) *)

fun fact{n:nat} .<n>. (n: int (n)) : [r:int] (FACT (n, r) | int(r)) =
(
  ifcase
  | n > 0 => ((FACTind(pf1) | n * r1)) where 
  { 
    val (pf1 | r1) = fact (n-1)
  }
  | _(*else*) => (FACTbas() | 1)
      )

      implement main0 (argc, argv) =
{
  val () = if (argc != 2) then prerrln! ("Usage: ", argv[0], " <integer>")

  val () = assert (argc >= 2)
  val n0 = g0string2int (argv[1])
  val n0 = g1ofg0 (n0)
  val () = assert (n0 >= 0)
  val (_(*pf*) | res) = fact (n0)

  val ((*void*)) = println! ("fact(", n0, ") = ", res)
}

val x : @(int, char) = @(15, 'c')  // x.0 = 15 ; x.1 = 'c'
  val @(a, b) = x                    // pattern matching binding, a= 15, b='c'
  val x = @{first=15, second='c'}    // x.first = 15
  val @{first=a, second=b} = x       // a= 15, b='c'
  val @{second=b, ...} = x           // with omission, b='c'
    
