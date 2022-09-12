CLASS zad_cl_apj_xco_xlsx DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZAD_CL_APJ_XCO_XLSX IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS lc_catalog_name      TYPE cl_apj_dt_create_content=>ty_catalog_name  VALUE 'ZAD_ONLINE_SHOP_JOB_XCO_XLSX'.
    CONSTANTS lc_catalog_text      TYPE cl_apj_dt_create_content=>ty_text          VALUE 'Online Shop App for Job Template'.
    CONSTANTS lc_class_name        TYPE cl_apj_dt_create_content=>ty_class_name    VALUE 'ZAD_CL_APJ_BUSLOGIC_XCO_XLSX'.

    CONSTANTS lc_template_name     TYPE cl_apj_dt_create_content=>ty_template_name VALUE 'ZAD_ONLINE_SHOP_JOB_TEMP_XCO_XLSX'.
    CONSTANTS lc_template_text     TYPE cl_apj_dt_create_content=>ty_text          VALUE 'Job Template for Online Shop App'.

    CONSTANTS lc_transport_request TYPE cl_apj_dt_create_content=>ty_transport_request VALUE 'FHJK900110'.
    CONSTANTS lc_package           TYPE cl_apj_dt_create_content=>ty_package           VALUE 'Z_AD_XCO_XLSX'.

    DATA(lo_dt) = cl_apj_dt_create_content=>get_instance( ).

    " Create Job Catalog Entry
    TRY.
        lo_dt->create_job_cat_entry(
            iv_catalog_name       = lc_catalog_name
            iv_class_name         = lc_class_name
            iv_text               = lc_catalog_text
            iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
            iv_transport_request  = lc_transport_request
            iv_package            = lc_package
        ).
        out->write( |Job catalog entry created successfully| ).

      CATCH cx_apj_dt_content INTO DATA(lx_apj_dt_content).
        out->write( |Creation of job catalog entry failed: { lx_apj_dt_content->get_text( ) }| ).
    ENDTRY.


    DATA lt_parameters TYPE if_apj_dt_exec_object=>tt_templ_val.

    NEW ZAD_CL_APJ_ONLINE_SHOP( )->if_apj_dt_exec_object~get_parameters(
      IMPORTING
        et_parameter_val = lt_parameters
    ).

    "Create Job Template
    TRY.
        lo_dt->create_job_template_entry(
            iv_template_name     = lc_template_name
            iv_catalog_name      = lc_catalog_name
            iv_text              = lc_template_text
            it_parameters        = lt_parameters
            iv_transport_request = lc_transport_request
            iv_package           = lc_package
        ).
        out->write( |Job template created successfully| ).

      CATCH cx_apj_dt_content INTO lx_apj_dt_content.
        out->write( |Creation of job template failed: { lx_apj_dt_content->get_text( ) }| ).
        RETURN.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
