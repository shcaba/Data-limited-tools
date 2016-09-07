#C 2011 dover sole 2011 assessment in SS3
# Initial parameter values from Run 248.MC.A05, the final base model.
# Uses environment variables for trends in retention parameters and female maturity L50.

1	#_N_Growth_Patterns
1	#_N_Morphs_Within_GrowthPattern
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)

#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10

3 #_Nblock_Patterns
2 1 2 #_blocks_per_pattern
# begin and end years of blocks
1910 1980 1981 1995 #Blocks for changes in fishery selection
1910 2003 #Blocks for changes in fishery retention for CA/WA
1910 1988 1989 2003 #Blocks for changes in fishery retention for OR


0.5	#_fracfemale
0	#_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#2 #_N_breakpoints
#4 15 # age(real) at M breakpoints


1	 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=not implemented; 4=not implemented
1.0	 #_Growth_Age_for_L1 (minimum age for growth calcs)
50 #_Growth_Age_for_L2 (999 to use as Linf) (maximum age for growth calcs)
0.0	 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
4	 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 Lognormal
1	 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity
#_placeholder for empirical age-maturity by growth pattern
2	#_First_Mature_Age
1	#_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b
0	#hermaphrodite
1	#_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
2	#_env/block/dev_adjust_method (1=standard; 2=with logistic trans to keep within base parm bounds)


#_growth_parms
#GP_1_Female
#LO     HI      INIT    PRIOR   PR_type SD      PHASE   env-var   use_dev	dev_minyr dev_maxyr dev_stddev	Block	Block_Fxn
0.05    0.20    0.101   -2.289  3       0.337   6       0 0 0 0 0 0 0  #_natM with prior LN(median=0.101,sd_log=0.337)
3       25      15      15      -1      10      2       0 0 0 0 0 0 0  #_Lmin from data but reduced slightly
35      60      47.5    47.5    -1      1       3       0 0 0 0 0 0 0  #_Lmax from prediction of NWFSC data
0.03    0.2     0.096   0.096   -1      1       2       0 0 0 0 0 0 0  #_VBK
0.01    1.0     0.13    0.13    -1      1       3       0 0 0 0 0 0 0  #_CV_at_Amin
0.01    1.0     0.05    0.0     -1      1       4       0 0 0 0 0 0 0  #_CV_at_Amax_as_exponential_offset_(rel_young)
#GP_1:::Male (Direct Estimation)
0.05    0.20    0.103   -2.276  3       0.337   7       0 0 0 0 0 0 0  #_natM with prior LN(median=0.103,sd_log=0.337)
3       25      15       15      -1      10      2       0 0 0 0 0 0 0  #_Lmin from data but reduced slightly
35      60      43.7    43.7    -1      10      3       0 0 0 0 0 0 0  #_Lmax from prediction of NWFSC data
0.03    0.2     0.097   0.097   -1      0.05    2       0 0 0 0 0 0 0  #_VBK
0.01    1.0     0.13       0       -1      1      3       0 0 0 0 0 0 0  #_CV-at_Amin
0.01    1.0     0.05     0.0     -1      1      4       0 0 0 0 0 0 0  #_CV_at_Amax
#LW_female
0       0.1  2.805E-06  2.805E-06  -1   0.2     -9      0 0 0 0 0 0 0 #_a
2       4       3.345   3.345   -1      2       -9      0 0 0 0 0 0 0 #_b
#Female_maturity
20      40      35.0    33.4    -1       5       -9      0 0 0 0 0 0 0 #_L50
-1      0       -0.775 -0.2988 -1       0.4     -9      0 0 0 0 0 0 0 #_slope
#Fecundity 
-3      3       1       1       -1      0.8     -9      0 0 0 0 0 0 0 #_eggs / gm intercept
-3      3       0       0       -1      0.8     -9      0 0 0 0 0 0 0 #_eggs / gm slope
#LW_Male
0       0.1  2.231E-06 2.231E-06 -1     0.2     -9      0 0 0 0 0 0 0 #_a
2       4       3.412     3.412  -1     2       -9      0 0 0 0 0 0 0 #_b
#Allocate_R_by_areas_x_gmorphs
0       1       1       0.2     -1      9.8     -3	  0 0 0 0 0 0 0 #frac to GP 1 in area 1
#Allocate_R_by_areas_(1_areain_this_case)
0       1       1       1       -1      9.8      -3      0 0 0 0 0 0 0 #frac R in area 1
#Allocate_R_by_season
-4      4       0       1       -1      9.8      -3      0 0 0 0 0 0 0 #frac R in season 1 (in log space)
#CohortGrowDev
#SS3 manual says it must be given a value of 1 and a negative phase
0      1     1       1        -1         0     -4       0 0 0 0 0 0 0

