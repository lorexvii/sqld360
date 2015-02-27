-- PLAN_TABLE / ASH columns mapping
-- statement_id     'SQLD360_ASH_DATA'
-- timestamp        sample_time
-- remarks,         sql_id
-- cardinality      snap_id 
-- search_columns   dbid
-- operation        sql_plan_operation  skipped in 10g
-- options          sql_plan_options  skipped in 10g
-- object_instance  current_obj#
-- object_node      nvl(event,'ON CPU')
-- position         instance_number
-- cost             PHV
-- other_tag        wait_class
-- id               sql_plan_line_id   skipped in 10g
-- partition_id     sql_exec_id
-- distribution     sql_exec_start
-- cpu_cost         session_id
-- io_cost          session_serial#
-- parent_id        sample_id

DEF skip_lch = 'Y';
DEF skip_pch = 'Y';

COL db_name FOR A9;
COL host_name FOR A64;
COL instance_name FOR A16;
COL db_unique_name FOR A30;
COL platform_name FOR A101;
COL version FOR A17;

COL elapsed_time FOR 999999990;
COL cpu_time FOR 999999990;

------------------------------
------------------------------


DEF main_table = 'V$ACTIVE_SESSION_HISTORY';
DEF abstract = 'SQL Peak Demand for recent executions';
DEF foot = 'Data rounded to the 1 second'


BEGIN
  :sql_text_backup := '
SELECT 0 snap_id,
       TO_CHAR(end_time, ''YYYY-MM-DD HH24:MI'') begin_time, 
       TO_CHAR(end_time, ''YYYY-MM-DD HH24:MI'') end_time,
       num_samples_min,
       num_samples_oncpu_min,
       0 dummy_03,
       0 dummy_04,
       0 dummy_05,
       0 dummy_06,
       0 dummy_07,
       0 dummy_08,
       0 dummy_09,
       0 dummy_10,
       0 dummy_11,
       0 dummy_12,
       0 dummy_13,
       0 dummy_14,
       0 dummy_15
  FROM (SELECT TRUNC(end_time, ''hh24'') end_time,
               MAX(num_samples_min) num_samples_min,
               MAX(num_samples_oncpu_min) num_samples_oncpu_min
          FROM (SELECT TRUNC(timestamp, ''mi'') end_time,
                       COUNT(*) num_samples_min, 
                       SUM(CASE WHEN object_node = ''ON CPU'' THEN 1 ELSE 0 END) num_samples_oncpu_min
                  FROM plan_table
                 WHERE statement_id = ''SQLD360_ASH_DATA_MEM''
                   AND position =  @instance_number@
                   AND remarks = ''&&sqld360_sqlid.''
                   AND ''&&diagnostics_pack.'' = ''Y''
                 GROUP BY TRUNC(timestamp, ''mi''))
         GROUP BY TRUNC(end_time, ''hh24''))
 ORDER BY 3
';
END;
/

DEF chartype = 'LineChart';
DEF stacked = '';
DEF skip_lch = '';
DEF tit_01 = 'Peak Demand';
DEF tit_02 = 'Peak CPU Demand';
DEF tit_03 = '';
DEF tit_04 = '';
DEF tit_05 = '';
DEF tit_06 = '';
DEF tit_07 = '';
DEF tit_08 = '';
DEF tit_09 = '';
DEF tit_10 = '';
DEF tit_11 = '';
DEF tit_12 = '';
DEF tit_13 = '';
DEF tit_14 = '';
DEF tit_15 = '';

DEF skip_lch = '';
DEF skip_all = '&&is_single_instance.';
DEF title = 'SQL Peak Demand for recent execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'SQL Peak Demand for recent execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'SQL Peak Demand for recent execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'SQL Peak Demand for recent execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'SQL Peak Demand for recent execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'SQL Peak Demand for recent execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'SQL Peak Demand for recent execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'SQL Peak Demand for recent execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'SQL Peak Demand for recent execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql


------------------------------
------------------------------


DEF main_table = 'DBA_HIST_ACTIVE_SESS_HISTORY';
DEF abstract = 'SQL Peak Demand for historical executions';
DEF foot = 'Data rounded to the 10 seconds'


BEGIN
  :sql_text_backup := '
SELECT b.snap_id snap_id,
       TO_CHAR(b.begin_interval_time, ''YYYY-MM-DD HH24:MI'')  begin_time, 
       TO_CHAR(b.end_interval_time, ''YYYY-MM-DD HH24:MI'')  end_time,
       NVL(num_samples_min,0) num_samples_min,
       NVL(num_samples_oncpu_min,0) num_samples_oncpu_min,
       0 dummy_03,
       0 dummy_04,
       0 dummy_05,
       0 dummy_06,
       0 dummy_07,
       0 dummy_08,
       0 dummy_09,
       0 dummy_10,
       0 dummy_11,
       0 dummy_12,
       0 dummy_13,
       0 dummy_14,
       0 dummy_15
  FROM (SELECT snap_id,
               MAX(num_samples_min) num_samples_min,
               MAX(num_samples_oncpu_min) num_samples_oncpu_min
          FROM (SELECT cardinality snap_id,
                       TRUNC(timestamp, ''mi'') end_time,
                       SUM(10) num_samples_min, 
                       SUM(CASE WHEN object_node = ''ON CPU'' THEN 10 ELSE 0 END) num_samples_oncpu_min
                  FROM plan_table
                 WHERE statement_id = ''SQLD360_ASH_DATA_HIST''
                   AND position =  @instance_number@
                   AND remarks = ''&&sqld360_sqlid.''
                   AND ''&&diagnostics_pack.'' = ''Y''
                 GROUP BY cardinality, TRUNC(timestamp, ''mi''))
         GROUP BY snap_id) ash,
       dba_hist_snapshot b
 WHERE ash.snap_id(+) = b.snap_id
   AND b.snap_id BETWEEN &&minimum_snap_id. AND &&maximum_snap_id.
 ORDER BY 3
