function val=valfun(k)
global vlast beta delta theta k0 kt
g=interp1(k0,vlast,k,'linear');
kk=kt^theta-k+(1-delta)*kt;
if kk<=0
    val=-888-800*abs(kk);
else
    val=log(kk)+beta*g;
end
val=-val;