#0  #custom_MG-env_setup (0/1)
#-2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters

#0  #custom_MG-block_setup (0/1)
#-2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters

#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0	#_femwtlen1,femwtlen2,L1,K,Malewtlen1,malewtlen2,L1,K
#_Cond -2 2 0 0 -1 99 -2 #enter parameter line when seasonal MG parameters

#_Cond -4 #_MGparm_Dev_Phase

#_Spawner-Recruitment
3	#_SR_function
#_LO	HI	INIT	PRIOR	PR_type        SD      PHASE
6       17    12.5    11       -1          5       1   #_Ln(R0)
0.22    1     0.8     0.8       0          0.09    -7   #_steepness
0.15    0.55  0.35    0.35     -1          0.2    -99  #_SD_recruitments
-2      2     0       0        -1          2      -99  #_Env_link
-2      2     0       0        -1          2      -99  #_ln(init_eq_R_multiplier)
0 	  0 	0 	  0        -1  		0 	 -99  # SR_autocorr
0	#_SR_env_link
0	#_SR_env_target_0=none;1=devs;_2=R0;_3=steepness

1	#do_recdev:  0=none; 1=devvector; 2=simple deviations

1960	# first year of main recr_devs; early devs can preceed this era
2009	# last year of main recr_devs; forecast devs start in following year
5	#_recdev phase
1	# (0/1) to read 11 advanced options
1910       #_recdev_early_start (0=none; neg value makes relative to recdev_start)
6       #_recdev_early_phase
6       #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1    #_lambda for prior_fore_recr occurring before endyr+1
1960 #_last_early_yr_nobias_adj_in_MPD
1985 #_first_yr_fullbias_adj_in_MPD
2006 #_last_yr_fullbias_adj_in_MPD
2009 #_first_recent_yr_nobias_adj_in_MPD
0.9    #_max_bias_adj_in_MPD
0.0  # placeholder for future use 
-5 #min rec_dev
5  #max rec_dev
0	#_read_recdevs
#_end of advanced SR options


#Fishing Mortality info
0.04	# F ballpark for tuning early phases
-2001	# F ballpark year (neg value to disable)
3	# F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
3.5	# max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# read overall start F value; overall phase; N detailed inputs to read for Fmethod 2
# NUM ITERATIONS, FOR CONDITION 3
5	# read N iterations for tuning for Fmethod 3 (recommend 3 to 7)
#Fleet Year Seas F_value se phase (for detailed setup of F_Method=2)

#_initial_F_parms
#_LO HI INIT PRIOR PR_type 	SD PHASE
0	1	0	0.0001	0		99	-1	#Fleet1 
0	1	0	0.0001	0		99	-1	#Fleet2
0	1	0	0.0001	0		99	-1	#Fleet2

#_Q_setup
# A=do power: 0=skip, survey is prop. to abundance, 1= add par for non-linearity
# B=env. link: 0=skip, 1= add par for env. effect on Q
# C=extra SD: 0=skip, 1= add par. for additive constant to input SE (in ln space)
# D=type: <0=mirror lower abs(#) fleet, 0=no par Q is median unbiased, 1=no par Q is mean unbiased, 2=estimate par for ln(Q)
# 	   3=ln(Q) + set of devs about ln(Q) for all years. 4=ln(Q) + set of devs about Q for indexyr-1
#D=devtype(<0=mirror, 0/1=none, 2=cons, 3=rand, 4=randwalk)
# A 	B 	C 	D		
0	0	0	0 	#Fleet1_(CA_TWL)
0	0	0	0 	#Fleet2_(OR_TWL)
0	0	0	0 	#Fleet3_(WA_TWL)
0	0	1	0 	#AFSC_Slope
0	0	1	4 	#Trienial
0	0	1	0 	#NWFSC_slope
0	0	1	0 	#NWFSC_combo

# Q parameters
1 # Par setup: 0=read one parm for each fleet with random q; 1=read a parm for each year of index


#Extra SD parameters for surveys
#Lo	Hi	Init	Prior  Prior Prior Phase
0   2   0.01    0      -1    99    3   #AFSC slope
0   2   0.01    0      -1    99    3   #Triennial
0   2   0.01    0      -1    99    3   #NWFSC_slope
0   2   0.01    0      -1    99    3   #NWFSC_combo

