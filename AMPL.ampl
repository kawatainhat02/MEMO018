## Example One
var PaintB;  # amount of blue
var PaintG;  # amount of gold
maximize profit: 10*PaintB + 15*PaintG;
subject to time: (1/40)*PaintB + (1/30)*PaintG <=  40;
subject to blue_limit: 0 <= PaintB <= 1000;
subject to gold_limit: 0 <= PaintG <= 860;


## Example Two - Model
param n;
param t;
param p{i in 1..n};
param r{i in 1..n};
param m{i in 1..n};
var paint{i in 1..n};
maximize profit: sum{i in 1..n} p[i]*paint[i];
subject to time: sum{i in 1..n} (1/r[i])*paint[i] <= t;
subject to capacity{i in 1..n}: 0 <= paint[i] <= m[i];
