#C 2013 Assessent of Petrale (Haltuch, Ono, Valero) run with SS3.24O
#_data_and_control_files: petrale13.dat // petrale13.ctl
1   #_N_Growth_Patterns
1   #_N_Morphs_Within_GrowthPattern
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)

#Recruitment occurs in season 2 (summer)
#1   # N recruitment designs goes here if N_GP*nseas*area>1
#0   # placeholder for recruitment interaction request
#1 2 1   # recruitment design element for GP=1, seas=2, area=1

#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10

3 #_Nblock_Patterns
5 3 3 #_blocks_per_pattern
# begin and end years of blocks
1973 1982 1983 1992 1993 2002 2003 2010 2011 2012 # For selectivities of all fleets
2003 2009 2010 2010 2011 2012 # For retention of winter fleets
2003 2008 2009 2010 2011 2012 # For retention of summer fleets

0.5 #_fracfemale
0   #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#2 #_N_breakpoints
# 4 15 # age(real) at M breakpoints


1   # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=not implemented; 4=not implemented
2   #_Growth_Age_for_L1 (minimum age for growth calcs 
17  #_Growth_Age_for_L2 (999 to use as Linf) (maximum age for growth calcs)
0.0 #_SD_add_to_LAA 
0   #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A)
1   #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity  
#_placeholder for empirical age-maturity by growth pattern
3   #_First_Mature_Age
1   #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b
0   #hermaphrodite
1   #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
1   #_env/block/dev_adjust_method (1=standard; 2=with logistic trans to keep within base parm bounds)

#_growth_parms
#GP_1_Female
#LO     HI      INIT    PRIOR   PR_type SD  PHASE   env-var use_dev dev_minyr dev_maxyr dev_stddev  Block   Block_Fxn
0.005    0.50   0.1549     -1.888  3     0.3333 6       0       0       0           0       0.5         0       0           #1 F_M_young
10      45      16.27  17.18  -1      10    2       0       0       0           0       0.5         0       0           #2 F_L@Amin (Amin is age entered above)
35      80      47.86    58.7   -1      10    3       0       0       0           0       0.5         0       0           #3 F_L@Amax
0.04    0.5     0.27   0.13   -1      0.8   2       0       0       0           0       0.5         0       0           #4 F_VBK
0.01    1.00    0.08   3.0    -1      0.8   3       0       0       0           0       0.5         0       0           #5 CV@LAAFIX
0.01    1.0     0.08    0.0     -1      1       4       0 0 0 0 0 0 0  # CV@LAAFIX2
#GP_1:::Male (Direct Estimation)
0.005    0.60   0.1749     -1.580  3     0.3326 6       0       0       0           0       0.5         0       0           #1 M_M_young
10      45      16.27  17.18  -1      10    2       0       0       0           0       0.5         0       0           #2 M_L@Amin (Amin is age entered above)
35      80      47.86    58.7   -1      10    3       0       0       0           0       0.5         0       0           #3 M_L@Amax
0.04    0.5     0.27   0.13   -1      0.8   2       0       0       0           0       0.5         0       0           #4 M_VBK
0.01    1.00    0.08   3.0    -1      0.8   3       0       0       0           0       0.5         0       0           #5 M_CV@LAAFIX
0.01    1.0     0.08    0.0     -1      1       4       0 0 0 0 0 0 0  # M_CV@LAAFIX2

#LW_female
#LO     HI      INIT        PRIOR       PR_type SD  PHASE   env-var use_dev dev_minyr dev_maxyr dev_stddev  Block   Block_Fxn
-3      3       2.08296E-06    2.08296E-06    0       0.8 -3      0       0       0   0   0.5 0   0   #WL_intercept_female    
1       5       3.473703       3.473703       0       0.8 -3      0       0       0   0   0.5 0   0   #WL_slope_female    
#Female_maturity
10      50      33.1        33.1        0       0.8 -3  0   0   0   0   0.5 0   0   #mat_intercept  #L50
-3      3       -0.743      -0.743      0       0.8 -3  0   0   0   0   0.5 0   0   #mat_slope  From Hannah et al 2002
#Fecundity___Assume_same_as_spawning_biomass
-3      3       1           1           0       1   -3  0   0   0   0   0.5 0   0   #mat_intercept  #L50
-3      3       0           0           0       1   -3  0   0   0   0   0.5 0   0   #mat_slope  
#LW_Male
-3      3       3.05E-06    3.05E-06    0       0.8 -3  0   0   0   0   0.5 0   0   #WL_intercept_male  
-3      5       3.360544       3.360544       0       0.8 -3  0   0   0   0   0.5 0   0   #WL_slope_slope_male    

