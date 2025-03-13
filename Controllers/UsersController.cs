using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using UserManagement.API.Data.Repositories;
using UserManagement.API.Models;
using UserManagement.API.Models.DTOs;

namespace UserManagement.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserManagementController : ControllerBase
    {
        private readonly IUserRepository _repository;
        private readonly IMapper _mapper;
        private readonly ILogger<UserManagementController> _logger;

        public UserManagementController(IUserRepository repository, IMapper mapper, ILogger<UserManagementController> logger)
        {
            _repository = repository;
            _mapper = mapper;
            _logger = logger;
        }

        /// <summary>
        /// Lấy danh sách tất cả người dùng
        /// </summary>
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<UserReadDto>>> GetAllUsers()
        {
            try
            {
                var users = await _repository.GetAllUsersAsync();
                return Ok(new
                {
                    Success = true,
                    Data = _mapper.Map<IEnumerable<UserReadDto>>(users),
                    Message = "Lấy danh sách người dùng thành công"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi lấy danh sách người dùng");
                return StatusCode(500, new { Success = false, Message = "Lỗi server" });
            }
        }

        /// <summary>
        /// Lấy thông tin người dùng theo ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<UserReadDto>> GetUserById(int id)
        {
            try
            {
                var user = await _repository.GetUserByIdAsync(id);
                if (user == null)
                {
                    return NotFound(new { Success = false, Message = "Không tìm thấy người dùng" });
                }

                return Ok(new
                {
                    Success = true,
                    Data = _mapper.Map<UserReadDto>(user),
                    Message = "Lấy thông tin người dùng thành công"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi lấy thông tin người dùng {Id}", id);
                return StatusCode(500, new { Success = false, Message = "Lỗi server" });
            }
        }

        /// <summary>
        /// Tìm kiếm người dùng
        /// </summary>
        [HttpGet("Search")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<UserReadDto>>> SearchUsers([FromQuery] string searchTerm)
        {
            try
            {
                var users = await _repository.SearchUsersAsync(searchTerm);
                return Ok(new
                {
                    Success = true,
                    Data = _mapper.Map<IEnumerable<UserReadDto>>(users),
                    Message = "Tìm kiếm người dùng thành công"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi tìm kiếm người dùng với từ khóa {SearchTerm}", searchTerm);
                return StatusCode(500, new { Success = false, Message = "Lỗi server" });
            }
        }

        /// <summary>
        /// Tạo người dùng mới
        /// </summary>
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<UserReadDto>> CreateUser([FromBody] UserCreateDto userCreateDto)
        {
            try
            {
                var userModel = _mapper.Map<User>(userCreateDto);
                var newUser = await _repository.CreateUserAsync(userModel);
                var userReadDto = _mapper.Map<UserReadDto>(newUser);

                return CreatedAtAction(nameof(GetUserById), 
                    new { id = userReadDto.UserId }, 
                    new { Success = true, Data = userReadDto, Message = "Thêm người dùng thành công" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi tạo người dùng mới");
                return StatusCode(500, new { Success = false, Message = "Lỗi server" });
            }
        }

        /// <summary>
        /// Cập nhật thông tin người dùng
        /// </summary>
        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> UpdateUser(int id, [FromBody] UserUpdateDto userUpdateDto)
        {
            try
            {
                var userFromRepo = await _repository.GetUserByIdAsync(id);
                if (userFromRepo == null)
                {
                    return NotFound(new { Success = false, Message = "Không tìm thấy người dùng" });
                }

                _mapper.Map(userUpdateDto, userFromRepo);
                await _repository.UpdateUserAsync(userFromRepo);

                return Ok(new
                {
                    Success = true,
                    Data = _mapper.Map<UserReadDto>(userFromRepo),
                    Message = "Cập nhật thông tin người dùng thành công"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi cập nhật người dùng {Id}", id);
                return StatusCode(500, new { Success = false, Message = "Lỗi server" });
            }
        }

        /// <summary>
        /// Xóa người dùng
        /// </summary>
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteUser(int id)
        {
            try
            {
                var userFromRepo = await _repository.GetUserByIdAsync(id);
                if (userFromRepo == null)
                {
                    return NotFound(new { Success = false, Message = "Không tìm thấy người dùng" });
                }

                await _repository.DeleteUserAsync(id);
                return Ok(new { Success = true, Message = "Xóa người dùng thành công" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi xóa người dùng {Id}", id);
                return StatusCode(500, new { Success = false, Message = "Lỗi server" });
            }
        }
    }
}