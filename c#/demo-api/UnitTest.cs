namespace demo_api;

public class UnitTest
{
    public static int Add(int a, int b)
    {
        return a + b;
    }

    public static int BadAdd(int a, int b)
    {
        return a - b;
    }
}