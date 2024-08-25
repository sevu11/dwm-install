/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  		= 4;        	/* border pixel of windows */
static const unsigned int snap      		= 32;       	/* snap pixel */
static const unsigned int gappih    		= 16;       	/* horiz inner gap between windows */
static const unsigned int gappiv    		= 16;       	/* vert inner gap between windows */
static const unsigned int gappoh    		= 16;       	/* horiz outer gap between windows and screen edge */
static const unsigned int gappov    		= 16;       	/* vert outer gap between windows and screen edge */
static int smartgaps          				= 0;        	/* 1 */
static const unsigned int systraypinning 	= 0;   			/* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  	= 0;   			/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing 	= 6;   			/* systray spacing */
static const int systraypinningfailfirst 	= 1;   			/* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        		= 1;        	/* 0 means no systray */
static const int showbar            		= 1;        	/* 0 means no bar */
static const int topbar             		= 1;        	/* 0 means bottom bar */
static const int focusedontoptiled  		= 1;        	/* 1 means focused tile client is shown on top of floating windows */

static const char *fonts[]                	= { 
//"fontawesome:size=15", 
"FiraCode Nerd Font Mono:size=15", 
//"JetBrains Mono: size=15",
//"MesloLGS Nerd Font Mono:size=15", 
"NotoColorEmoji:pixelsize=15:antialias=true:autohint=true"  
};

static const char dmenufont[]       		= "monospace:size=10";
/* Old color scheme (commented out)
static const char col_gray1[]      			= "#00141d";
static const char col_gray2[]       		= "#80bfff";
static const char col_gray3[]       		= "#FFFFFF";
static const char col_gray4[]       		= "#1a1a1a";
static const char col_cyan[]        		= "#b3e5fc"; 	// was #6CF982
static const char col_barbie[]      		= "#4fc3f7";
static const char *colors[][3]      		= {
	//               fg         bg         border   
	[SchemeNorm] = { col_gray3, col_gray1, col_gray4 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_barbie  },
};
*/

// New color scheme
static const char normbordercolor[]       = "#3B4252";
static const char normbgcolor[]           = "#2E3440";
static const char normfgcolor[]           = "#D8DEE9";
static const char selbordercolor[]        = "#434C5E";
static const char selbgcolor[]            = "#434C5E";
static const char selfgcolor[]            = "#ECEFF4";

static const char *colors[][3]      = {
	/*               fg           bg           border   */
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
	[SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;

const char *spcmd1[] = {"st", "-n", "spterm1", "-g", "100x34", "-e", "pulsemixer", NULL };
const char *spcmd2[] = {"kitty", "--class", "spterm2", "--title", "ranger", "-e", "ranger", NULL };

static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm1",      spcmd1},
	{"spterm2",      spcmd2},
};

static const char *const autostart[] = {
/* 	function														arrange arguments */
	"sh", 															"-c", "~/.scripts/autostart.sh", NULL,
  	"dbus-update-activation-environment", 							"--systemd", "--all", NULL,
  	"/usr/lib/mate-polkit/polkit-mate-authentication-agent-1", 		NULL,
// 	"slstatus", 													NULL,
 	"dwmblocks", 													NULL,
 	"xset", 														"s", "off", NULL,
 	"xset", 														"s", "noblank", NULL,
 	"xset",															"-dpms", NULL,
	"flameshot", 													NULL,
 	"dunst", 														NULL,
 	"picom", 														"--animations", "-b", NULL,
 	"sh", 															"-c", "feh --randomize --bg-fill /home/$USER/Pictures/background/*", NULL,
  	NULL 															/* terminate */
};


/* tagging */
//static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
static const char *tags[] = { "", "", "󰈹", "󰙯", "󰓓" };

// static const Rule rules[] = {
// 	/* xprop(1):
// 	 *	WM_CLASS(STRING) = instance, class
// 	 *	WM_NAME(STRING) = title
// 	 */

// 	/* class      			instance    title       tags mask     isfloating   alwaysontop	monitor */
// 	{ "Gimp",     			NULL,       NULL,       1 << 8,         0,          0,			-1 		},
// 	{ "GitHub Desktop", 	NULL,       NULL,       1 << 1,         0,          0,			-1 		},
// 	{ "obs",				NULL,       NULL,       1 << 9,       	0,          0,			-1 		},
// 	{ "discord",  			NULL,       NULL,       1 << 7,       	0,          0,			-1 		},
// 	{ "mpv",  				NULL,       NULL,       0,       		1,          0,			-1 		},
// 	{ "qimgv",    			NULL,       NULL,       0,     		  	1,          0,			-1 		},
// 	{ "Galculator",   		NULL,       NULL,       0,       		1,          0,			-1 		},
// 	{ "Lxappearance",   	NULL,       NULL,       0,       		1,          0,			-1 		},
// 	{ "Pavucontrol",  		NULL,       NULL,       0,       		1,          0,			-1 		},
// 	{ "kitty", 				NULL,       NULL,       0,       		1,          0,			-1 		},
// 	{ NULL,		  			"spterm1",	NULL,		SPTAG(0),  		1,    		-1 					},
// 	{ NULL,		  			"spterm2",	NULL,		SPTAG(1),  		1,			-1 					},
// };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     		instance  title 	tags mask  isfloating  isterminal  noswallow  monitor */
	{ "St",      		NULL,     NULL,   	1 << 0,    0,          1,          0,        	-1 },
	{ "kitty",   		NULL,     NULL,   	1 << 0,    0,          1,          0,        	-1 },
	{ "alacritty",   	NULL,     NULL,   	1 << 0,    0,          1,          0,        	-1 },
	{ "terminator",	 	NULL,     NULL,   	1 << 0,    0,          1,          0,        	-1 },
	{ "discord",		NULL,     NULL,   	1 << 3,    0,          0,          1,        	-1 },
	{ "Lutris",			NULL,     NULL,   	1 << 4,    0,          0,          1,        	-1 },
	{ "steam",			NULL,     NULL,   	1 << 4,    0,          0,          1,        	-1 },
	{ "firefox",		NULL,     NULL,   	1 << 2,    0,          0,          1,        	-1 },
	{ "Sublime_text",	NULL,     NULL,   	1 << 1,    0,          0,          1,        	-1 },
	{ "Cursor",			NULL,     NULL,   	1 << 1,    0,          0,          1,        	-1 },
	{ "pol.exe",		NULL,     NULL,   	1 << 4,    1,          0,          1,        	-1 },
};

