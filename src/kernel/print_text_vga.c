#include "../../includes/kernel.h"

// Print line
void	printstr(const char *str) {
	uint16_t	*video_ptr = (uint16_t *)VGA_BEGIN_ADDRESS;

	for (int i = 0; str[i] != '\0'; ++i) {
		video_ptr[i] = (video_ptr[i] & 0xFF00) | str[i];
	}
}
