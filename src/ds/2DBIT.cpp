#include <bits/stdc++.h>
using ll = long long;
#define pii pair<int, int>
#define pll pair<ll, ll>
#define N 1005
#define F first
#define S second
#define lb(x) (x & -x)
using namespace std;
int bit[N][N];
void upd(int i, int j, int v)
{
	for(; j < N; j += lb(j))
		for(int k = i; k < N; k += lb(k)) bit[k][j] += v;
}
int qry2(int i, int j)
{
	int ans = 0;
	for(; j; j += lb(j))
		for(int k = i; k; k += lb(k)) ans += bit[k][j];
	return ans;
}
int qry(int y1, int x1, int y2, int x2)
{
	return qry2(y2, x2) - qry2(y2, x1 - 1) - qry2(y1 - 1, x2) + qry2(y1 - 1, x1 - 1);
}
int main()
{
	// REMEMBER TO DO MEMSET
	memset(bit, 0, sizeof(bit)); 
	int n, q, i = 1, j, y, x;
}
