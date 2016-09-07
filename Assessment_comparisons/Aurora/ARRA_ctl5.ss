1  #_N_Growth_Patterns
1 #_N_Morphs_Within_GrowthPattern
1 #_Nblock_Patterns
11 #_blocks_per_pattern
#1916 1998
1999 2001
2002 2002
2003 2003
2004 2004
2005 2005
2006 2006
2007 2007
2008 2008
2009 2009
2010 2010
2011 2012
#
#1916 2001 Block for nontrwl selectivity
#2002 2012
# begin and end years of blocks
#
0.5 #_fracfemale
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=not implemented; 4=not implemented
1	#_Growth_Age_for_L1
40	#_Growth_Age_for_L2	(999	to	use	as	Linf)
0	#_SD_add_to_LAA	(set	to	0.1	for	SS2	V1.x	compatibility)
0	#_CV_Growth_Pattern:	0	CV=f(LAA);	1	CV=F(A);	2	SD=F(LAA);	3	SD=F(A)
1	#_maturity_option:	1=length	logistic;	2=age	logistic;	3=read	age-maturity	matrix	by	growth_pattern;	4=read	age-fecundity;	5=read	fec	and	wt	from	wtatage.ss
#_placeholder	for	empirical	age-maturity	by	growth	pattern
0	#_First_Mature_Age
1	#_fecundity	option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b
0	#_hermaphroditism	option:	0=none;	1=age-specific	fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
2	#_env/block/dev_adjust_method	(1=standard;	2=logistic	transform	keeps	in	base	parm	bounds;	3=standard	w/	no	bound	check)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_type	SD	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn
0.001 2 0.0350 -3.353 3 0.541 -2 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
1 11.82328614 8.5 6 1 10 2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
1 73.8 31 31 -1 10 3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
0.01 1 0.09 0.1 -1 0.8 3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
0.03	0.2	0.1	0.09	-1	0.8	3	0	0	0	0	0	0	0	#	CV_young_Fem_GP_1
0.03	0.2	0.07	0.05	-1	0.8	3	0	0	0	0	0	0	0	#	CV_old_Fem_GP_1
0.001 2 0.0371 -3.295 3 0.540 -2 0 0 0 0 0 0 0 # NatM_p_1_Mal_GP_1
1 11.82328614 8.5 6 1 10 2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
1 73.8 30 31 -1 10 4 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
0.01 1 0.092 0.1 -1 0.8 3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
-1 1 0 0 -1 0.8 -3 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
-1 1 0 0 -1 0.8 -3 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
-3	3	0.000009933699	2.44E-06	-1	0.8	-3	0	0	0	0	0	0	0	#	Wtlen_1_Fem
-3	4	3.144807	3.34694	-1	0.8	-3	0	0	0	0	0	0	0	#	Wtlen_2_Fem
1 1000 25.54 55 -1 0.8 -3 0 0 0 0 0 0 0 # Mat50%_Fem
-30	3	-0.616	-0.25	-1	0.8	-3	0	0	0	0	0	0	0	#	Mat_slope_Fem
-3	3	1	1	-1	0.8	-3	0	0	0	0	0	0	0	#	Eggs/kg_inter_Fem
-3	3	0	0	-1	0.8	-3	0	0	0	0	0	0	0	#	Eggs/kg_slope_wt_Fem
-3	3	0.000009618973	2.44E-06	-1	0.8	-3	0	0	0	0	0	0	0	#	Wtlen_1_Mal
-3	4	3.14725	3.34694	-1	0.8	-3	0	0	0	0	0	0	0	#	Wtlen_2_Mal
0	0	0	0	-1	0	-4	0	0	0	0	0	0	0	#	RecrDist_GP_1
0	0	0	0	-1	0	-4	0	0	0	0	0	0	0	#	RecrDist_Area_1
0	0	0	0	-1	0	-4	0	0	0	0	0	0	0	#	RecrDist_Seas_1
0	0	0	0	-1	0	-4	0	0	0	0	0	0	0	#	CohortGrowDev
#
#_Cond	0	#custom_MG-env_setup	(0/1)
#_Cond	-2	2	0	0	-1	99	-2	#_placeholder	when	no	MG-environ	parameters
#
#_Cond	0	#custom_MG-block_setup	(0/1)
#_Cond	-2	2	0	0	-1	99	-2	#_placeholder	when	no	MG-block	parameters
#_Cond	No	MG	parm	trends
#
#_seasonal_effects_on_biology_parms
	0	0	0	0	0	0	0	0	0	0	#_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_Cond	-2	2	0	0	-1	99	-2	#_placeholder	when	no	seasonal	MG	parameters
