CLASS zad_cl_scm_workcenter DEFINITION PUBLIC FINAL CREATE PUBLIC .
public section.
 INTERFACES if_oo_adt_classrun .
    PROTECTED SECTION.
         types: BEGIN OF ty_business_data,
           workcenterinternalid type string,
           workcentertypecode  type string,
        end of ty_business_data.



      TYPES t_workcenter_data TYPE TABLE OF zzadworkcenterheader.
      METHODS get_workcenters
        IMPORTING
                  it_filter_cond   TYPE if_rap_query_filter=>tt_name_range_pairs   OPTIONAL
                  top              TYPE i OPTIONAL
                  skip             TYPE i OPTIONAL
        EXPORTING
                  et_workcenters TYPE  t_workcenter_data
       RAISING
                  /iwbep/cx_cp_remote
                  /iwbep/cx_gateway
                  cx_web_http_client_error
                  cx_http_dest_provider_error.

ENDCLASS.



CLASS zad_cl_scm_workcenter IMPLEMENTATION.

method get_workcenters.

    DATA: lo_http_client        TYPE REF TO if_web_http_client,
          lo_odata_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
          lo_read_request  TYPE REF TO /iwbep/if_cp_request_read,
          lo_read_response TYPE REF TO /iwbep/if_cp_response_read.

    DATA:  ls_entity_key type ty_business_data.

*   DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sapes5.sapdevcenter.com' ).
*   DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://my312363-api.s4hana.ondemand.com' ).

DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'ZAD_COMMSCENARIO_WORKCENTER'
*                                             comm_system_id = '<Comm System Id>'
                                             service_id     = 'ZAD_OUTBOUND_WORKCENTER_REST' ).
lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*    lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).



    lo_odata_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
      EXPORTING
        iv_service_definition_name = 'ZAD_SCM_WORKCENTER'
        io_http_client             = lo_http_client
        iv_relative_service_root   = '' ).


      ls_entity_key = VALUE #(
          workcenterinternalid  = '1'
          workcentertypecode    = '02' ).

    " Navigate to the resource and create a request for the read operation
    lo_resource = lo_odata_client_proxy->create_resource_for_entity_set( 'WORKCENTERHEADER' )->navigate_with_key( ls_entity_key ).



    " Execute the request and retrieve the business data
    lo_read_response = lo_resource->create_request_for_read( )->execute( ).
    lo_read_response->get_business_data( IMPORTING es_business_data = et_workcenters ).

ENDMETHOD.

METHOD if_oo_adt_classrun~main.

  DATA lt_workcenters TYPE TABLE OF zzadworkcenterheader.
  DATA lt_filter_conditions  TYPE if_rap_query_filter=>tt_name_range_pairs .
  DATA lt_ranges_table TYPE if_rap_query_filter=>tt_range_option .
  "lt_ranges_table = VALUE #( (  sign = 'I' option = 'GE' low = '1' ) ).
  "lt_filter_conditions = VALUE #( ( name = 'workcenterinternalid'  range = lt_ranges_table ) ).

try.
   get_workcenters(
          EXPORTING
            it_filter_cond    = lt_filter_conditions
            top               =  3
            skip              =  1
          IMPORTING
            et_workcenters    = lt_workcenters
          ) .

      CATCH cx_root INTO DATA(lx_exception).
      data(lv_client_error_text) = lx_exception->get_text( ).

    ENDTRY.
    data(rs_business_data) = lt_workcenters.

ENDMETHOD.

ENDCLASS.