#LO     HI      INIT    PRIOR   PR_type SD  PHASE   env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
#Allocate_R_by_areas_x_gmorphs
0   1   1   0.2 0   9.8 -3  0   0   0   0   0.5 0   0   #frac to GP 1 in area 1
#Allocate_R_by_areas_(1_areain_this_case)
0   1   1   1   0   9.8 -3  0   0   0   0   0.5 0   0   #frac R in area 1
#Allocate_R_by_season_(2seasons_in_this_case)
#LO     HI      INIT        PRIOR       PR_type SD  PHASE   env-var use_dev dev_minyr dev_maxyr dev_stddev  Block   Block_Fxn
-4      4       0          1           0       9.8 -3      0       0           0       0           0.5     0   0   #frac R in season 1 

#CohortGrowDev
#SS3 manual says it must be given a value of 1 and a negative phase
#LO HI  INIT    PRIOR   PR_type SD  PHASE   env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
0   1   1   1   -1  0   -4  0   0   0   0   0   0   0

#_Cond 0  #custom_MG-env_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters

#_Cond 0  #custom_MG-block_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters

#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,L1,K,Malewtlen1,malewtlen2,L1,K      
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters

#_Cond -4 #_MGparm_Dev_Phase

#_Spawner-Recruitment
3   #_SR_function
#_LO    HI  INIT    PRIOR   PR_type SD  PHASE
5       20  10      9       -1      10   1       #Ln(R0)
0.2     1   0.85    0.8     0      0.09  5       #steepness(h)
0       2   0.4     0.9     0       5       -99     #sigmaR 
-5      5   0       0       0       1       -99     #Env_link_parameter
-5      5   0       0       0       0.2     -2      # SR_R1_offset
0       0   0       0       -1      0       -99     # SR_autocorr
0   #_SR_env_link
0   #_SR_env_target_0=none;1=devs;_2=R0;_3=steepness

1   #do_recdev:  0=none; 1=devvector; 2=simple deviations

1959    # first year of main recr_devs; early devs can preceed this era
2009    # last year of main recr_devs; forecast devs start in following year
1   #_recdev phase
1   # (0/1) to read 13 advanced options
1845 #_Cond 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
3   #_recdev_early_phase
0   #_Cond 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1   #_Cond 1 #_lambda for prior_fore_recr occurring before endyr+1
1944    #_last_early_yr_nobias_adj_in_MPD
1964    #_first_yr_fullbias_adj_in_MPD
2009    #_last_yr_fullbias_adj_in_MPD
2012    #_first_recent_yr_nobias_adj_in_MPDadj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0.80   #max bias
0   #period of cycles in recruitment
-4  #min rec_dev
4   #max rec_dev
0 #67   #_read_recdevs
#_end of advanced SR options

#Fishing Mortality info
0.3 # F ballpark for tuning early phases
-2001   # F ballpark year (neg value to disable)
3   # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4   # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# read overall start F value; overall phase; N detailed inputs to read for Fmethod 2
# NUM ITERATIONS, FOR CONDITION 3
5   # read N iterations for tuning for Fmethod 3 (recommend 3 to 7)
#Fleet Year Seas F_value se phase (for detailed setup of F_Method=2)

#_initial_F_parms
#_LO HI INIT PRIOR PR_type  SD PHASE
0   1   0   0.0001  0       99  -1  #Fleet1_(WinterN)
0   1   0   0.0001  0       99  -1  #Fleet2_(SummerN)
0   1   0   0.0001  0       99  -1  #Fleet3_(WinterS)
0   1   0   0.0001  0       99  -1  #Fleet4_(SummerS)

