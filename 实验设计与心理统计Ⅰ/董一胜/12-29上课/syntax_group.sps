* Encoding: GBK.

DATASET ACTIVATE DataSet1.
DO IF  (Sex = 1).
RECODE P_scale (Lowest thru 11.1=0) (11.2 thru 16.77=1) (16.77 thru Highest=2) INTO P_rank_1.
END IF.
VARIABLE LABELS  P_rank_1 'group'.
EXECUTE.

DO IF  (Sex = 0).
RECODE P_scale (Lowest thru 10.81=0) (10.81 thru 15.35=1) (15.35 thru Highest=2) INTO P_rank_0.
END IF.
VARIABLE LABELS  P_rank_0 'group'.
EXECUTE.


DO IF  (Sex = 1).
RECODE E_scale (Lowest thru 10.47=0) (10.47 thru 16.51=1) (16.51 thru Highest=2) INTO E_rank_1.
END IF.
VARIABLE LABELS  E_rank_1 'E_group_1'.
EXECUTE.

DO IF  (Sex = 0).
RECODE E_scale (Lowest thru 8.98=0) (8.98 thru 15.88=1) (15.88 thru Highest=2) INTO E_rank_0.
END IF.
VARIABLE LABELS  E_rank_0 'E_group_0'.
EXECUTE.


DO IF  (Sex = 1).
RECODE N_scale (Lowest thru 12.47=0) (12.47 thru 19.49=1) (19.49 thru Highest=2) INTO N_rank_1.
END IF.
VARIABLE LABELS  N_rank_1 'N_group_1'.
EXECUTE.

DO IF  (Sex = 0).
RECODE N_scale (Lowest thru 12.80=0) (12.80 thru 19.88=1) (19.88 thru Highest=2) INTO N_rank_0.
END IF.
VARIABLE LABELS  N_rank_0 'N_group_0'.
EXECUTE.


DO IF  (Sex = 1).
RECODE L_scale (Lowest thru 9.13=0) (9.13 thru 15.83=1) (15.83 thru Highest=2) INTO L_rank_1.
END IF.
VARIABLE LABELS  L_rank_1 'L_group_1'.
EXECUTE.

DO IF  (Sex = 0).
RECODE L_scale (Lowest thru 10.2=0) (10.2 thru 16.84=1) (16.84 thru Highest=2) INTO L_rank_0.
END IF.
VARIABLE LABELS  L_rank_0 'L_group_0'.
EXECUTE.

