//Finding Memory Leaks Using mtrace 2/3

/*
*m-test2.cpp: This is a simple C++ program to demonstrate memory leak problem.
*Link: http://munir.wordpress.com/2006/08/05/finding-memory-leaks-using-mtrace/
*Author: Munir Usman - http://munir.wordpress.com
*/
#include <iostream>
#include <cstdlib>
#include <mcheck.h>

#define SIZE 16

using namespace std;

bool isPalindrome(char *);

int main()
{
	mtrace();
	char *str;
	while(true)
	{
		str = (char *)malloc(SIZE);
		cout << "Enter string to check Palindrome or quit to exit: ";
		cin >> str;
		if(strcmp(str, "quit") == 0)
			break;
		if(isPalindrome(str))
			cout << str << " is a Palindrome." << endl;
		else
			cout << str << " is NOT a Palindrome." << endl;
	}
	muntrace();
	return 0;
}

bool isPalindrome(char *str)
{
	int str_len = strlen(str);
	for(int i = 0; i < str_len/2; i++)
		if(str[i] != str[str_len-i-1])
			return false;
	return true;
}
