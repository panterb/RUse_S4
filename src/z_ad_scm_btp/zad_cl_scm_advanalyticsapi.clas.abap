CLASS zad_cl_scm_advanalyticsapi DEFINITION PUBLIC FINAL CREATE PUBLIC .
public section.
 INTERFACES if_oo_adt_classrun .
    PROTECTED SECTION.

     types: BEGIN OF business_data,
       timezone1 type string,
     end of business_data.

      METHODS get_response
        IMPORTING
                  it_filter_cond   TYPE if_rap_query_filter=>tt_name_range_pairs   OPTIONAL
                  top              TYPE i OPTIONAL
                  skip             TYPE i OPTIONAL
        EXPORTING
                  ev_response  TYPE STRING
       RAISING
                  /iwbep/cx_cp_remote
                  /iwbep/cx_gateway
                  cx_web_http_client_error
                  cx_http_dest_provider_error.

ENDCLASS.



CLASS zad_cl_scm_advanalyticsapi IMPLEMENTATION.

method get_response.

 DATA:    lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node      TYPE REF TO /iwbep/if_cp_filter_node,
          lo_root_filter_node TYPE REF TO /iwbep/if_cp_filter_node.

    DATA: lo_http_client        TYPE REF TO if_web_http_client,
          lo_odata_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request  TYPE REF TO /iwbep/if_cp_request_create,
          lo_response TYPE REF TO /iwbep/if_cp_response_create.

*   DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sapes5.sapdevcenter.com' ).

  DATA(lo_http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sandbox.api.sap.com/sapapimanagement/api/1.0/AnalyticsService' ).
  lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ).


"adding headers - API Key for API Sandbox
lo_http_client->get_http_request( )->set_header_field( i_name = 'APIKey' i_value = 'hyx2cODeajYX62trp1FDouQZLD3RjXwJ' ).
lo_http_client->get_http_request( )->set_header_field( i_name = 'DataServiceVersion' i_value = '1.0' ).
lo_http_client->get_http_request( )->set_header_field( i_name = 'Accept' i_value = 'application/json' ).


  lo_odata_client_proxy = cl_web_odata_client_factory=>create_v4_remote_proxy(
      EXPORTING
        iv_service_definition_name = 'ZAD_SCM_ADVANCED_ANALYTICS_API'
        io_http_client             = lo_http_client
        iv_relative_service_root   = '' ).

*    Prepare business data
     data ls_business_data type business_data.
     ls_business_data = VALUE #( timezone1  = 'UTC' ).

    "Navigate to the resource and create a request for the create operation
    lo_request = lo_odata_client_proxy->create_resource_for_entity_set( 'RESULTS' )->create_request_for_create( ).
    lo_request->set_business_data( ls_business_data ).

    " Execute the request and retrieve the business data
    lo_response = lo_request->execute( ).
*    lo_read_list_response->get_business_data( IMPORTING et_business_data = ev_response ).

ENDMETHOD.

METHOD if_oo_adt_classrun~main.

*  DATA lt_workcenters TYPE TABLE OF ZZADWORKCENTERPOOLEDCAPACITY.
  DATA lt_filter_conditions  TYPE if_rap_query_filter=>tt_name_range_pairs .
  DATA lt_ranges_table TYPE if_rap_query_filter=>tt_range_option .
  "lt_ranges_table = VALUE #( (  sign = 'I' option = 'GE' low = '1' ) ).
  "lt_filter_conditions = VALUE #( ( name = 'workcenterinternalid'  range = lt_ranges_table ) ).


try.
   get_response(
          EXPORTING
            it_filter_cond    = lt_filter_conditions
            top               =  3
            skip              =  1
          IMPORTING
            ev_response    = data(lv_response)
          ) .

      CATCH cx_root INTO DATA(lx_exception).
      data(lv_client_error_text) = lx_exception->get_text( ).

    ENDTRY.


ENDMETHOD.

ENDCLASS.
