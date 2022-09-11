#ifndef KERNEL_H
#define KERNEL_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define VGA_BEGIN_ADDRESS 0xB8000
#define BUFFER_SIZE 2200

/* Hardware text mode color constants. */
enum colors {
 VGA_BLACK = 0,
 VGA_BLUE = 1,
 VGA_GREEN = 2,
 VGA_CYAN = 3,
 VGA_RED = 4,
 VGA_MAGENTA = 5,
 VGA_BROWN = 6,
 VGA_LIGHT_GREY = 7,
 VGA_DARK_GREY = 8,
 VGA_LIGHT_BLUE = 9,
 VGA_LIGHT_GREEN = 10,
 VGA_LIGHT_CYAN = 11,
 VGA_LIGHT_RED = 12,
 VGA_LIGHT_MAGENTA = 13,
 VGA_LIGHT_BROWN = 14,
 VGA_WHITE = 15,
};

typedef struct s_screen_vars {
  size_t	_screen_width;
  size_t	_screen_heigh;
  size_t	_screen_row;
  size_t	_screen_column;
  uint8_t	_screen_color;
  uint32_t	*_screen_ptr;
} t_screen_vars;

/* Function prototypes */

/* Init screen VGA */
void	init_screen(t_screen_vars *vars);

/* Utils */
uint16_t	set_entry(uint8_t uc, uint8_t color);

/* Print VGA mode */
void	printstr(const char *str);

#endif
