class ZCL_TEST_HTTP_SERVICE definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
  METHODS: get_html RETURNING VALUE(ui_html) TYPE string.
protected section.
private section.
ENDCLASS.



CLASS ZCL_TEST_HTTP_SERVICE IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   response->set_text( get_html(  ) ).
  endmethod.

  METHOD GET_HTML.
     DATA(user_formatted_name) = cl_abap_context_info=>get_user_formatted_name( ).
    DATA(system_date) = cl_abap_context_info=>get_system_date( ).

    ui_html =  |<html> \n| &&
    |<body> \n| &&
    |<title>General Information</title> \n| &&
    |<p style="color:DodgerBlue;"> Hello there, { user_formatted_name } </p> \n | &&
    |<p> Today, the date is:  { system_date }| &&
    |<p> | &&
    |</body> \n| &&
    |</html> | .
  ENDMETHOD.

ENDCLASS.
