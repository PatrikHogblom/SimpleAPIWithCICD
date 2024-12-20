using Microsoft.EntityFrameworkCore;

namespace SimpleAPIWith_CICD.Models
{
    public class TodoContext : DbContext
    {
        public TodoContext(DbContextOptions<TodoContext> options) : base(options)
        {
            
        }

        public DbSet<TodoItem> TodoItems { get; set; } = null!;
    }
}