# Lo	Hi	Init	Prior  Prior Prior Param
# bnd   bnd   value   mean   type  SD    phase
# Early period
  -10	2	-2       0	-1	99	1   # Triennial (log) base parameter (1980)
  -4	4	0	     0	-1	99	-50 # Triennial 1983 deviation
  -4	4	0	     0	-1	99	-50 # Triennial 1986 deviation
  -4	4	0	     0	-1	99	-50 # Triennial 1989 deviation
  -4	4	0	     0	-1	99	-50 # Triennial 1992 deviation
# Late period
  -4	4	0   	 0	-1	99	1   # Triennial 1995 deviation
  -4	4	0	    0	-1	99	-50 # Triennial 1998 deviation
  -4	4	0	    0	-1	99	-50 # Triennial 2001 deviation
  -4	4	0	    0	-1	99	-50 # Triennial 2004 deviation

#Seltype(1,2*Ntypes,1,4)	#SELEX_&_RETENTION_PARAMETERS
# Size-based setup
# A=Selex option: 1-24
# B=Do_retention: 0=no, 1=yes
# C=Male offset to female: 0=no, 1=yes
# D=Mirror selex (#)
# A B C D
#Size_Slectivity,_enter_4_cols    #27 is cubic spline
#Pattern Retention Male Special
24 1 2 0  #Fleet1_(CA_TWL)
24 1 2 0  #Fleet2_(OR_TWL)
24 1 2 0  #Fleet3_(WA_TWL)
27 0 1 5  #AFSC_Slope     
24 0 2 0  #Triennial       
27 0 1 5  #NWFSC_slope    
24 0 2 0  #NWFSC_combo
#Age_selectivity
10 0 0 0 # CA_TWL
10 0 0 0 # OR_TWL
10 0 0 0 # WA_TWL
10 0 0 0 # #AFSC_Slope     
10 0 0 0 # #Trienial       
10 0 0 0 # #NWFSC_slope    
10 0 0 0 # #NWFSC_combo    