';
END;
/

DEF chartype = 'LineChart';
DEF stacked = '';

DEF tit_01 = 'Peak Demand';
DEF tit_02 = 'Peak CPU Demand';
DEF tit_03 = '';
DEF tit_04 = '';
DEF tit_05 = '';
DEF tit_06 = '';
DEF tit_07 = '';
DEF tit_08 = '';
DEF tit_09 = '';
DEF tit_10 = '';
DEF tit_11 = '';
DEF tit_12 = '';
DEF tit_13 = '';
DEF tit_14 = '';
DEF tit_15 = '';

DEF skip_lch = '';
DEF skip_all = '&&is_single_instance.';
DEF title = 'SQL Peak Demand for historical execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'SQL Peak Demand for historical execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'SQL Peak Demand for historical execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'SQL Peak Demand for historical execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'SQL Peak Demand for historical execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'SQL Peak Demand for historical execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'SQL Peak Demand for historical execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'SQL Peak Demand for historical execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'SQL Peak Demand for historical execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql



------------------------------
------------------------------

DEF main_table = 'V$ACTIVE_SESSION_HISTORY';
DEF abstract = 'Average and Median elapsed time per execution for recent executions';
DEF foot = 'Data rounded to the 1 second'

BEGIN
  :sql_text_backup := '
SELECT 0 snap_id,
       TO_CHAR(start_time, ''YYYY-MM-DD HH24:MI'') begin_time, 
       TO_CHAR(start_time, ''YYYY-MM-DD HH24:MI'') end_time,
       avg_et,
       med_et,
       avg_cpu_time,
       med_cpu_time,
       0 dummy_05,
       0 dummy_06,
       0 dummy_07,
       0 dummy_08,
       0 dummy_09,
       0 dummy_10,
       0 dummy_11,
       0 dummy_12,
       0 dummy_13,
       0 dummy_14,
       0 dummy_15
  FROM (SELECT start_time,
               AVG(et) avg_et,
               MEDIAN(et) med_et,
               AVG(cpu_time) avg_cpu_time,
               MEDIAN(cpu_time) med_cpu_time
          FROM (SELECT TO_DATE(SUBSTR(distribution,1,12),''YYYYMMDDHH24MI'') start_time,
                       cpu_cost||''-''||io_cost||''-''||partition_id||''-''||distribution uniq_exec, 
                       COUNT(*) et, 
                       SUM(CASE WHEN object_node = ''ON CPU'' THEN 1 ELSE 0 END) cpu_time 
                  FROM plan_table
                 WHERE statement_id = ''SQLD360_ASH_DATA_MEM''
                   AND position =  @instance_number@
                   AND remarks = ''&&sqld360_sqlid.'' 
                   AND partition_id IS NOT NULL
                   AND ''&&diagnostics_pack.'' = ''Y''
                 GROUP BY TO_DATE(SUBSTR(distribution,1,12),''YYYYMMDDHH24MI''), cpu_cost||''-''||io_cost||''-''||partition_id||''-''||distribution)
          GROUP BY start_time)
 ORDER BY 3
';
END;
/

DEF chartype = 'LineChart';
DEF stacked = '';

DEF tit_01 = 'Average Elapsed Time';
DEF tit_02 = 'Median Elapsed Time';
DEF tit_03 = 'Average Time on CPU';
DEF tit_04 = 'Median Time on CPU';
DEF tit_05 = '';
DEF tit_06 = '';
DEF tit_07 = '';
DEF tit_08 = '';
DEF tit_09 = '';
DEF tit_10 = '';
DEF tit_11 = '';
DEF tit_12 = '';
DEF tit_13 = '';
DEF tit_14 = '';
DEF tit_15 = '';

DEF skip_lch = '';
DEF skip_all = '&&is_single_instance.';
DEF title = 'Avg and Median et/exec for recent execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'Avg and Median et/exec for recent execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'Avg and Median et/exec for recent execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'Avg and Median et/exec for recent execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'Avg and Median et/exec for recent execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'Avg and Median et/exec for recent execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'Avg and Median et/exec for recent execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'Avg and Median et/exec for recent execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'Avg and Median et/exec for recent execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql



------------------------------
------------------------------

