static const char *background_color = "#1d2021";  // Gruvbox bg0
static const char *border_color     = "#3c3836";  // Gruvbox fg
static const char *font_color       = "#ebdbb2";  // Gruvbox fg
static const char *font_pattern     = "CaskaydiaMonoNerdFont-Bold:size=13";

static const unsigned line_spacing = 5;
static const unsigned int padding = 15;

static const unsigned int width = 450;
static const unsigned int border_size = 1;
static const unsigned int pos_x = 10;
static const unsigned int pos_y = 10;

enum corners { TOP_LEFT, TOP_RIGHT,TOP_CENTER, BOTTOM_LEFT, BOTTOM_CENTER, BOTTOM_RIGHT };
enum corners corner = BOTTOM_RIGHT;

static const unsigned int duration = 5; /* in seconds */

#define DISMISS_BUTTON Button1
#define ACTION_BUTTON Button3
