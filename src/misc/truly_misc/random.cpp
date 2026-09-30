#include <random>
#ifdef __unix__
std::random_device rd;
std::mt19937_64 RNG(rd());
#else 
const auto SEED = chrono::high_resolution_clock::now()
				  .time_since_epoch()
				  .count();
std::mt19937_64 RNG(SEED);
#endif