DEF main_table = 'DBA_HIST_ACTIVE_SESS_HISTORY';
DEF abstract = 'Average and Median elapsed time per execution for historical executions';
DEF foot = 'Data rounded to the 10 seconds'

BEGIN
  :sql_text_backup := '
SELECT b.snap_id snap_id,
       TO_CHAR(b.begin_interval_time, ''YYYY-MM-DD HH24:MI'')  begin_time, 
       TO_CHAR(b.end_interval_time, ''YYYY-MM-DD HH24:MI'')  end_time,
       NVL(avg_et,0) avg_et,
       NVL(med_et,0) med_et,
       NVL(avg_cpu_time,0) avg_cpu_time,
       NVL(med_cpu_time,0) med_cpu_time,
       0 dummy_05,
       0 dummy_06,
       0 dummy_07,
       0 dummy_08,
       0 dummy_09,
       0 dummy_10,
       0 dummy_11,
       0 dummy_12,
       0 dummy_13,
       0 dummy_14,
       0 dummy_15
  FROM (SELECT snap_id,
               MAX(avg_et) avg_et,
               MAX(med_et) med_et,
               MAX(avg_cpu_time) avg_cpu_time,
               MAX(med_cpu_time) med_cpu_time
          FROM (SELECT start_time,
                       MIN(start_snap_id) snap_id,
                       AVG(et) avg_et,
                       MEDIAN(et) med_et,
                       AVG(cpu_time) avg_cpu_time,
                       MEDIAN(cpu_time) med_cpu_time
                  FROM (SELECT TO_DATE(SUBSTR(distribution,1,12),''YYYYMMDDHH24MI'') start_time,
                               cpu_cost||''-''||io_cost||''-''||partition_id||''-''||distribution uniq_exec, 
                               MIN(cardinality) start_snap_id,
                               SUM(10) et, 
                               SUM(CASE WHEN object_node = ''ON CPU'' THEN 10 ELSE 0 END) cpu_time 
                          FROM plan_table
                         WHERE statement_id = ''SQLD360_ASH_DATA_HIST''
                           AND partition_id IS NOT NULL
                           AND position =  @instance_number@
                           AND remarks = ''&&sqld360_sqlid.''
                           AND ''&&diagnostics_pack.'' = ''Y''
                         GROUP BY TO_DATE(SUBSTR(distribution,1,12),''YYYYMMDDHH24MI''), cpu_cost||''-''||io_cost||''-''||partition_id||''-''||distribution)
                 GROUP BY start_time)
         GROUP BY snap_id) ash,
      dba_hist_snapshot b
 WHERE ash.snap_id(+) = b.snap_id
   AND b.snap_id BETWEEN &&minimum_snap_id. AND &&maximum_snap_id.
 ORDER BY 3
';
END;
/

DEF chartype = 'LineChart';
DEF stacked = '';

DEF tit_01 = 'Average Elapsed Time';
DEF tit_02 = 'Median Elapsed Time';
DEF tit_03 = 'Average Time on CPU';
DEF tit_04 = 'Median Time on CPU';
DEF tit_05 = '';
DEF tit_06 = '';
DEF tit_07 = '';
DEF tit_08 = '';
DEF tit_09 = '';
DEF tit_10 = '';
DEF tit_11 = '';
DEF tit_12 = '';
DEF tit_13 = '';
DEF tit_14 = '';
DEF tit_15 = '';

DEF skip_lch = '';
DEF skip_all = '&&is_single_instance.';
DEF title = 'Avg and Median et/exec for historical execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'Avg and Median et/exec for historical execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'Avg and Median et/exec for historical execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'Avg and Median et/exec for historical execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'Avg and Median et/exec for historical execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'Avg and Median et/exec for historical execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'Avg and Median et/exec for historical execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'Avg and Median et/exec for historical execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'Avg and Median et/exec for historical execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql


-------------------------
-------------------------

DEF main_table = 'V$ACTIVE_SESSION_HISTORY';
DEF abstract = 'Average elapsed time per execution per Plan Hash Value for recent executions, top best 5 and worst 10';
DEF foot = 'Data rounded to the 1 second'

COL tit_01 NEW_V tit_01 
COL tit_02 NEW_V tit_02 
COL tit_03 NEW_V tit_03 
COL tit_04 NEW_V tit_04 
COL tit_05 NEW_V tit_05 
COL tit_06 NEW_V tit_06 
COL tit_07 NEW_V tit_07 
COL tit_08 NEW_V tit_08 
COL tit_09 NEW_V tit_09 
COL tit_10 NEW_V tit_10 
COL tit_11 NEW_V tit_11 
COL tit_12 NEW_V tit_12 
COL tit_13 NEW_V tit_13 
COL tit_14 NEW_V tit_14 
COL tit_15 NEW_V tit_15 
COL phv_01 NEW_V phv_01 
COL phv_02 NEW_V phv_02 
COL phv_03 NEW_V phv_03 
COL phv_04 NEW_V phv_04 
COL phv_05 NEW_V phv_05 
COL phv_06 NEW_V phv_06 
COL phv_07 NEW_V phv_07 
COL phv_08 NEW_V phv_08 
COL phv_09 NEW_V phv_09 
COL phv_10 NEW_V phv_10 
COL phv_11 NEW_V phv_11 
COL phv_12 NEW_V phv_12 
COL phv_13 NEW_V phv_13 
COL phv_14 NEW_V phv_14 
COL phv_15 NEW_V phv_15

