INTERFACE zad_if_online_shop_constants
  PUBLIC .

    CONSTANTS:
    BEGIN OF cs_apl,
      BEGIN OF object,
        online_shop TYPE if_bali_object_handler=>ty_object         VALUE 'ZAD_ONLINE_SHOP',
      END OF object,
      BEGIN OF subobject,
        online_shops TYPE if_bali_object_handler=>ty_subobject VALUE 'ZAD_ONLINE_SHOPS',
      END OF subobject,
    END OF cs_apl.

ENDINTERFACE.
