* Encoding: GBK.

RECODE v26 v37 v2 v8 v10 v17 v33 v50 v62 v80 v4 v7 v15 v21 v25 v39 v45 v52 v55 v60
     v64 v71 v75 v83 (0=1) (1=0).
EXECUTE.

COMPUTE E_scale=SUM(v1,v5,v9,v13,v16,v22,v29,v32,v35,v40,v43,v46,v49,v53,v56,v61,v72,v76,v85,v26,v37).
COMPUTE N_scale=SUM(v3,v6,v11,v14,v18,v20,v24,v28,v30,v34,v36,v42,v47,v51,v54,v59,v63,v66,v67,v70,v74,v78,v82,v84).
COMPUTE P_scale=SUM(v19,v23,v27,v38,v41,v44,v57,v58,v65,v69,v73,v77,v2,v8,v10,v17,v33,v50,v62,v80).
COMPUTE L_scale=SUM(v12,v31,v48,v68,v79,v81,v4,v7,v15,v21,v25,v39,v45,v52,v55,v60,v64,v71,v75,v83).

EXECUTE.     


