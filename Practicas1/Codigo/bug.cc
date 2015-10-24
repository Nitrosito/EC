#include <cstdlib>
#include <iostream>

int main()
{
	for (int i = 0; i < 100; ++i)
	{
		int a = rand() % 10, b = rand() % 10;

		std::cout << "a = " << a
		          << "\t b = " << b
		          << "\t a/b = " << a / b << std::endl;
	}
}
