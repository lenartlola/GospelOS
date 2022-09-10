#include "../../includes/kernel.h"

void set_cursor(t_screen_vars *s_vars, int c, uint8_t color, uint32_t x,
                uint32_t y) {
  const uint32_t index = y * 80 + x;
  s_vars->_screen_ptr[index] = set_entry(c, color);
}

uint16_t	set_entry(uint8_t uc, uint8_t color) {
  return (uint16_t)uc | (uint16_t)color << 8;
}
