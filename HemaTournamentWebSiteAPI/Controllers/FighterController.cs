using Microsoft.AspNetCore.Mvc;

namespace HemaTournamentWebSiteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FighterController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetAllFighters()
        {
            // Dummy data
            var fighters = new[]
            {
                new { Id = 1, Name = "Luca" },
                new { Id = 2, Name = "Giovanni" }
            };

            return Ok(fighters);
        }

    }
}
