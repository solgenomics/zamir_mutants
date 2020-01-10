

USE naama;




###########################   traits_mean table   ##################################





CREATE TABLE traits_mean (
   

id           INT UNSIGNED NOT NULL,		# Unique identifier
   

genotype     VARCHAR(10),
chr	     INT,	
   
background   VARCHAR(5),				
   
experiment   varchar(20) NOT NULL,
PW           FLOAT,
PW_sig       FLOAT,
FW           FLOAT,
FW_sig       FLOAT,
BX           FLOAT,
BX_sig       FLOAT,
TY	     FLOAT,
TY_sig       FLOAT,
BM           FLOAT,
BM_sig       FLOAT,
RED          FLOAT,
RED_sig      FLOAT,
HI           FLOAT,
HI_sig       FLOAT,
BXY          FLOAT,
BXY_sig      FLOAT,
EC	     FLOAT,
EC_sig       FLOAT,
IC           FLOAT,
IC_sig       FLOAT,
LEN          FLOAT,
LEN_sig      FLOAT,
WID          FLOAT,
WID_sig      FLOAT,
LEN_WID      FLOAT,
LEN_WID_sig  FLOAT,
PER          FLOAT,
PER_sig      FLOAT,
SW           FLOAT,
SW_sig       FLOAT,
L            FLOAT,
L_sig        FLOAT,
A            FLOAT,
A_sig        FLOAT,
B            FLOAT,
B_sig        FLOAT,
CAR          FLOAT,
CAR_sig      FLOAT,
LYC          FLOAT,
LYC_sig      FLOAT,
FIRM         FLOAT,
FIRM_SIG     FLOAT,
AT           FLOAT,
AT_SIG       FLOAT,
PH           FLOAT,
PH_SIG       FLOAT,
MS           FLOAT,
MS_SIG       FLOAT,
SUC          FLOAT,
SUC_SIG      FLOAT,
GLU          FLOAT,
GLU_SIG      FLOAT,
FRU          FLOAT,
FRU_SIG      FLOAT,
MAA          FLOAT,
MAA_SIG      FLOAT,
CIA          FLOAT,
CIA_SIG      FLOAT,
LON          FLOAT,
LON_SIG      FLOAT,
FN           FLOAT,
FN_SIG       FLOAT,
SHN          FLOAT,
SHN_SIG      FLOAT,
VEIN         FLOAT,
VEIN_SIG     FLOAT,
SHLD         FLOAT,
SHLD_SIG     FLOAT,
PLCT         FLOAT,
PLCT_SIG     FLOAT,
PUFF         FLOAT,
PUFF_SIG     FLOAT



);