#Selectivity parameters
#LO    HI     INIT   PRIOR  PR_TYPE SD    PHASE  env-var use_dev dev_yr1 dev_yr2 dev_sd nblks blk_pat
#1 CA Length selection
15     55     36     36     -1       5    2       0 0 0 0 0 1 2  #Peak
-7     7      -0.5   -0.5   -1       2     3      0 0 0 0 0 0 0 #Top (width)
-10    10     2      1.75   -1       5    3       0 0 0 0 0 0 0 #ASC_WIDTH
-10    10     6      0.1    -1       2    -4       0 0 0 0 0 0 0 #DESC_WIDTH
-20    30     -20  -1     -1       5    -9      0 0 0 0 0 0 0 #INIT (first bin)
-10    10     10      1      -1       5    -4       0 0 0 0 0 0 0 #Final (last bin)
#RETENTION
15     40     34     34     -1       99   2       0 0 0 0 0 2 2 #inflection
0.1    5      1.0    1.0    -1       99   3       0 0 0 0 0 2 2 #slope
0.5    1      1      1      -1       99   3       0 0 0 0 0 2 2 #asymptote
-10    10     0.0    0.0    -1       99   -9      0 0 0 0 0 0 0 # male offset to inflection (arithmetic)
#Females as offset
-10   60     40       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0       0      -1       5     -5     0 0 0 0 0 0 0 # OffsetAtZero
-10   0      0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtDogleg (can fix this at 0 to match male selex at peak)
-10   0.1    0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtMaxage
#2 OR Length selection
15     55     36     36     -1       5    2       0 0 0 0 0 1 2  #Peak
-5     5      -0.5   -0.5   -1       2     3      0 0 0 0 0 0 0 #Top (width)
-10    10     2       1.75  -1       5    3       0 0 0 0 0 0 0 #ASC_WIDTH
-10    10     6      0.1    -1       2    -4       0 0 0 0 0 0 0 #DESC_WIDTH
-20    30     -20  -1     -1       5    -9      0 0 0 0 0 0 0 #INIT (first bin)
-10    10     10      1      -1       5    -4       0 0 0 0 0 0 0 #Final (last bin)
#RETENTION
15     40     34     34     -1       99   2       0 0 0 0 0 3 2 #inflection
0.1    5      1.0    1.0    -1       99   3       0 0 0 0 0 3 2 #slope
0.5    1      1      1      -1       99   3       0 0 0 0 0 3 2 #asymptote
-10    10     0.0    0.0    -1       99   -9      0 0 0 0 0 0 0 # male offset to inflection (arithmetic)
#Females as offset
-10   60     39       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0       0      -1       5     -5     0 0 0 0 0 0 0 # OffsetAtZero
-10   0      0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtDogleg (can fix this at 0 to match male selex at peak)
-10   0.1    0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtMaxage
#3 WA Length selection
15     55     36     36     -1       5    2       0 0 0 0 0 1 2  #Peak
-5     5      -0.5   -0.5   -1       2     3      0 0 0 0 0 0 0 #Top (width)
-10    10     2       1.75  -1       5    3       0 0 0 0 0 0 0 #ASC_WIDTH
-10    10     6      0.1    -1       2    -4       0 0 0 0 0 0 0 #DESC_WIDTH
-20    30     -20  -1     -1       5    -9      0 0 0 0 0 0 0 #INIT (first bin)
-10    10     10      1      -1       5    -4       0 0 0 0 0 0 0 #Final (last bin)
#RETENTION                                  
15     40     34     34     -1       99   2       0 0 0 0 0 2 2 #inflection
0.1    5      1.0    1.0    -1       99   3       0 0 0 0 0 2 2 #slope
0.5    1      1      1      -1       99   3       0 0 0 0 0 2 2 #asymptote
-10    10     0.0    0.0    -1       99   -9      0 0 0 0 0 0 0 # male offset to inflection (arithmetic)
#Females as offset
-10   60     40       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0       0      -1       5     -5     0 0 0 0 0 0 0 # OffsetAtZero
-10   0      0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtDogleg (can fix this at 0 to match male selex at peak)
-10   0.1    0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtMaxage
#4 AFSC slope
0      2      0      0      -1       0    -9     0 0 0 0 0 0 0 #spline setup
-0.001 10     1    0      -1       0.1  3      0 0 0 0 0 0 0 # AgeSpline_GradLo
-10    0.01   -0.001 0      -1       0.1  3      0 0 0 0 0 0 0 # AgeSpline_GradHi
1      60    20      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_1
1      60    29      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_2
1      60    38      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_3
1      60    47      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_4
1      60    56      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_5
-9     7     -7      0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_1
-9     7     -1      0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_2
-9     7     0       0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Val_3
-9     7     0       0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_4
-9     7     0      0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_5
#Males as offset
-10   60     45       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0      0      -1       5     -5      0 0 0 0 0 0 0 # MaleOffsetAtZero
-10   10     0      0      -1       5     5      0 0 0 0 0 0 0 # MaleOffsetAtDogleg (can fix this at 0 to match female selex at peak)
-10   10     0      0      -1       5     5      0 0 0 0 0 0 0 # MaleOffsetAtMaxage
#5 Triennial
15     55     36     36     -1       5    2       0 0 0 0 0 0 0  #Peak
-10    5      -0.5   -0.5   -1       2     3      0 0 0 0 0 0 0 #Top (width)
-10    10     2       1.75  -1       5    3       0 0 0 0 0 0 0 #ASC_WIDTH
-10    10     2      0.1    -1       2    4       0 0 0 0 0 0 0 #DESC_WIDTH
-20    30     -20  -1     -1       5    -9      0 0 0 0 0 0 0 #INIT (first bin)
-10    10     1      1      -1       5   4       0 0 0 0 0 0 0 #Final (last bin)
#Females as offset
-10   60     35       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0       0      -1       5     -5     0 0 0 0 0 0 0 # OffsetAtZero
-10   0      0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtDogleg (can fix this at 0 to match male selex at peak)
-10   0.1    0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtMaxage
#6 NWFSC slope
0      2      0      0      -1       0    -9     0 0 0 0 0 0 0 #spline setup
-0.001 10     1    0      -1       0.1  3      0 0 0 0 0 0 0 # AgeSpline_GradLo
-10    0.01   -0.001 0      -1       0.1  3      0 0 0 0 0 0 0 # AgeSpline_GradHi
1      60    20      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_1
1      60    29      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_2
1      60    38      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_3
1      60    47      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_4
1      60    56      0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Knot_5
-9     7     -7      0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_1
-9     7     -1      0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_2
-9     7     0       0      -1       0    -99    0 0 0 0 0 0 0 # AgeSpline_Val_3
-9     7     0       0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_4
-9     7     0      0      -1       0    2      0 0 0 0 0 0 0 # AgeSpline_Val_5
#Males as offset
-10   60     45       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0      0      -1       5     -5      0 0 0 0 0 0 0 # MaleOffsetAtZero
-10   10     0      0      -1       5     5      0 0 0 0 0 0 0 # MaleOffsetAtDogleg (can fix this at 0 to match female selex at peak)
-10   10     0      0      -1       5     5      0 0 0 0 0 0 0 # MaleOffsetAtMaxage
#7 NWFSC_combo
15     55     36     36     -1       5    2       0 0 0 0 0 0 0  #Peak
-5     5      -0.5   -0.5   -1       2     3      0 0 0 0 0 0 0 #Top (width)
-10    10     2       1.75  -1       5    3       0 0 0 0 0 0 0 #ASC_WIDTH
-10    10     2      0.1    -1       2    4       0 0 0 0 0 0 0 #DESC_WIDTH
-20    30     -20  -1     -1       5    -9      0 0 0 0 0 0 0 #INIT (first bin)
-10    10     1      1      -1       5   4       0 0 0 0 0 0 0 #Final (last bin)
#Females as offset
-10   60     40       0      -1       5     -4     0 0 0 0 0 0 0 # Dogleg_location
-10   10     0       0      -1       5     -5     0 0 0 0 0 0 0 # OffsetAtZero
-10   0      0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtDogleg (can fix this at 0 to match male selex at peak)
-10   0.1    0       0      -1       5     5      0 0 0 0 0 0 0 # OffsetAtMaxage


