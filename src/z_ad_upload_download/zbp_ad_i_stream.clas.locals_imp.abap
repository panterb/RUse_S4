CLASS lad_Stream DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Stream RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR  Stream RESULT result.

ENDCLASS.

CLASS lad_Stream IMPLEMENTATION.

  METHOD get_instance_features.

    result = CORRESPONDING #( keys ).

  ENDMETHOD.

METHOD get_instance_authorizations.
ENDMETHOD.

ENDCLASS.