/* window following */
#define WFACTIVE '>'
#define WFINACTIVE 'v'
#define WFDEFAULT WFACTIVE

/* layout(s) */
static const float mfact     = 0.55; 		/* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    		/* number of clients in master area */
static const int resizehints = 1;    		/* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; 		/* 1 will force focus on the fullscreen window */

#define FORCE_VSPLIT 1  					/* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     	arrange function */
	{ "[\\]",   	dwindle },
	{ ">M>",     	centeredfloatingmaster }, /* first entry is default */
	{ "|M|",     	centeredmaster },	
	{ "",      	tile },
	{ "TTT",      	bstack },
	{ "###",      	nrowgrid },
	{ "===",      	bstackhoriz },
	{ ":::",      	gaplessgrid },
	{ "[@]",      	spiral },
  	{ "---",      	horizgrid },
	{ "",      	monocle },
	{ "HHH",      	grid },
	{ "H[]",      	deck },
	{ "><>",      	NULL },    				/* no layout function means floating behavior */
	{ "",       	NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
/* static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL }; */
/* static const char *termcmd[]  = { "tilix", NULL }; */

static const char *launchercmd[] = 	{ "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = 	{ "kitty", NULL };

#include "movestack.c"
#include "shiftview.c"

static const Key keys[] = {
	/* modifier                     key        	   function        argument */
	{ MODKEY,                       XK_r,          spawn,          {.v = launchercmd} },    // spawn rofi for launching other programs
	{ MODKEY,                       XK_x,          spawn,          {.v = termcmd } },       // spawn a terminal
	{ MODKEY,                       XK_b,          spawn,          SHCMD ("xdg-open https://")}, // open default browser
	{ MODKEY,                       XK_p,          spawn,          SHCMD ("flameshot full -p $HOME/Pictures/Screenshots/")}, // capture full screen screenshot
	{ MODKEY|ShiftMask,             XK_p,          spawn,          SHCMD ("flameshot gui -p $HOME/Pictures/Screenshots/")}, // open flameshot gui for screenshot selection
	{ MODKEY|ControlMask,           XK_p,          spawn,          SHCMD ("flameshot gui --clipboard")}, // copy screenshot to clipboard
	{ MODKEY,                       XK_e,          spawn,          SHCMD ("thunar")},       // open file manager
	{ MODKEY|ShiftMask,             XK_w,          spawn,          SHCMD ("feh --randomize --bg-fill $HOME/Pictures/background/*")}, // start Looking glass
	{ 0,                            0x1008ff11,    spawn,          SHCMD ("amixer sset Master 5%- unmute")}, // unmute volume
	{ 0,                            0x1008ff12,    spawn,          SHCMD ("amixer sset Master $(amixer get Master | grep -q '\\[on\\]' && echo 'mute' || echo 'unmute')")}, // toggle mute/unmute
	{ 0,                            0x1008ff13,    spawn,          SHCMD ("amixer sset Master 5%+ unmute")}, // unmute volume
	{ MODKEY|ShiftMask,             XK_b,          togglebar,      {0} },                   // toggle bar visibility
	{ MODKEY,                       XK_j,          focusstack,     {.i = +1 } },            // focus on the next client in the stack
	{ MODKEY,                       XK_k,          focusstack,     {.i = -1 } },            // focus on the previous client in the stack
	{ MODKEY,                       XK_h,          setmfact,       {.f = -0.05} },          // decrease the size of the master area compared to the stack area(s)
	{ MODKEY,                       XK_l,          setmfact,       {.f = +0.05} },          // increase the size of the master area compared to the stack area(s)
	{ MODKEY|ShiftMask,             XK_h,          setcfact,       {.f = +0.25} },          // increase size respective to other windows within the same area
	{ MODKEY|ShiftMask,             XK_l,          setcfact,       {.f = -0.25} },          // decrease client size respective to other windows within the same area
	{ MODKEY|ShiftMask,             XK_o,          setcfact,       {.f =  0.00} },          // reset client area
	{ MODKEY|ShiftMask,             XK_n,      	   togglefollow,   {0} },
	{ MODKEY,   		            XK_comma,      shiftview,      {.i = -1 } },            // move to next tag
	{ MODKEY,	        	        XK_period, 	   shiftview,      {.i = +1 } },            // move to previous tag
	{ MODKEY|ShiftMask,             XK_Right,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,       movestack,      {.i = -1 } },
	{ ControlMask|ShiftMask,        XK_Left,       viewtoleft,     {0} },
	{ ControlMask|ShiftMask,        XK_Right,      viewtoright,    {0} },
	{ MODKEY,                       XK_Tab,    	   view,           {0} },
	{ Mod1Mask|ControlMask,         XK_Left,   	   tagtoleft,      {0} },
	{ Mod1Mask|ControlMask,    		XK_Right,  	   tagtoright,     {0} },
	{ MODKEY,             			XK_q,      	   killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  	   setlayout,      {0} },
	{ MODKEY,                       XK_0,      	   view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      	   tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  	   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, 	   focusmon,       {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_comma,  	   tagmon,         {.i = -1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_period, 	   tagmon,         {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_u,      	   incrgaps,       {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_u,      	   incrgaps,       {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_i,      	   incrigaps,      {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_i,      	   incrigaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_o,      	   incrogaps,      {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_o,      	   incrogaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_6,      	   incrihgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_6,      	   incrihgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_7,      	   incrivgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_7,      	   incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_8,      	   incrohgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_8,      	   incrohgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_9,      	   incrovgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_9,      	   incrovgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_0,      	   togglegaps,     {0} },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_0,      	   defaultgaps,    {0} },
	{ ShiftMask|ControlMask,        XK_1,     	   setlayout,      {.v = &layouts[0] } },
	{ ShiftMask|ControlMask,        XK_2,      	   setlayout,      {.v = &layouts[1] } },
	{ ShiftMask|ControlMask,        XK_3,      	   setlayout,      {.v = &layouts[2] } },
	{ ShiftMask|ControlMask,        XK_4,      	   setlayout,      {.v = &layouts[3] } },
	{ ShiftMask|ControlMask,        XK_5,      	   setlayout,      {.v = &layouts[4] } },
	{ ShiftMask|ControlMask,        XK_6,      	   setlayout,      {.v = &layouts[5] } },
	{ ShiftMask|ControlMask,        XK_7,      	   setlayout,      {.v = &layouts[6] } },
	{ ShiftMask|ControlMask,        XK_8,      	   setlayout,      {.v = &layouts[7] } },
	{ ShiftMask|ControlMask,        XK_9,      	   setlayout,      {.v = &layouts[8] } },
	{ ShiftMask|ControlMask,        XK_0,      	   setlayout,      {.v = &layouts[9] } },
	TAGKEYS(                        XK_1,                          0)
	TAGKEYS(                        XK_2,                          1)
	TAGKEYS(                        XK_3,                          2)
	TAGKEYS(                        XK_4,                          3)
	TAGKEYS(                        XK_5,                          4)
	{ MODKEY|Mod1Mask|ShiftMask,   	XK_Tab,        incnmaster,     {.i = +1 } },
	{ MODKEY|Mod1Mask,			    XK_Tab,        incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_q,          quit,           {0} },                   // exit dwm
	{ MODKEY|ControlMask,           XK_q,          spawn,          SHCMD("$HOME/.config/rofi/powermenu.sh")}, // exit dwm
	{ MODKEY|ControlMask|ShiftMask, XK_r,          spawn,          SHCMD("systemctl reboot")}, // reboot system
	{ MODKEY|ControlMask|ShiftMask, XK_s,          spawn,          SHCMD("systemctl suspend")}, // suspend system	
	{ MODKEY|ShiftMask,    			XK_v,  	   	   togglescratch,  {.ui = 0 } },
	{ MODKEY|ShiftMask,    			XK_r,  	   	   togglescratch,  {.ui = 1 } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkFollowSymbol,      0,              Button1,        togglefollow,   {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