#
#_Cond	-4	#_MGparm_Dev_Phase
#
#_Spawner-Recruitment
3	#_SR_function
#_LO	HI	INIT	PRIOR	PR_type	SD	PHASE
1 31 7.5 7.5 -1 10 1  # SR_R0
0.25 0.99 0.779	0.779  2 0.152 -3 # SR_steep
0	2	0.5	0.8	-1	0.8	-4	#	SR_sigmaR
-5	5	0.1	0	-1	1	-3	#	SR_envlink
-5	5	0	0	-1	1	-4	#	SR_R1_offset
0	0	0	0	-1	0	-99	#	SR_autocorr
0	#_SR_env_link
0	#_SR_env_target_0=none;1=devs;_2=R0;_3=steepness
1	#do_recdev:	0=none;	1=devvector;	2=simple	deviations
1962	#	first	year	of	main	recr_devs;	early	devs	can	preceed	this	era
2011	#	last	year	of	main	recr_devs;	forecast	devs	start	in	following	year
2	#_recdev	phase
1	#	(0/1)	to	read	13	advanced	options
1916	#_recdev_early_start	(0=none;	neg	value	makes	relative	to	recdev_start)
3	#_recdev_early_phase

5	#_forecast_recruitment	phase	(incl.	late	recr)	(0	value	resets	to	maxphase+1)
1	#_lambda	for	fore_recr_like	occurring	before	endyr+1
1962	#_last_early_yr_nobias_adj_in_MPD
1970	#_first_yr_fullbias_adj_in_MPD
2008	#_last_yr_fullbias_adj_in_MPD
2012	#_first_recent_yr_nobias_adj_in_MPD
0.5	#_max_bias_adj_in_MPD	(-1	to	override	ramp	and	set	biasadj=1.0	for	all	estimated	recdevs)
0	#_period	of	cycles	in	recruitment	(N	parms	read	below)
-5	#min	rec_dev
5	#max	rec_dev
0	#_read_recdevs
#_end	of	advanced	SR	options
#
#_placeholder	for	full	parameter	lines	for	recruitment	cycles
#	read	specified	recr	devs
#_Yr	Input_value
#
#	all	recruitment	deviations
#
#Fishing Mortality info
0.3 # F ballpark for tuning early phases
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
0.9 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
5  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms
#_LO HI INIT PRIOR PR_type SD PHASE
 0 1 0 0.01 0 99 -1 # InitF_1FISHERY1
 0 1 0 0.01 0 99 -1 # InitF_1FISHERY1
#
#_Q_setup
 # Q_type options:  <0=mirror, 0=median_float, 1=mean_float, 2=parameter, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
 #_Den-dep  env-var  extra_se  Q_type
 0 0 0 0 # 1 TRAWL
 0 0 0 0 # 2 BYCATCH
 0 0 0 0 # 3 Tri
 0 0 0 0 # 4 AFSC slope
 0 0 0 0 # 5 NWFSC slope
 0 0 0 0 # 6 NWFSC shelf-slope
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any)
# LO HI INIT PRIOR PR_type SD PHASE
# 0 5 0.01 0.01 0 99 1 # InitF_1FISHERY1
# 0 5 0.01 0.01 0 99 1 # InitF_1FISHERY1
# 0 5 0.01 0.01 0 99 1 # InitF_1FISHERY1
# 0 5 0.01 0.01 0 99 1 # InitF_1FISHERY1
#_SELEX_&_RETENTION_PARAMETERS
# Size-based setup
# A=Selex option: 1-24
# B=Do_retention: 0=no, 1=yes
# C=Male offset to female: 0=no, 1=yes
# D=Extra input (#)
# A B C D
# Size selectivity
1	1	0	0	 # TWL
15	0	0	1	 # NODISC
24	0	0	0	 # Late Triennial
24	0	0	0	 # AFSC Slope
24	0	0	0	 # NWFSC slope
15	0	0	5	 # NWFSC Combo
# Age selectivity
10	0	0	0  # Fishery
10	0	0	0  # NODISC
10	0	0	0   # Late Triennial
10	0	0	0   # AFSC Slope
10	0	0	0   # NWFSC Slope
10	0	0	0   # NWFSC Combo

# Selectivity parameters
# Lo	Hi	Init	Prior	Prior	Prior	Param	Env	Use	Dev	Dev	Dev	Block	block
# bnd	bnd 	value	mean	type	SD	phase	var	dev	minyr	maxyr	SD	design	switch
# Fishery age-based 
  # Selectivity parameters
