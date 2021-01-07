using Xunit;
using Microsoft.Extensions.Logging;
using BackendService2.Controllers;
using Moq;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace BackendService2.Tests
{
    public class ChennaiControllerTest
    {
        private readonly Mock<ILogger<ChennaiController>> _loggerMock;
        private readonly Mock<HttpContext> _contextMock;

        public ChennaiControllerTest()
        {
            _loggerMock = new Mock<ILogger<ChennaiController>>();
            _contextMock = new Mock<HttpContext>();
        }

        [Fact]
        public void Test1()
        {
            var chennaiController = new ChennaiController(_loggerMock.Object);
            chennaiController.ControllerContext.HttpContext = _contextMock.Object;

            var actionResult = chennaiController.Get();

            var apiResult = Assert.IsAssignableFrom<IEnumerable<WeatherForecast>>(actionResult);
        }
    }
}
