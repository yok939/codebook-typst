union di 
{
	double d;
	unsigned long long i;
};
bool check(double);
double binary_search(double L, double R, int eps)
{
	di lf = {L}, ri = {R}, mid;
	while(ri.i - lf.i > 1ll << (52 - eps)) {
		mid.i = (lf.i + ri.i) >> 1;
		if(check(mid.d)) ri = mid;
		else lf = mid;	
	}
	return lf.d;
}