# Lo	Hi	Init	Prior	Prior	Prior	Param	Env	Use	Dev	Dev	Dev	Block	block
# bnd	bnd 	value	mean	type	SD	phase	var	dev	minyr	maxyr	SD	design	switch
# Block design 1 means that parm’ = baseparm + blockparm, 2 means that parm’ = blockparm
# TWL Fishery length-based 
#18	40	24	24	-1	50	2	0	0	0	0	0	0	0 # Peak
#-6	4	-1	-1	-1	50	-2	0	0	0	0	0	0	0 # Top
#-1	9	2	4	-1	50	3	0	0	0	0	0	0	0 # Asc width
#-1	9	0	4	-1	50	3	0	0	0	0	0	0	0 # Desc width
#-5	9	-4.99	-4	-1	50	-4	0	0	0	0	0	0	0 # Init
#-5	9	1	-2	-1	50	2	0	0	0	0	0	0	0 # Final 
15	30	22	22	-1	99	2	0	0	0	0	0	0	0	#infl_for_logistic		
0.001	50	7	9	-1	99	3	0	0	0	0	0	0	0	#95%width_for_logistic
# TWL Retention			
10	35	25	25	-1	99	1	0	0	0	0	0.5	0	0 # Inflection
0.1	10	2	1	-1	99	1	0	0	0	0	0.5	0	0 # Slope	
0.001	1	0.95	0.95	-1	99	1	0	0	0	0	0.5	1	2 # Asymptote 
0	0	0	0	-1	99	-3	0	0	0	0	0.5	0	0 # Male offset
# Triennial Survey							
10	30	25	23	-1	50	2	0	0	0	0	0	0	0 # Peak
-6	4	-2	-2	-1	50	4	0	0	0	0	0	0	0 # Top
-1	9	3	4	-1	50	3	0	0	0	0	0	0	0 # Asc width
-1	9	3	4	-1	50	3	0	0	0	0	0	0	0 # Desc width
-5	9	-4.99	-4	-1	50	-4	0	0	0	0	0	0	0 # Init
-5	9	0	-2	-1	50	2	0	0	0	0	0	0	0 # Final 
# AKslope														
10	30	23.5	23.5	-1	50	2	0	0	0	0	0	0	0 # Peak
-6	4	-3	-3	-1	50	4	0	0	0	0	0	0	0 # Top
-1	9	3.5	4	-1	50	3	0	0	0	0	0	0	0 # Asc width
-1	9	2	4	-1	50	3	0	0	0	0	0	0	0 # Desc width
-5	9	-4.99	-4	-1	50	-4	0	0	0	0	0	0	0 # Init
-5	9	0	-2	-1	50	2	0	0	0	0	0	0	0 # Final 
# NWFSC slope and Combo	
10	30	26	26	-1	50	2	0	0	0	0	0	0	0 # Peak
-6	4	-4	-4	-1	50	4	0	0	0	0	0	0	0 # Top
-1	9	4	4	-1	50	3	0	0	0	0	0	0	0 # Asc width
-1	9	2	3	-1	50	3	0	0	0	0	0	0	0 # Desc width
-5	9	-4.99	-4	-1	50	-4	0	0	0	0	0	0	0 # Init
-5	9	0	-2	-1	50	2	0	0	0	0	0	0	0 # Final 													
#18	40	25	25	-1	99	2	0	0	0	0	0	0	0	#infl_for_logistic		
#0.001	50	11	15	-1	99	3	0	0	0	0	0	0	0	#95%width_for_logistic
1	# Selex block setup: 0=Read one line apply all, 1=read one line each parameter
# Lo	Hi	Init	Prior	P_type	SD	Phase
0.1	1	.9	.9	0	99	-1 #1999-2001
0.1	1	.8	.8	0	99	1  #2002
0.1	1	.8	.8	0	99	1
0.1	1	.9	.9	0	99	1
0.1	1	.9	.9	0	99	1
0.1	1	.7	.7	0	99	1
0.1	1	.7	.7	0	99	1
0.1	1	.5	.5	0	99	1
0.1	1	.5	.5	0	99	1
0.1	1	.7	.7	0	99	1
0.1	1	.95	.95	0	99	1
#
#0.001	1	.75	.75	0	99	1 #
#15	35	20	25	-1	99	1

1 #Selectivity parameters above are applied directly without regard to bounds

 # Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
1 #_Variance_adjustments_to_input_values
#_fleet: 1 2 3
#TWL NONTWL DISC TRI AKSL NWSL NWFSC
0 0 0 0 0 0 #_0add_to_survey_CV
0 0 0 0 0 0 #_add_to_discard_stddev
0 0 0 0 0 0 #_add_to_bodywt_CV
.15 1 .33 .37 1 .67 #_mult_by_lencomp_N
.31 1 1 1 1 1 #_mult_by_agecomp_N
1 1 1 1 1 1 #_mult_by_size-at-age_N
#
1 #_maxlambdaphase
1 #_sd_offset
#
0 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch;
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  sizefreq_method
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  1 1 1 1 #_CPUE/survey:_2
#  1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 #_lencomp:_1
#  1 1 1 1 #_lencomp:_2
#  0 0 0 0 #_lencomp:_3
#  1 1 1 1 #_agecomp:_1
#  1 1 1 1 #_agecomp:_2
#  0 0 0 0 #_agecomp:_3
#  1 1 1 1 #_size-age:_1
#  1 1 1 1 #_size-age:_2
#  0 0 0 0 #_size-age:_3
#  1 1 1 1 #_init_equ_catch
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
0 # (0/1) read specs for more stddev reporting

999
