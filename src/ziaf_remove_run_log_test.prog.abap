*&---------------------------------------------------------------------*
*& Report  ziaf_remove_run_log
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ziaf_remove_run_log_test.

DATA: go_applog TYPE REF TO zcl_iaf_log,
      gv_pernr  TYPE pa0000-pernr.


SELECTION-SCREEN BEGIN OF BLOCK b1.
SELECT-OPTIONS so_pernr FOR gv_pernr NO INTERVALS OBLIGATORY.
PARAMETERS pa_acti TYPE ziaf_it_action OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.


START-OF-SELECTION.

  CHECK so_pernr IS NOT INITIAL.

  SELECT *
  FROM ziaf_t_run_log
  WHERE pernr IN @so_pernr
  AND action = @pa_acti
  INTO TABLE @DATA(lt_hist).
  IF sy-subrc <> 0.
    MESSAGE w051(ziaf).
  ENDIF.

  DELETE ziaf_t_run_log FROM TABLE lt_hist .

  IF sy-subrc <> 0.
    MESSAGE e050(ziaf).
  ELSE.

    MESSAGE s006(ziaf).
  ENDIF.
