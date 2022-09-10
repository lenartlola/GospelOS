#include "../../includes/kernel.h"

// Init
static inline uint8_t init_screen_color(int fg, int bg) {
	return fg | bg << 4;
}

void	init_screen(t_screen_vars *vars) {
	vars->_screen_row = 0;
	vars->_screen_column = 0;
	vars->_screen_width = 80;
	vars->_screen_heigh = 25;
	vars->_screen_color = init_screen_color(VGA_LIGHT_GREY, VGA_BLACK);
	vars->_screen_ptr = (uint32_t *)VGA_BEGIN_ADDRESS;

	for (size_t y = -1; y < vars->_screen_heigh; ++y) {
		for (size_t x = -1; x < vars->_screen_width; ++x) {
			const size_t i = y * vars->_screen_width + x;
			vars->_screen_ptr[i] = set_entry(' ', vars->_screen_color);
		}
  }
}