SELECT MAX(CASE WHEN ranking = 1  THEN TO_CHAR(phv) ELSE '' END) tit_01,
       MAX(CASE WHEN ranking = 2  THEN TO_CHAR(phv) ELSE '' END) tit_02,              
       MAX(CASE WHEN ranking = 3  THEN TO_CHAR(phv) ELSE '' END) tit_03, 
       MAX(CASE WHEN ranking = 4  THEN TO_CHAR(phv) ELSE '' END) tit_04, 
       MAX(CASE WHEN ranking = 5  THEN TO_CHAR(phv) ELSE '' END) tit_05, 
       MAX(CASE WHEN ranking = 6  THEN TO_CHAR(phv) ELSE '' END) tit_06, 
       MAX(CASE WHEN ranking = 7  THEN TO_CHAR(phv) ELSE '' END) tit_07, 
       MAX(CASE WHEN ranking = 8  THEN TO_CHAR(phv) ELSE '' END) tit_08, 
       MAX(CASE WHEN ranking = 9  THEN TO_CHAR(phv) ELSE '' END) tit_09, 
       MAX(CASE WHEN ranking = 10 THEN TO_CHAR(phv) ELSE '' END) tit_10,
       MAX(CASE WHEN ranking = 11 THEN TO_CHAR(phv) ELSE '' END) tit_11,
       MAX(CASE WHEN ranking = 12 THEN TO_CHAR(phv) ELSE '' END) tit_12,
       MAX(CASE WHEN ranking = 13 THEN TO_CHAR(phv) ELSE '' END) tit_13,
       MAX(CASE WHEN ranking = 14 THEN TO_CHAR(phv) ELSE '' END) tit_14,
       MAX(CASE WHEN ranking = 15 THEN TO_CHAR(phv) ELSE '' END) tit_15,
       MAX(CASE WHEN ranking = 1  THEN phv ELSE -1 END) phv_01,
       MAX(CASE WHEN ranking = 2  THEN phv ELSE -1 END) phv_02,              
       MAX(CASE WHEN ranking = 3  THEN phv ELSE -1 END) phv_03, 
       MAX(CASE WHEN ranking = 4  THEN phv ELSE -1 END) phv_04, 
       MAX(CASE WHEN ranking = 5  THEN phv ELSE -1 END) phv_05, 
       MAX(CASE WHEN ranking = 6  THEN phv ELSE -1 END) phv_06, 
       MAX(CASE WHEN ranking = 7  THEN phv ELSE -1 END) phv_07, 
       MAX(CASE WHEN ranking = 8  THEN phv ELSE -1 END) phv_08, 
       MAX(CASE WHEN ranking = 9  THEN phv ELSE -1 END) phv_09, 
       MAX(CASE WHEN ranking = 10 THEN phv ELSE -1 END) phv_10,
       MAX(CASE WHEN ranking = 11 THEN phv ELSE -1 END) phv_11,
       MAX(CASE WHEN ranking = 12 THEN phv ELSE -1 END) phv_12,
       MAX(CASE WHEN ranking = 13 THEN phv ELSE -1 END) phv_13,
       MAX(CASE WHEN ranking = 14 THEN phv ELSE -1 END) phv_14,
       MAX(CASE WHEN ranking = 15 THEN phv ELSE -1 END) phv_15   
  FROM (SELECT 1 fake, phv, ranking  
          FROM (SELECT phv, COUNT(*) OVER (ORDER BY avg_et) num_plans, ROW_NUMBER() OVER (ORDER BY avg_et) ranking 
                  FROM (SELECT cost phv, COUNT(*)/COUNT(DISTINCT partition_id) avg_et 
                          FROM plan_table 
                         WHERE statement_id = 'SQLD360_ASH_DATA_MEM'
                           AND remarks = '&&sqld360_sqlid.'
                           AND partition_id IS NOT NULL -- to discard samples we can't attribute to any exec (likely parse)
                         GROUP BY cost)) 
         WHERE (ranking BETWEEN 1 AND 5 -- top 5 best performing plans
             OR ranking BETWEEN num_plans-10 AND num_plans)) ash, -- top 10 worse plans
	   (SELECT 1 fake FROM dual) b -- this is in case there is no row in ASH
 WHERE ash.fake(+) = b.fake	
/

COL phv1_ NOPRI
COL phv2_ NOPRI
COL phv3_ NOPRI
COL phv4_ NOPRI
COL phv5_ NOPRI
COL phv6_ NOPRI
COL phv7_ NOPRI
COL phv8_ NOPRI
COL phv9_ NOPRI
COL phv10_ NOPRI
COL phv11_ NOPRI
COL phv12_ NOPRI
COL phv13_ NOPRI
COL phv14_ NOPRI
COL phv15_ NOPRI

BEGIN
  :sql_text_backup := '