#_Q_setup
#D=devtype(<0=mirror, 0/1=none, 2=cons, 3=rand, 4=randwalk)
#E=0=num/1=bio, F=err_type
#DISCUSS WHICH OPTION FOR Q (0 OR 1, OR 2)
#do power, env-var, extra SD, dev type
#do power for commercial CPUE, estimating extra SD, estimating q
1   0   0   4      #Fleet1_(WinterN)
0   0   0   0      #Fleet2_(SummerN)
1   0   0   4      #Fleet3_(WinterS)
0   0   0   0      #Fleet4_(SummerS)
0   0   1   0      #Fleet5 Triennial
0   0   1   0      #Fleet6 Triennial
0   0   0   0      #Fleet7 NWFSC

1 #_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
# LO HI INIT PRIOR PR_type SD PHASE
-5	5	0.38	0	-1	99	3	#		(log)	power	parameter N Winter			
-5	5	0.16	0	-1	99	3	#		(log)	power	parameter S Winter			
#parameter lines for extra SD for fishery CPUE and surveys
#Prior type -1 = none, 0=normal, 1=symmetric beta, 2=full beta, 3=lognormal
#-5	5	0.4	  0.5	  -1  99	5	#				
#-5	5	0.4	  0.5	  -1  99	5	#				
0.001	2	0.28	0.22	-1	99	5	#				
0.001	2	0.15	0.16	-1	99	4	#				
#-1	2	0   0.06	-1	99	5	#				
#parameter lines for winter index q's
-20	5	-9	0	-1	99	1	#		estimate q parameter N Winter			
-20 5    0 -1   -1  99 -1 #1988	
-20 5    0 -1   -1  99 -1 #1989	
-20 5    0 -1   -1  99 -1 #1990	
-20 5    0 -1   -1  99 -1 #1991	
-20 5    0 -1   -1  99 -1 #1992	
-20 5    0 -1   -1  99 -1 #1993	
-20 5    0 -1   -1  99 -1 #1994	
-20 5    0 -1   -1  99 -1 #1995	
-20 5    0 -1   -1  99 -1 #1996	
-20 5    0 -1   -1  99 -1 #1997	
-20 5    0 -1   -1  99 -1 #1998	
-20 5    0 -1   -1  99 -1 #1999	
-20 5    0 -1   -1  99 -1 #2000	
-20 5    0 -1   -1  99 -1 #2001	
-20 5    0 -1   -1  99 -1 #2002	
-20 5    0 -1   -1  99 -1 #2003	
-20 5    0 -1   -1  99 7 #2004	
-20 5    0 -1   -1  99 -7 #2005	
-20 5    0 -1   -1  99  -7 #2006	
-20 5    0 -1   -1  99  -7 #2007	
-20 5    0 -1   -1  99  -7 #2008	
-20 5    0 -1   -1  99  -7 #2009	

-20	5	-6	0	-1	99	1	#		estimate q parameter S Winter			
-20 5    0 -1   -1  99 -1 #1988	
-20 5    0 -1   -1  99 -1 #1989	
-20 5    0 -1   -1  99 -1 #1990	
-20 5    0 -1   -1  99 -1 #1991	
-20 5    0 -1   -1  99 -1 #1992	
-20 5    0 -1   -1  99 -1 #1993	
-20 5    0 -1   -1  99 -1 #1994	
-20 5    0 -1   -1  99 -1 #1995	
-20 5    0 -1   -1  99 -1 #1996	
-20 5    0 -1   -1  99 -1 #1997	
-20 5    0 -1   -1  99 -1 #1998	
-20 5    0 -1   -1  99 -1 #1999	
-20 5    0 -1   -1  99 -1 #2000	
-20 5    0 -1   -1  99 -1 #2001	
-20 5    0 -1   -1  99 -1 #2002	
-20 5    0 -1   -1  99 -1 #2003	
-20 5    0 -1   -1  99 7 #2004	
-20 5    0 -1   -1  99 -7 #2005	
-20 5    0 -1   -1  99  -7 #2006	
-20 5    0 -1   -1  99  -7 #2007	
-20 5    0 -1   -1  99  -7 #2008	
-20 5    0 -1   -1  99  -7 #2009	

