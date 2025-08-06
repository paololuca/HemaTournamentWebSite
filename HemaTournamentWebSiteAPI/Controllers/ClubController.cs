using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace HemaTournamentWebSiteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ClubController : ControllerBase
    {
        [HttpGet("all")]
        public IActionResult GetAllClubs()
        {
            // Dummy data
            var club = new[]
            {
                new { Id = 1, Name = "Bononia" },
                new { Id = 2, Name = "Roma" }
            };

            return Ok(club);
        }

        [HttpGet("first")]
        public IActionResult TestSingleClub()
        {
            // Dummy data
            var club = new[]
            {
                new { Id = 1, Name = "Bononia" },
                new { Id = 2, Name = "Roma" }
            };

            return Ok(club.First());
        }

        [HttpGet("{id}")]
        public IActionResult GetClubById(int id)
        {
            // Dummy data
            var club = new { Id = id, Name = "Club " + id };

            if (club == null)
            {
                return NotFound();
            }

            return Ok(club);
        }
    }
}
