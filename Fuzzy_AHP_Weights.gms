* Fuzzy AHP Implementation in GAMS with Consistency Calculations and Sensitivity Analysis

* Sets and Aliases
SET
    i / LST, HealthAcc, Income, Humidity, NDVI, PopDen, BD /;
* CVDInc is omitted

ALIAS (i,j,k);

* Number of criteria
SCALAR n 'Number of criteria';
n = CARD(i);

* Initialize all elements to 1
PARAMETER
    al(i,j) 'Lower bound of fuzzy pairwise comparison matrix',
    am(i,j) 'Most likely value of fuzzy pairwise comparison matrix',
    au(i,j) 'Upper bound of fuzzy pairwise comparison matrix';

al(i,j) = 1;
am(i,j) = 1;
au(i,j) = 1;

* Adjusted Pairwise Comparison Values
* Comparisons involving LST
al('LST','HealthAcc')  = 2.0; am('LST','HealthAcc')  = 3.0; au('LST','HealthAcc')  = 4.0;
al('LST','Income')     = 1.5; am('LST','Income')     = 2.5; au('LST','Income')     = 3.5;
al('LST','Humidity')   = 1.5; am('LST','Humidity')   = 2.0; au('LST','Humidity')   = 2.5;
al('LST','NDVI')       = 0.7; am('LST','NDVI')       = 1.0; au('LST','NDVI')       = 1.5;
al('LST','PopDen')     = 0.7; am('LST','PopDen')     = 1.0; au('LST','PopDen')     = 1.5;
al('LST','BD')        = 1.5; am('LST','BD')        = 2.5; au('LST','BD')        = 3.5;

* Comparisons involving HealthAcc
al('HealthAcc','Income')   = 0.7; am('HealthAcc','Income')   = 1.0; au('HealthAcc','Income')   = 1.5;
al('HealthAcc','Humidity') = 0.5; am('HealthAcc','Humidity') = 0.8; au('HealthAcc','Humidity') = 1.2;
al('HealthAcc','NDVI')     = 0.4; am('HealthAcc','NDVI')     = 0.5; au('HealthAcc','NDVI')     = 0.8;
al('HealthAcc','PopDen')   = 0.7; am('HealthAcc','PopDen')   = 1.0; au('HealthAcc','PopDen')   = 1.5;
al('HealthAcc','BD')      = 0.8; am('HealthAcc','BD')      = 1.2; au('HealthAcc','BD')      = 1.8;

* Comparisons involving Income
al('Income','Humidity')  = 0.7; am('Income','Humidity')  = 1.0; au('Income','Humidity')  = 1.5;
al('Income','NDVI')      = 0.6; am('Income','NDVI')      = 0.8; au('Income','NDVI')      = 1.2;
al('Income','PopDen')    = 0.8; am('Income','PopDen')    = 1.2; au('Income','PopDen')    = 1.8;
al('Income','BD')       = 1.0; am('Income','BD')       = 1.5; au('Income','BD')       = 2.0;

* Comparisons involving Humidity
al('Humidity','NDVI')      = 0.8; am('Humidity','NDVI')      = 1.2; au('Humidity','NDVI')      = 1.8;
al('Humidity','PopDen')    = 0.5; am('Humidity','PopDen')    = 0.8; au('Humidity','PopDen')    = 1.2;
al('Humidity','BD')       = 0.3; am('Humidity','BD')       = 0.5; au('Humidity','BD')       = 0.8;

* Comparisons involving NDVI
al('NDVI','PopDen')    = 0.7; am('NDVI','PopDen')    = 1.0; au('NDVI','PopDen')    = 1.5;
al('NDVI','BD')         = 0.5; am('NDVI','BD')         = 0.8; au('NDVI','BD')         = 1.0;

* Comparisons involving PopDen and BD
al('PopDen','BD')     = 1.0; am('PopDen','BD')     = 1.2; au('PopDen','BD')     = 1.8;

* Assign reciprocals for the lower triangle
LOOP((i,j)$(ORD(i) < ORD(j)),
    al(j,i) = 1 / au(i,j);
    am(j,i) = 1 / am(i,j);
    au(j,i) = 1 / al(i,j);
);

* Ensure the diagonal elements are 1
al(i,i) = 1;
am(i,i) = 1;
au(i,i) = 1;

* Compute total sums for fuzzy synthetic extents
SCALAR sum_al, sum_am, sum_au;
sum_al = SUM((i,j), al(i,j));
sum_am = SUM((i,j), am(i,j));
sum_au = SUM((i,j), au(i,j));

* Compute the fuzzy synthetic extent value for each criterion
PARAMETER S_l(i), S_m(i), S_u(i);
S_l(i) = SUM(j, al(i,j)) / sum_au;
S_m(i) = SUM(j, am(i,j)) / sum_am;
S_u(i) = SUM(j, au(i,j)) / sum_al;

* Compute the degree of possibility
PARAMETER d(i,j);
LOOP(i,
  LOOP(j$(NOT SAMEAS(i,j)),
    IF (S_m(i) >= S_m(j),
        d(i,j) = 1;
    ELSEIF S_l(j) >= S_u(i),
        d(i,j) = 0;
    ELSE
        d(i,j) = (S_l(j) - S_u(i)) / ((S_m(i) - S_u(i)) - (S_m(j) - S_l(j)));
        d(i,j)$(d(i,j) < 0) = 0;
        d(i,j)$(d(i,j) > 1) = 1;
    );
  );
);

* Compute the minimum degree of possibility
PARAMETER d_min(i);
d_min(i) = smin(j$(NOT SAMEAS(i,j)), d(i,j));

* Normalize the weights
PARAMETER w(i);
w(i) = d_min(i) / SUM(k, d_min(k));

* Consistency Checking
PARAMETER a_def(i,j), colSum(j), a_norm(i,j), w_def(i), z(i), lambda_max, CI, CR, RI;

* Defuzzify matrix
a_def(i,j) = (al(i,j) + am(i,j) + au(i,j)) / 3;

* Column sums
colSum(j) = SUM(i, a_def(i,j));
a_norm(i,j) = a_def(i,j) / colSum(j);

* Priority vector
w_def(i) = SUM(j, a_norm(i,j)) / n;

* Weighted sum
z(i) = SUM(j, a_def(i,j) * w_def(j));
lambda_max = SUM(i, z(i) / w_def(i)) / n;

* Consistency index and ratio
CI = (lambda_max - n) / (n - 1);
RI = 1.24;
CR = CI / RI;

* Display results
DISPLAY S_l, S_m, S_u, d_min, w, lambda_max, CI, CR;