#Seltype(1,2*Ntypes,1,4)    #SELEX_&_RETENTION_PARAMETERS
#Size_Slectivity,_enter_4_cols
#N_sel  Do_retain   Do_male Special
24      1           3       0   #Fleet(WinterN)
24      1           3       0   #Fleet(SummerN)
24      1           3       0   #Fleet(WinterS)
24      1           3       0   #Fleet(SummerS)
24      0           3       0   #Triennial early
24      0           3       0   #Triennial late
24      0           3       0   #NWFSC

#Age_selectivity    #set_to_1
10      0           0       0   #Fleet(WinterN) 
10      0           0       0   #Fleet(SummerN) 
10      0           0       0   #Fleet(WinterS) 
10      0           0       0   #Fleet(SummerS) 
10      0           0       0   #Triennial early
10      0           0       0   #Triennial late
10      0           0       0   #NWFSC

#Selectivity parameters
#Size_selectivity for FISHERY WINTER N
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      75  50        43.1    -1     5   1   0   0   0   0   0.5 1   1   #PEAK (see Selex24.xls)
-5      3   3.0        0.7    -1    5   -3  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  4          3.42    -1     5   2   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0        0.21   -1    5   -3  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999       -8.9    -1    5  -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999       0.15   -1    5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#RETENTION
10      40  26.47         15      -1  9   1   0   0   0   0   0   2   1   # Retain_1 Inflection
0.1     10  3.026          3       -1  9  2   0   0   0   0   0   2   1   # Retain_2 Slope
0.001   1   0.9945      1       -1  9   4   0   0   0   0   0   2   1   # Retain_3 Asymptote
-10     10  0          0       -1  9   -2  0   0   0   0   0   0   0   # Retain_4 Male offset (additive)
#...DO_MALE (AS OFFSET)
-15     15      -4         0   -1      5   3   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-15     15      -1         0   -1      5   4   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-15     15      0            0   -1    5   -4  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     15      0            0   -1    5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
-15     15      1            0   -1    5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)
#Size_selectivity for FISHERY SUMMER N
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      75  50      43.1    -1      5   1   0   0   0   0   0.5 1   1   #PEAK (see Selex24.xls)
-5      3   3.0      0.7     -1      5  -3  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  4.5      3.42    -1      5   2   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0      0.21    -1      5  -3  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999     -8.9    -1      5  -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999     0.15    -1      5  -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#RETENTION
10      40  30.869   15      -1      9   1   0   0   0   0   0   3   1   # Retain_1 Inflection
0.1     10  1.2977    3       -1      9  2   0   0   0   0   0   3   1   # Retain_2 Slope
0.001   1   0.9935   1       -1      9  4   0   0   0   0   0   3   1   # Retain_3 Asymptote
-10     10  0       0       -1      9  -2  0   0   0   0   0   0   0   # Retain_4 Male offset (additive)
#...DO_MALE (AS OFFSET)
-20     15      0    0  -1     -5    3   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-15     15      -1.0    0  -1     -5    4   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-15     15      0       0   -1      5   -4  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     15      0       0   -1      5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
-15     15      1       0   -1      5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)
#Size_selectivity for FISHERY WINTER S
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      75  44.5116  43.1    -1      5   1   0   0   0   0   0.5 1   1   #PEAK (see Selex24.xls)
-5      3   3.0      0.7     -1      5   -3  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  4.5070   3.42    -1      5   2   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0      0.21    -1      5   -3  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999     -8.9    -1      5   -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999     0.15    -1      5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#RETENTION
10      40  27.716  15      -1      9   1   0   0   0   0   0   2   1   # Retain_1 Inflection
0.1     10  1.8483   3       -1      9  2   0   0   0   0   0   2   1   # Retain_2 Slope
0.001   1   0.999     1       -1      9 4   0   0   0   0   0   2   1   # Retain_3 Asymptote
-10     10  0       0       -1      9   -2  0   0   0   0   0   0   0   # Retain_4 Male offset (additive)
#...DO_MALE (AS OFFSET)
-15     15      -11.5284  0   -1   5   3   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-15     15      -2.5591   0   -1   5   4   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-15     15      0         0   -1   5   -4  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     15      0         0   -1   5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
-15     15      1         0   -1   5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)
#Size_selectivity for FISHERY SUMMER S
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      75  39.7903  43.1    -1      5   1   0   0   0   0   0.5 1   1   #PEAK (see Selex24.xls)
-5      3   3.0      0.7     -1      5   -3  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  3.9017   3.42    -1      5   2   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0      0.21    -1      5   -3  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999     -8.9    -1      5   -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999      0.15    -1     5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#RETENTION
10      40  27.346  15      -1      9  1   0   0   0   0   0   3   1   # Retain_1 Inflection
0.1     10  1.68   3       -1      9   2   0   0   0   0   0   3   1   # Retain_2 Slope
0.001   1   0.9995   1       -1      9  4   0   0   0   0   0   3   1   # Retain_3 Asymptote
-10     10  0       0       -1      9   -2  0   0   0   0   0   0   0   # Retain_4 Male offset (additive)
#...DO_MALE (AS OFFSET)
-15     15      -5.6710   0   -1      5   3   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-15     15      -1.5100   0   -1      5   4   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-15     15      0         0   -1      5   -4  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     15      0         0   -1      5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
-15     15      1         0   -1      5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)
#Size_selectivity for TRIENNIAL SURVEY early
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      61  35.4319   43.1    -1      5   1   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-5      3   3.0       0.7     -1      5   -2  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  4.2436    3.42    -1      5   1   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0       0.21    -1      5   -2  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999      -8.9    -1      5   -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999      0.15    -1      5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#...DO_MALE (AS OFFSET)
-15   15  -4.1823  0  -1      5   2       0       0       0       0       0.5     0       0       #PEAK (see Selex24.xls)
-15   15  -0.5322  0  -1      5   2       0       0       0       0       0.5     0       0       #ASC_WIDTH (see Selex24.xls)
-15   15  0       0   -1      5   -3      0       0       0       0       0.5     0       0       #DSC_WIDTH (see Selex24.xls)
-15   15  0       0   -1      5   -3      0       0       0       0       0.5     0       0       #FINAL (see Selex24.xls)
-15   15  1       0   -1      5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)
#Size_selectivity for TRIENNIAL SURVEY late
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      61  38.3545  43.1    -1      5   1   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-5      3   3.0      0.7     -1      5   -2  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  4.8335   3.42    -1      5   1   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0      0.21    -1      5   -2  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999     -8.9    -1      5   -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999     0.15    -1      5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#...DO_MALE (AS OFFSET)
-15  15  -4.0542  0  -1      5   2       0       0       0       0       0.5     0       0       #PEAK (see Selex24.xls)
-15  15  -0.1367  0  -1      5   2       0       0       0       0       0.5     0       0       #ASC_WIDTH (see Selex24.xls)
-15  15  0       0   -1      5   -3      0       0       0       0       0.5     0       0       #DSC_WIDTH (see Selex24.xls)
-15  15  0       0   -1      5   -3      0       0       0       0       0.5     0       0       #FINAL (see Selex24.xls)
-15  15  1       0   -1      5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)
#Size_selectivity for NWFSC SURVEY
#FEMALE
#LO     HI  INIT    PRIOR   PR_TYPE SD  PHASE   env-var use_dev dev_yr1 dev_yr2 dev_sd  nblks   blk_pat #
15      61  42.7077   43.1    -1      5   1   0   0   0   0   0.5 0   0   #PEAK (see Selex24.xls)
-5      3   3.0       0.7     -1      5   -2  0   0   0   0   0.5 0   0   #TOP (see Selex24.xls)
-4      12  5.1017    3.42    -1      5   1   0   0   0   0   0.5 0   0   #ASC_WIDTH (see Selex24.xls)
-2      15   14.0       0.21    -1      5   -2  0   0   0   0   0.5 0   0   #DSC_WIDTH (see Selex24.xls)
-15     5   -999      -8.9    -1      5   -4   0   0   0   0   0.5 0   0   #INIT (see Selex24.xls)
-5      5   -999      0.15    -1      5   -4  0   0   0   0   0.5 0   0   #FINAL (see Selex24.xls)
#...DO_MALE (AS OFFSET)
-15   15  -7.3384  0  -1      5   2       0       0       0       0       0.5     0       0       #PEAK (see Selex24.xls)
-15   15  -0.5892  0  -1      5   2       0       0       0       0       0.5     0       0       #ASC_WIDTH (see Selex24.xls)
-15   15  0       0   -1      5   -3      0       0       0       0       0.5     0       0       #DSC_WIDTH (see Selex24.xls)
-15   15  0       0   -1      5   -3      0       0       0       0       0.5     0       0       #FINAL (see Selex24.xls)
-15   15  1       0   -1      5   -4  0   0   0   0   0.5 0   0   #APICAL SEL (see Selex24.xls)

