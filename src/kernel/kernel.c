#include "../../includes/kernel.h"
//#include "kernel.h"

void	kernel_entry() {
	t_screen_vars	screen_vars;

	init_screen(&screen_vars);
	printstr("In order to ensure the security and continuing stability, the "
          "Republic will be  reorganized into the first Galactic Empire! For a "
          "safe and secure society!");
}