SELECT 0 snap_id,
       TO_CHAR(end_time, ''YYYY-MM-DD HH24:MI'') begin_time, 
       TO_CHAR(end_time, ''YYYY-MM-DD HH24:MI'') end_time,
       phv1  phv1_&&tit_01.  ,
       phv2  phv2_&&tit_02.  ,
       phv3  phv3_&&tit_03.  ,
       phv4  phv4_&&tit_04.  ,
       phv5  phv5_&&tit_05.  ,
       phv6  phv6_&&tit_06.  ,
       phv7  phv7_&&tit_07.  ,
       phv8  phv8_&&tit_08.  ,
       phv9  phv9_&&tit_09.  ,
       phv10 phv10_&&tit_10. ,
       phv11 phv11_&&tit_11. ,
       phv12 phv12_&&tit_12. ,
       phv13 phv13_&&tit_13. ,
       phv14 phv14_&&tit_14. ,
       phv15 phv15_&&tit_15. 
  FROM (SELECT TO_DATE(end_time,''YYYYMMDDHH24MI'') end_time,
               MAX(CASE WHEN phv = &&phv_01. THEN avg_et_per_exec ELSE NULL END) phv1,
               MAX(CASE WHEN phv = &&phv_02. THEN avg_et_per_exec ELSE NULL END) phv2, 
               MAX(CASE WHEN phv = &&phv_03. THEN avg_et_per_exec ELSE NULL END) phv3, 
               MAX(CASE WHEN phv = &&phv_04. THEN avg_et_per_exec ELSE NULL END) phv4, 
               MAX(CASE WHEN phv = &&phv_05. THEN avg_et_per_exec ELSE NULL END) phv5, 
               MAX(CASE WHEN phv = &&phv_06. THEN avg_et_per_exec ELSE NULL END) phv6, 
               MAX(CASE WHEN phv = &&phv_07. THEN avg_et_per_exec ELSE NULL END) phv7, 
               MAX(CASE WHEN phv = &&phv_08. THEN avg_et_per_exec ELSE NULL END) phv8, 
               MAX(CASE WHEN phv = &&phv_09. THEN avg_et_per_exec ELSE NULL END) phv9, 
               MAX(CASE WHEN phv = &&phv_10. THEN avg_et_per_exec ELSE NULL END) phv10, 
               MAX(CASE WHEN phv = &&phv_11. THEN avg_et_per_exec ELSE NULL END) phv11, 
               MAX(CASE WHEN phv = &&phv_12. THEN avg_et_per_exec ELSE NULL END) phv12, 
               MAX(CASE WHEN phv = &&phv_13. THEN avg_et_per_exec ELSE NULL END) phv13, 
               MAX(CASE WHEN phv = &&phv_14. THEN avg_et_per_exec ELSE NULL END) phv14, 
               MAX(CASE WHEN phv = &&phv_15. THEN avg_et_per_exec ELSE NULL END) phv15 
          FROM (SELECT SUBSTR(distribution,1,12) end_time,
                       cost phv, 
                       COUNT(*)/COUNT(DISTINCT cpu_cost||''-''||io_cost||''-''||partition_id||''-''||distribution) avg_et_per_exec
                  FROM plan_table
                 WHERE statement_id = ''SQLD360_ASH_DATA_MEM''
                   AND position =  @instance_number@
                   AND remarks = ''&&sqld360_sqlid.''
                   AND ''&&diagnostics_pack.'' = ''Y''
                   AND partition_id IS NOT NULL
                   AND distribution IS NOT NULL
                   AND cost IN (&&phv_01.,&&phv_02.,&&phv_03.,&&phv_04.,&&phv_05.,&&phv_06.,
                                &&phv_07.,&&phv_08.,&&phv_09.,&&phv_10.,&&phv_11.,&&phv_12.,
                                &&phv_13.,&&phv_14.,&&phv_15.)
                 GROUP BY SUBSTR(distribution,1,12), cost)
         GROUP BY TO_DATE(end_time,''YYYYMMDDHH24MI''))
 ORDER BY 3
';
END;
/

DEF chartype = 'LineChart';
DEF stacked = '';

DEF skip_lch = '';
DEF skip_all = '&&is_single_instance.';
DEF title = 'Avg et/exec per PHV for recent execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'Avg et/exec per PHV for recent execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

COL phv1_ PRI
COL phv2_ PRI
COL phv3_ PRI
COL phv4_ PRI
COL phv5_ PRI
COL phv6_ PRI
COL phv7_ PRI
COL phv8_ PRI
COL phv9_ PRI
COL phv10_ PRI
COL phv11_ PRI
COL phv12_ PRI
COL phv13_ PRI
COL phv14_ PRI
COL phv15_ PRI

---------------------------
---------------------------

DEF main_table = 'DBA_HIST_ACTIVE_SESS_HISTORY';
DEF abstract = 'Average elapsed time per execution per Plan Hash Value for historical executions, top best 5 and worst 10';
DEF foot = 'Data rounded to the 10 second'

