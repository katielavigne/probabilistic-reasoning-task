scenario = "fMRI-only version for MCT project - Run B";

#scenario_type = trials;

scenario_type = fMRI;

#scenario_type = fMRI_emulation;
scan_period = 2000;
pulses_per_scan = 1;
pulse_code = 1; 

#pcl_file="MCT_EEG_fMRI_fish_greenlakeisfocal.pcl";
pcl_file="MCT_FISH_B.pcl";
#write_codes = true;
#pulse_width=10;

active_buttons = 3; 
button_codes= 1, 2, 9;    


default_background_color=0,0,0; 
default_font="arial";
default_font_size = 40;
#default_text_color = 255,255,255;            
default_text_color=255,255,255;
########################################################################
begin;

$xoffleft='-80';
$xoffright='80';

$defaultITIdur='1000';

box {height=200; width=340; color=123,123,123;} frame_box;
box {height=20; width=20; color=0,0,0;} blacksquare_box;
box {height=20; width=20; color=123,123,123;} greysquare_box;
box {height=24; width=24; color=255,255,255;} whitesquare_box;

ellipse_graphic{ellipse_height = 150; ellipse_width=120; color = 40,210,160,255;}green_ellipse;
ellipse_graphic{ellipse_height = 150; ellipse_width=120; color = 40,160,210,255;}blue_ellipse;

bitmap { filename="fixn_point.png";}fixn;

bitmap { filename="whitefish_for_fixn.png"; } bmp_whitefish_fixn;
bitmap { filename="blackfish_for_fixn.png"; } bmp_blackfish_fixn;

bitmap { filename="blackfish_pointingleft.png"; } bmp_blackfishpointingleft_fixn;
bitmap { filename="blackfish_pointingright.png"; } bmp_blackfishpointingright_fixn;
bitmap { filename="whitefish_pointingleft.png"; } bmp_whitefishpointingleft_fixn;
bitmap { filename="whitefish_pointingright.png"; } bmp_whitefishpointingright_fixn;

bitmap { filename="whitefish_for_blue_lake.png"; } bmp_whitefish_bluelake;
bitmap { filename="blackfish_for_blue_lake.png"; } bmp_blackfish_bluelake;
bitmap { filename="whitefish_for_green_lake.png"; } bmp_whitefish_greenlake;
bitmap { filename="blackfish_for_green_lake.png"; } bmp_blackfish_greenlake;

text {caption="+";}fixn_txt; 

#######################################################################
#######################################################################
#######################################################################

picture { # blank background for ITI
box frame_box; x=0; y=0;
bitmap fixn; x=0; y=0;
}default;

#######################################################################
# main display picture
picture { # set proper x & y coordinates for each fish in pcl
box frame_box; x=0; y=0;
ellipse_graphic green_ellipse; x=$xoffleft; y=0; #green_ellipse; x=$xoffleft; y=0; 
ellipse_graphic blue_ellipse; x=$xoffright; y=0;

LOOP $i 30;
bitmap bmp_whitefish_greenlake; x=$xoffleft; y=0;
ENDLOOP;

LOOP $i 30;
bitmap bmp_whitefish_bluelake; x=$xoffright; y=0;
ENDLOOP;

bitmap bmp_whitefish_fixn; x=0; y=0;


# top boxes, yes response
box whitesquare_box; x=0; y=40;
box greysquare_box; x=0; y=40; # picture part number 66

# bottom boxes, no response
box whitesquare_box; x=0; y=-40;
box greysquare_box; x=0; y=-40; # picture part number 68

text {caption="YES"; font_color=0,0,0; background_color=123,123,123; font_size=14;}yes_txt; x=0; y=70;
text {caption="NO"; font_color=0,0,0; background_color=123,123,123; font_size=14;}no_txt; x=0; y=-70;

#text debug_txt; x=0; y=-100;
#text debugrow2_txt; x=0; y=-130;

}display_pic;

#############################################################################

bitmap {filename="FISHscreenshot.bmp";} screenshot;

picture{
	bitmap screenshot; x=0; y=0;
	text {caption="Index finger for yes"; 
		font_size=14;
		font="arial";
	}instructions_txtL; x=-150; y=-150;
	text {caption="Middle finger for no"; 
		font_size=14;
		font="arial";
	}instructions_txtR; x=100; y=-150;
	text {caption="INSTRUCTIONS";
		font_size=14;
		font="arial";
	}instrct; x = 0; y = 125;
}instructions_pic1;

picture{
	bitmap screenshot; x=0; y=0;
	text instructions_txtL; x=-150; y=-150;
	text instructions_txtR; x=100; y=-150;
	text {caption="STARTING...";
			font_size=14;
			font="arial";
			}starting; x = 0; y = 125;
}instructions_pic2;

########################################################

trial{
	trial_type = specific_response;
	trial_duration = forever;
	terminator_button = 3;
	stimulus_event{
		picture instructions_pic1;
	}instructions_event;
}instructions_trial;

trial{
	all_responses = false; # responses made in this trial will be ignored
stimulus_event{
	picture {text{caption = "5"; font_size = 40;} five; x = 0; y = 0;};
		duration = 1000;};
stimulus_event{
	picture {text{caption = "4"; font_size = 40;} four; x = 0; y = 0;};
		deltat = 1000;
		duration = 1000;};
stimulus_event{
	picture {text{caption = "3"; font_size = 40;} three; x = 0; y = 0;};
		deltat = 1000;
		duration = 1000;};
stimulus_event{
	picture {text{caption = "2"; font_size = 40;} two; x = 0; y = 0;};
		deltat = 1000;
		duration = 1000;};
stimulus_event{
	picture {text {caption = "1"; font_size = 40;} one; x = 0; y = 0;};
		deltat = 1000;
		duration = 1000;};
}countdown_trial;

########################################################


trial{
stimulus_event{
picture default; 
code="ITI"; 
#port_code=99; 
duration=$defaultITIdur;
}ITI_event;
}ITI_trial;

trial{
stimulus_event{
picture display_pic;
}display_event;
}display_trial;  

trial {
picture instructions_pic2;
code = "start_trial";
duration = 1000;
mri_pulse = 1;
}start_trial;


#trial display_trial;

trial {
	all_responses = false; # responses made in this trial will be ignored
	picture {text{caption = "Thank you. Please remember to stay still
	until the scanner stops.";}; x = 0; y = 0;}finished;
	code = "thanks";
	duration = 10000;
}end_trial;