1 #_custom block setup (0/1)
 -3 2 0 0 -1 99 4 # SizeSel_1P_1_WinterN_BLK1add_1973
 -3 2 0 0 -1 99 4 # SizeSel_1P_1_WinterN_BLK1add_1983
 -3 2 0 0 -1 99 4 # SizeSel_1P_1_WinterN_BLK1add_1993
 -3 2 0 0 -1 99 4 # SizeSel_1P_1_WinterN_BLK1add_2003
 -3 2 0 0 -1 99 4 # SizeSel_1P_1_WinterN_BLK1add_2011
 -3 2 0 0 -1 99 4 # Retain_1P_1_WinterN_BLK2add_2003
 -3 2 0 0 -1 99 4 # Retain_1P_1_WinterN_BLK2add_2010
 -3 2 0 0 -1 99 4 # Retain_1P_1_WinterN_BLK2add_2011
 -3 2 0 0 -1 99 4 # Retain_1P_2_WinterN_BLK2add_2003
 -3 2 0 0 -1 99 4 # Retain_1P_2_WinterN_BLK2add_2010
 -3 2 0 0 -1 99 4 # Retain_1P_2_WinterN_BLK2add_2011
 -3 2 0 0 -1 99 4 # Retain_1P_3_WinterN_BLK2add_2003
 -3 2 0 0 -1 99 4 # Retain_1P_3_WinterN_BLK2add_2010
 -3 2 0 0 -1 99 4 # Retain_1P_3_WinterN_BLK2add_2011
 -3 2 0 0 -1 99 4 # SizeSel_2P_1_SummerN_BLK1add_1973
 -3 2 0 0 -1 99 4 # SizeSel_2P_1_SummerN_BLK1add_1983
 -3 2 0 0 -1 99 4 # SizeSel_2P_1_SummerN_BLK1add_1993
 -3 2 0 0 -1 99 4 # SizeSel_2P_1_SummerN_BLK1add_2003
 -3 2 0 0 -1 99 4 # SizeSel_2P_1_SummerN_BLK1add_2011
 -3 2 0 0 -1 99 4 # Retain_2P_1_SummerN_BLK3add_2003
 -3 2 0 0 -1 99 4 # Retain_2P_1_SummerN_BLK3add_2009
 -3 2 0 0 -1 99 4 # Retain_2P_1_SummerN_BLK3add_2011
 -3 2 0 0 -1 99 4 # Retain_2P_2_SummerN_BLK3add_2003
 -3 2 0 0 -1 99 4 # Retain_2P_2_SummerN_BLK3add_2009
 -3 2 0 0 -1 99 4 # Retain_2P_2_SummerN_BLK3add_2011
 -3 2 0 0 -1 99 4 # Retain_2P_3_SummerN_BLK3add_2003
 -3 2 0 0 -1 99 4 # Retain_2P_3_SummerN_BLK3add_2009
 -3 2 0 0 -1 99 4 # Retain_2P_3_SummerN_BLK3add_2011
 -3 2 0 0 -1 99 4 # SizeSel_3P_1_WinterCA_BLK1add_1973
 -3 2 0 0 -1 99 4 # SizeSel_3P_1_WinterCA_BLK1add_1983
 -3 2 0 0 -1 99 4 # SizeSel_3P_1_WinterCA_BLK1add_1993
 -3 2 0 0 -1 99 4 # SizeSel_3P_1_WinterCA_BLK1add_2003
 -3 2 0 0 -1 99 4 # SizeSel_3P_1_WinterCA_BLK1add_2011
 -3 2 0 0 -1 99 4 # Retain_3P_1_WinterCA_BLK2add_2003
 -3 2 0 0 -1 99 4 # Retain_3P_1_WinterCA_BLK2add_2010
 -3 2 0 0 -1 99 4 # Retain_3P_1_WinterCA_BLK2add_2011
 -3 2 0 0 -1 99 4 # Retain_3P_2_WinterCA_BLK2add_2003
 -3 2 0 0 -1 99 4 # Retain_3P_2_WinterCA_BLK2add_2010
 -3 2 0 0 -1 99 4 # Retain_3P_2_WinterCA_BLK2add_2011
 -3 4 0 0 -1 99 4 # Retain_3P_3_WinterCA_BLK2add_2003
 -3 2 0 0 -1 99 4 # Retain_3P_3_WinterCA_BLK2add_2010
 -3 2 0 0 -1 99 4 # Retain_3P_3_WinterCA_BLK2add_2011
 -3 2 0 0 -1 99 4 # SizeSel_4P_1_SummerCA_BLK1add_1973
 -3 2 0 0 -1 99 4 # SizeSel_4P_1_SummerCA_BLK1add_1983
 -3 2 0 0 -1 99 4 # SizeSel_4P_1_SummerCA_BLK1add_1993
 -3 2 0 0 -1 99 4 # SizeSel_4P_1_SummerCA_BLK1add_2003
 -3 2 0 0 -1 99 4 # SizeSel_4P_1_SummerCA_BLK1add_2011
 -3 2 0 0 -1 99 4 # Retain_4P_1_SummerCA_BLK3add_2003
 -3 2 0 0 -1 99 4 # Retain_4P_1_SummerCA_BLK3add_2009
 -3 2 0 0 -1 99 4 # Retain_4P_1_SummerCA_BLK3add_2011
 -3 2 0 0 -1 99 4 # Retain_4P_2_SummerCA_BLK3add_2003
 -3 2 0 0 -1 99 4 # Retain_4P_2_SummerCA_BLK3add_2009
 -3 2 0 0 -1 99 4 # Retain_4P_2_SummerCA_BLK3add_2011
 -3 2 0 0 -1 99 4 # Retain_4P_3_SummerCA_BLK3add_2003
 -3 2 0 0 -1 99 4 # Retain_4P_3_SummerCA_BLK3add_2009
 -3 2 0 0 -1 99 4 # Retain_4P_3_SummerCA_BLK3add_2011