COL tit_01 NEW_V tit_01 
COL tit_02 NEW_V tit_02 
COL tit_03 NEW_V tit_03 
COL tit_04 NEW_V tit_04 
COL tit_05 NEW_V tit_05 
COL tit_06 NEW_V tit_06 
COL tit_07 NEW_V tit_07 
COL tit_08 NEW_V tit_08 
COL tit_09 NEW_V tit_09 
COL tit_10 NEW_V tit_10 
COL tit_11 NEW_V tit_11 
COL tit_12 NEW_V tit_12 
COL tit_13 NEW_V tit_13 
COL tit_14 NEW_V tit_14 
COL tit_15 NEW_V tit_15 
COL phv_01 NEW_V phv_01 
COL phv_02 NEW_V phv_02 
COL phv_03 NEW_V phv_03 
COL phv_04 NEW_V phv_04 
COL phv_05 NEW_V phv_05 
COL phv_06 NEW_V phv_06 
COL phv_07 NEW_V phv_07 
COL phv_08 NEW_V phv_08 
COL phv_09 NEW_V phv_09 
COL phv_10 NEW_V phv_10 
COL phv_11 NEW_V phv_11 
COL phv_12 NEW_V phv_12 
COL phv_13 NEW_V phv_13 
COL phv_14 NEW_V phv_14 
COL phv_15 NEW_V phv_15

SELECT MAX(CASE WHEN ranking = 1  THEN TO_CHAR(phv) ELSE '' END) tit_01,
       MAX(CASE WHEN ranking = 2  THEN TO_CHAR(phv) ELSE '' END) tit_02,              
       MAX(CASE WHEN ranking = 3  THEN TO_CHAR(phv) ELSE '' END) tit_03, 
       MAX(CASE WHEN ranking = 4  THEN TO_CHAR(phv) ELSE '' END) tit_04, 
       MAX(CASE WHEN ranking = 5  THEN TO_CHAR(phv) ELSE '' END) tit_05, 
       MAX(CASE WHEN ranking = 6  THEN TO_CHAR(phv) ELSE '' END) tit_06, 
       MAX(CASE WHEN ranking = 7  THEN TO_CHAR(phv) ELSE '' END) tit_07, 
       MAX(CASE WHEN ranking = 8  THEN TO_CHAR(phv) ELSE '' END) tit_08, 
       MAX(CASE WHEN ranking = 9  THEN TO_CHAR(phv) ELSE '' END) tit_09, 
       MAX(CASE WHEN ranking = 10 THEN TO_CHAR(phv) ELSE '' END) tit_10,
       MAX(CASE WHEN ranking = 11 THEN TO_CHAR(phv) ELSE '' END) tit_11,
       MAX(CASE WHEN ranking = 12 THEN TO_CHAR(phv) ELSE '' END) tit_12,
       MAX(CASE WHEN ranking = 13 THEN TO_CHAR(phv) ELSE '' END) tit_13,
       MAX(CASE WHEN ranking = 14 THEN TO_CHAR(phv) ELSE '' END) tit_14,
       MAX(CASE WHEN ranking = 15 THEN TO_CHAR(phv) ELSE '' END) tit_15,
       MAX(CASE WHEN ranking = 1  THEN phv ELSE -1 END) phv_01,
       MAX(CASE WHEN ranking = 2  THEN phv ELSE -1 END) phv_02,              
       MAX(CASE WHEN ranking = 3  THEN phv ELSE -1 END) phv_03, 
       MAX(CASE WHEN ranking = 4  THEN phv ELSE -1 END) phv_04, 
       MAX(CASE WHEN ranking = 5  THEN phv ELSE -1 END) phv_05, 
       MAX(CASE WHEN ranking = 6  THEN phv ELSE -1 END) phv_06, 
       MAX(CASE WHEN ranking = 7  THEN phv ELSE -1 END) phv_07, 
       MAX(CASE WHEN ranking = 8  THEN phv ELSE -1 END) phv_08, 
       MAX(CASE WHEN ranking = 9  THEN phv ELSE -1 END) phv_09, 
       MAX(CASE WHEN ranking = 10 THEN phv ELSE -1 END) phv_10,
       MAX(CASE WHEN ranking = 11 THEN phv ELSE -1 END) phv_11,
       MAX(CASE WHEN ranking = 12 THEN phv ELSE -1 END) phv_12,
       MAX(CASE WHEN ranking = 13 THEN phv ELSE -1 END) phv_13,
       MAX(CASE WHEN ranking = 14 THEN phv ELSE -1 END) phv_14,
       MAX(CASE WHEN ranking = 15 THEN phv ELSE -1 END) phv_15   
  FROM (SELECT 1 fake, phv, ranking  
          FROM (SELECT phv, COUNT(*) OVER (ORDER BY avg_et) num_plans, ROW_NUMBER() OVER (ORDER BY avg_et) ranking 
                  FROM (SELECT cost phv, COUNT(*)/COUNT(DISTINCT partition_id) avg_et 
                          FROM plan_table 
                         WHERE statement_id = 'SQLD360_ASH_DATA_HIST'
                           AND remarks = '&&sqld360_sqlid.'
                           AND partition_id IS NOT NULL -- to discard samples we can't attribute to any exec (likely parse)
                         GROUP BY cost)) 
         WHERE (ranking BETWEEN 1 AND 5 -- top 5 best performing plans
             OR ranking BETWEEN num_plans-10 AND num_plans)) ash, -- top 10 worse plans
	   (SELECT 1 fake FROM dual) b  -- this is in case there is no row in ASH
 WHERE ash.fake(+) = b.fake
