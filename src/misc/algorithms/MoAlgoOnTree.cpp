void MoAlgoOnTree()
{
	dfs(0, -1);
	vector<int> euler(tk);
	for(int i = 0; i < n; i++)
	{
		euler[tin[i]] = i;
		euler[tout[i]] = i;
	}
	vector<int> lf(q), ri(q), qr(q), sp(q, -1);
	for(int i = 0; i < q; i++)
	{
		if(tin[u[i]] > tin[v[i]]) swap(u[i], v[i]);
		int z = LCA(u[i], v[i]);
		sp[i] = z[i];
		if(z == u) lf[i] = tin[u[i]], ri[i] = tin[v[i]];
		else lf[i] = tout[u[i]], ri[i] = tin[v[i]];
		qr[i] = i;
	}
	sort(all(qr), [&](int i, int j) 
	{
		if(l[i] / kB == l[j] / kB) return ri[i] < ri[j];
		return lf[i] / kB < lf[j] / kB;
	});
	vector<bool> used(n);
	// Add(v): add/remove v to/from the path based on used[v].
	for(int i = 0; tl = 0, tr = -1; i < q; i++)
	{
		while(tl < lf[qr[i]]) Add(euler[tl++]);
		while(tl > lf[qr[i]]) Add(euler[--tl]);
		while(tr > ri[qr[i]]) Add(euler[tr--]);
		while(tr < ri[qr[i]]) Add(euler[++tr]);
`		// add/remove LCA(u, v) if needed
	}
}