2   #logistic bounding

# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters

1 #_Variance_adjustments_to_input_values
0 0 0 0 0 0 0  #_add_to_survey_CV
0.02 0.02 0.02 0.02 0 0 0 #_add_to_discard_stddev
0 0 0 0 0 0 0 #_add_to_bodywt_CV
2	1.4	1.6	1.2	1.3	1	1	#_mult_by_lencomp_N
7 1.7 1.9 1.4 1 1 0.3    #_mult_by_agecomp_N
1 1 1 1 1 1 1  #_mult_by_size-at-age_N

15 #_maxlambdaphase
1 #_sd_offset

10 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch;
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  sizefreq_method
1 1 1 1.0 1  #Winter N CPUE
1 3 1 1.0 1  #Winter S CPUE
5 1 1 0.5 1  #commercial age comps
5 2 1 0.5 1  #commercial age comps
5 3 1 0.5 1  #commercial age comps
5 4 1 0.5 1  #commercial age comps
4 1 1 0.5 1  #commercial lgth comps
4 2 1 0.5 1  #commercial lgth comps
4 3 1 0.5 1  #commercial lgth comps
4 4 1 0.5 1  #commercial lgth comps

0 # (0/1) read specs for more stddev reporting
# 1 1 -1 5 1 5 # selex type, len/age, year, N selex bins, Growth pattern, N growth ages
# -5 16 27 38 46 # vector with selex std bin picks (-1 in first bin to self-generate)
# 1 2 14 26 40 # vector with growth std bin picks (-1 in first bin to self-generate)

999