/

COL phv1_ NOPRI
COL phv2_ NOPRI
COL phv3_ NOPRI
COL phv4_ NOPRI
COL phv5_ NOPRI
COL phv6_ NOPRI
COL phv7_ NOPRI
COL phv8_ NOPRI
COL phv9_ NOPRI
COL phv10_ NOPRI
COL phv11_ NOPRI
COL phv12_ NOPRI
COL phv13_ NOPRI
COL phv14_ NOPRI
COL phv15_ NOPRI

BEGIN
  :sql_text_backup := '
SELECT b.snap_id snap_id,
       TO_CHAR(b.begin_interval_time, ''YYYY-MM-DD HH24:MI'')  begin_time, 
       TO_CHAR(b.end_interval_time, ''YYYY-MM-DD HH24:MI'')  end_time,
       NVL(phv1 ,0) phv1_&&tit_01.  ,
       NVL(phv2 ,0) phv2_&&tit_02.  ,
       NVL(phv3 ,0) phv3_&&tit_03.  ,
       NVL(phv4 ,0) phv4_&&tit_04.  ,
       NVL(phv5 ,0) phv5_&&tit_05.  ,
       NVL(phv6 ,0) phv6_&&tit_06.  ,
       NVL(phv7 ,0) phv7_&&tit_07.  ,
       NVL(phv8 ,0) phv8_&&tit_08.  ,
       NVL(phv9 ,0) phv9_&&tit_09.  ,
       NVL(phv10,0) phv10_&&tit_10. ,
       NVL(phv11,0) phv11_&&tit_11. ,
       NVL(phv12,0) phv12_&&tit_12. ,
       NVL(phv13,0) phv13_&&tit_13. ,
       NVL(phv14,0) phv14_&&tit_14. ,
       NVL(phv15,0) phv15_&&tit_15. 
  FROM (SELECT TO_DATE(start_time,''YYYYMMDDHH24'') start_time,
               MIN(starting_snap_id) snap_id,
               MAX(CASE WHEN phv = &&phv_01. THEN avg_et_per_exec ELSE NULL END) phv1,
               MAX(CASE WHEN phv = &&phv_02. THEN avg_et_per_exec ELSE NULL END) phv2, 
               MAX(CASE WHEN phv = &&phv_03. THEN avg_et_per_exec ELSE NULL END) phv3, 
               MAX(CASE WHEN phv = &&phv_04. THEN avg_et_per_exec ELSE NULL END) phv4, 
               MAX(CASE WHEN phv = &&phv_05. THEN avg_et_per_exec ELSE NULL END) phv5, 
               MAX(CASE WHEN phv = &&phv_06. THEN avg_et_per_exec ELSE NULL END) phv6, 
               MAX(CASE WHEN phv = &&phv_07. THEN avg_et_per_exec ELSE NULL END) phv7, 
               MAX(CASE WHEN phv = &&phv_08. THEN avg_et_per_exec ELSE NULL END) phv8, 
               MAX(CASE WHEN phv = &&phv_09. THEN avg_et_per_exec ELSE NULL END) phv9, 
               MAX(CASE WHEN phv = &&phv_10. THEN avg_et_per_exec ELSE NULL END) phv10, 
               MAX(CASE WHEN phv = &&phv_11. THEN avg_et_per_exec ELSE NULL END) phv11, 
               MAX(CASE WHEN phv = &&phv_12. THEN avg_et_per_exec ELSE NULL END) phv12, 
               MAX(CASE WHEN phv = &&phv_13. THEN avg_et_per_exec ELSE NULL END) phv13, 
               MAX(CASE WHEN phv = &&phv_14. THEN avg_et_per_exec ELSE NULL END) phv14, 
               MAX(CASE WHEN phv = &&phv_15. THEN avg_et_per_exec ELSE NULL END) phv15 
          FROM (SELECT SUBSTR(distribution,1,10) start_time,
                       cost phv, 
                       MIN(cardinality) starting_snap_id,
                       SUM(10)/COUNT(DISTINCT cpu_cost||''-''||io_cost||''-''||partition_id||''-''||distribution) avg_et_per_exec
                  FROM plan_table
                 WHERE statement_id = ''SQLD360_ASH_DATA_HIST''
                   AND position =  @instance_number@
                   AND remarks = ''&&sqld360_sqlid.''
                   AND ''&&diagnostics_pack.'' = ''Y''
                   AND partition_id IS NOT NULL
                   AND distribution IS NOT NULL
                   AND cost IN (&&phv_01.,&&phv_02.,&&phv_03.,&&phv_04.,&&phv_05.,&&phv_06.,
                                &&phv_07.,&&phv_08.,&&phv_09.,&&phv_10.,&&phv_11.,&&phv_12.,
                                &&phv_13.,&&phv_14.,&&phv_15.)
                 GROUP BY SUBSTR(distribution,1,10), cost)
         GROUP BY TO_DATE(start_time,''YYYYMMDDHH24'')) ash, 
       dba_hist_snapshot b
 WHERE ash.snap_id(+) = b.snap_id
   AND b.snap_id BETWEEN &&minimum_snap_id. AND &&maximum_snap_id.
 ORDER BY 3
