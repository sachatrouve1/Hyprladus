static const char norm_fg[] = "#c4c3ca";
static const char norm_bg[] = "#13122b";
static const char norm_border[] = "#626177";

static const char sel_fg[] = "#c4c3ca";
static const char sel_bg[] = "#0662B0";
static const char sel_border[] = "#c4c3ca";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
};