1 #_custom block setup (0/1)
#LO HI INIT PRIOR PR_TYPE SD PHASE
#CA blocks
15  55 36 0 -1 99 4   #peak selex, 1910-1980
15  55 36 0 -1 99 4   #peak selex, 1981-1995
15  40 34 0 -1 99 4   #retention inflection 1910-2003
0.1  5  1 0 -1 99 4   #retention slope      1910-2003
0.7  1  1 0 -1 99 4   #retention asymptote  1910-2003
#OR blocks
15  55 36 0 -1 99 4   #peak selex, 1910-1980
15  55 36 0 -1 99 4   #peak selex, 1981-1995
15  40 34 0 -1 99 4   #retention inflection 1910-1988
15  40 34 0 -1 99 4   #retention inflection 1989-2003
0.1  5  1 0 -1 99 4   #retention slope      1910-1988
0.1  5  1 0 -1 99 4   #retention slope      1989-2003
0.5  1  1 0 -1 99 4   #retention asymptote  1910-1988
0.5  1  1 0 -1 99 4   #retention asymptote  1989-2003
#WA blocks
15  55 36 0 -1 99 4   #peak selex, 1910-1980
15  55 36 0 -1 99 4   #peak selex, 1981-1995
15  40 34 0 -1 99 4   #retention inflection 1910-2003
0.1  5  1 0 -1 99 4   #retention slope      1910-2003
0.7  1  1 0 -1 99 4   #retention asymptote  1910-2003


1 #selparm_adjust_method: 1=standard; 2=logistic trans to keep in base parm bounds

# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters

1 #_Variance_adjustments_to_input_values
#CA OR WA AFSCslope Triennial NWFSCslope NWFSCcombo
 0  0  0  0         0       0      0          #Survey SE(log)
 0  0  0  0         0       0      0          #Discard stddev
 0  0  0  0         0       0      0          #Mean bodywt CV
 2  2.5  3  2       1     2      2.5          #Length Comp
 3    2  2  1       1       0.3    0.1          #Age Comp
 1    1  1  1       1       1      1          #Size at age

1 #_maxlambdaphase
1 #_sd_offset

14 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch;
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  sizefreq_method
4           1            1      0.5  1    #commercial lgth comps
4           2            1      0.5  1    #commercial lgth comps
4           3            1      0.5  1    #commercial lgth comps
4           4            1      1    1    # lgth comps AKslope  
4           5            1      1    1    # lgth comps Triennial
4           6            1      0.5  1    # lgth comps NWslope  
4           7            1      1    1    # lgth comps NWcombo  
5           1            1      0.5  1    #commercial age comps
5           2            1      0.5  1    #commercial age comps
5           3            1      0.5  1    #commercial age comps
5           4            1      0.5  1    #commercial age comps AKslope
5           5            1      1    1    #commercial age comps Triennial
5           6            1      0.5  1    #commercial age comps NWslope
5           7            1      1    1    #commercial age comps NWcombo


0 # (0/1) read specs for more stddev reporting
# 1 1 -1 5 1 5 # selex type, len/age, year, N selex bins, Growth pattern, N growth ages
# -5 16 27 38 46 # vector with selex std bin picks (-1 in first bin to self-generate)
# 1 2 14 26 40 # vector with growth std bin picks (-1 in first bin to self-generate)

999