';
END;
/

DEF chartype = 'LineChart';
DEF stacked = '';

DEF skip_lch = '';
DEF skip_all = '&&is_single_instance.';
DEF title = 'Avg et/exec per PHV for historical execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_lch = '';
DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'Avg et/exec per PHV for historical execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

COL phv1_ PRI
COL phv2_ PRI
COL phv3_ PRI
COL phv4_ PRI
COL phv5_ PRI
COL phv6_ PRI
COL phv7_ PRI
COL phv8_ PRI
COL phv9_ PRI
COL phv10_ PRI
COL phv11_ PRI
COL phv12_ PRI
COL phv13_ PRI
COL phv14_ PRI
COL phv15_ PRI

---------------------
---------------------

DEF main_table = 'V$ACTIVE_SESSION_HISTORY';
DEF abstract = 'Elapsed Time per recent executions';
DEF foot = 'Data rounded to the 1 second';

BEGIN
  :sql_text_backup := '
SELECT cpu_cost session_id,
       io_cost session_serial#,
       partition_id sql_exec_id,
       TO_CHAR(MIN(timestamp), ''YYYY-MM-DD HH24:MI:SS'')  start_time,
       TO_CHAR(MAX(timestamp), ''YYYY-MM-DD HH24:MI:SS'')  end_time,
       MIN(cost) plan_hash_value,
       COUNT(*) elapsed_time, 
       SUM(CASE WHEN object_node = ''ON CPU'' THEN 1 ELSE 0 END) cpu_time
  FROM plan_table
 WHERE statement_id = ''SQLD360_ASH_DATA_MEM''
   AND position =  @instance_number@
   AND remarks = ''&&sqld360_sqlid.''
   AND ''&&diagnostics_pack.'' = ''Y''
 GROUP BY partition_id, cpu_cost, io_cost
 ORDER BY
       TO_CHAR(MIN(timestamp), ''YYYY-MM-DD HH24:MI:SS''),
       partition_id
';
END;
/

DEF skip_all = '&&is_single_instance.';
DEF title = 'Elapsed Time per recent execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'Elapsed Time per recent execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'Elapsed Time per recent execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'Elapsed Time per recent execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'Elapsed Time per recent execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'Elapsed Time per recent execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'Elapsed Time per recent execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'Elapsed Time per recent execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'Elapsed Time per recent execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql


------------------------------------------------
------------------------------------------------

DEF main_table = 'DBA_HIST_ACTIVE_SESS_HISTORY';
DEF abstract = 'Elapsed Time per historical execution';
DEF foot = 'Data rounded to the 10 seconds';


BEGIN
  :sql_text_backup := '
SELECT cpu_cost session_id,
       io_cost session_serial#,
       partition_id sql_exec_id,
       TO_CHAR(MIN(timestamp), ''YYYY-MM-DD HH24:MI:SS'')  start_time,
       TO_CHAR(MAX(timestamp), ''YYYY-MM-DD HH24:MI:SS'')  end_time,
       MIN(cost) plan_hash_value,
       SUM(10) elapsed_time, 
       SUM(CASE WHEN object_node = ''ON CPU'' THEN 10 ELSE 0 END) cpu_time
  FROM plan_table
 WHERE statement_id = ''SQLD360_ASH_DATA_HIST''
   AND position =  @instance_number@
   AND remarks = ''&&sqld360_sqlid.''
   AND ''&&diagnostics_pack.'' = ''Y''
 GROUP BY partition_id, cpu_cost, io_cost
 ORDER BY
       TO_CHAR(MIN(timestamp), ''YYYY-MM-DD HH24:MI:SS''),
       partition_id
';
END;
/

DEF skip_all = '&&is_single_instance.';
DEF title = 'Elapsed Time per historical execs for Cluster';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', 'position');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 1;
DEF title = 'Elapsed Time per historical execs for Instance 1';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '1');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 2;
DEF title = 'Elapsed Time per historical execs for Instance 2';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '2');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 3;
DEF title = 'Elapsed Time per historical execs for Instance 3';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '3');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 4;
DEF title = 'Elapsed Time per historical execs for Instance 4';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '4');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 5;
DEF title = 'Elapsed Time per historical execs for Instance 5';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '5');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 6;
DEF title = 'Elapsed Time per historical execs for Instance 6';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '6');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 7;
DEF title = 'Elapsed Time per historical execs for Instance 7';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '7');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

DEF skip_all = 'Y';
SELECT NULL skip_all FROM gv$instance WHERE instance_number = 8;
DEF title = 'Elapsed Time per historical execs for Instance 8';
EXEC :sql_text := REPLACE(:sql_text_backup, '@instance_number@', '8');
@@&&skip_all.&&skip_diagnostics.sqld360_9a_pre_one.sql

