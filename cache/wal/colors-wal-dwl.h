/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x13122bff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc4c3caff, 0x13122bff, 0x626177ff },
	[SchemeSel]  = { 0xc4c3caff, 0x4349A5ff, 0x0662B0ff },
	[SchemeUrg]  = { 0xc4c3caff, 0x0662B0ff, 0x4349A5ff },
};
