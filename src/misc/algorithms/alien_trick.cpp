// min dp[i] value and its i (smallest one)
pll get_dp(int cost);
ll aliens(int k, int lf, int ri)
{
	while(lf != ri)
	{
		int mid = (lf + ri) / 2;
		auto [f, s] = get_dp(mid);
		if(s == k) return f - mid + k;
		if(s < k) ri = mid;
		else lf = mid + 1;
	}
	return get_dp(lf).F - lf + k;
}
