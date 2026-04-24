using Xunit;
using demo_api;

namespace demo_api.Tests;

public class UnitTests
{
    [Fact]
    public void TestAddSuccess()
    {
        Assert.Equal(3, UnitTest.Add(1, 2));
        Assert.Equal(0, UnitTest.Add(-1, 1));
        Assert.Equal(0, UnitTest.Add(0, 0));
    }

    [Fact]
    public void TestAddFailCase()
    {
        Assert.NotEqual(-1, UnitTest.Add(1, 2));
    }

    [Fact]
    public void TestBadAddSuccess()
    {
        Assert.NotEqual(3, UnitTest.BadAdd(1, 2));
    }
}