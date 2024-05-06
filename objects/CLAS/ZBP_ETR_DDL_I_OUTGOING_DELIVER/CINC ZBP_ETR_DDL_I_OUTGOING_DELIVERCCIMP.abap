CLASS lhc_zetr_ddl_i_outgoing_delive DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR OutgoingDeliveries RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR OutgoingDeliveries RESULT result.

    METHODS archiveDeliveries FOR MODIFY
      IMPORTING keys FOR ACTION OutgoingDeliveries~archiveDeliveries RESULT result.

    METHODS sendDeliveries FOR MODIFY
      IMPORTING keys FOR ACTION OutgoingDeliveries~sendDeliveries RESULT result.

    METHODS setAsRejected FOR MODIFY
      IMPORTING keys FOR ACTION OutgoingDeliveries~setAsRejected RESULT result.

    METHODS statusUpdate FOR MODIFY
      IMPORTING keys FOR ACTION OutgoingDeliveries~statusUpdate RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_outgoing_delive IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zetr_ddl_i_outgoing_deliveries IN LOCAL MODE
          ENTITY OutgoingDeliveries
            ALL FIELDS
            WITH CORRESPONDING #( keys )
        RESULT DATA(lt_deliveries)
        FAILED failed.
    CHECK lt_deliveries IS NOT INITIAL.
    result = VALUE #( FOR ls_delivery IN lt_deliveries
                      ( %tky = ls_delivery-%tky
                        %action-sendDeliveries = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                   THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                        %action-archiveDeliveries = COND #( WHEN ls_delivery-statuscode = '' OR ls_delivery-statuscode = '2'
                                                   THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                        %action-setAsRejected = COND #( WHEN ls_delivery-statuscode = '' OR ls_delivery-statuscode = '2'
                                                   THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                        %action-statusUpdate = COND #( WHEN ls_delivery-statuscode = '' OR ls_delivery-statuscode = '2'
                                                   THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                        %features-%update = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                   THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                        %features-%delete = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                   THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                        %field-ProfileID = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-mandatory  )
                        %field-Aliass = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryNote = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryType = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-CollectItems = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-SerialPrefix = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-XSLTTemplate = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-ActualDeliveryDate = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-ActualDeliveryTime = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-VehiclePlate = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-TransportCompanyTaxID = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-TransportCompanyTitle = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressStreet = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressBuildingName = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressBuildingNumber = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressRegion = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressSubdivision = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressCity = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressCountry = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressPostalCode = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressTelephone = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressFax = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressEMail = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-DeliveryAddressWebsite = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-PrintedDocumentDate = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                        %field-PrintedDocumentNumber = COND #( WHEN ls_delivery-statuscode <> '' AND ls_delivery-statuscode <> '2'
                                                     THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )
                      ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD archiveDeliveries.
  ENDMETHOD.

  METHOD sendDeliveries.
    READ ENTITIES OF zetr_ddl_i_outgoing_deliveries IN LOCAL MODE
      ENTITY Outgoingdeliveries
      ALL FIELDS WITH
      CORRESPONDING #( keys )
      RESULT DATA(deliveryList).
    SORT deliveryList BY CompanyCode ProfileID DocumentDate DocumentNumber.

    LOOP AT deliveryList ASSIGNING FIELD-SYMBOL(<deliveryLine>).
      IF <deliveryLine>-Reversed = abap_true.
        APPEND VALUE #( DocumentUUID = <deliveryLine>-DocumentUUID
                        %msg = new_message( id       = 'ZETR_COMMON'
                                            number   = '036'
                                            severity = if_abap_behv_message=>severity-error ) ) TO reported-Outgoingdeliveries.
        DELETE deliveryList.
      ELSE.
        TRY.
            DATA(OutgoingdeliveryInstance) = zcl_etr_outgoing_delivery=>factory( <deliveryline>-documentuuid ).
            IF <deliveryLine>-deliveryID IS INITIAL.
              <deliveryLine>-deliveryID = OutgoingdeliveryInstance->generate_delivery_id( iv_save_db = '' ).
            ENDIF.
            OutgoingdeliveryInstance->build_delivery_data(
              IMPORTING
                es_delivery_ubl       = DATA(ls_delivery_ubl)
                ev_delivery_ubl       = DATA(lv_delivery_ubl)
                ev_delivery_hash      = DATA(lv_delivery_hash)
                et_custom_parameters = DATA(lt_custom_parameters) ).
            DATA(PartyTaxID) = <deliveryLine>-TaxID.
            DATA(PartyAlias) = <deliveryLine>-Aliass.
            DATA(edeliverieserviceInstance) = zcl_etr_edelivery_ws=>factory( <deliveryLine>-CompanyCode ).
            edeliverieserviceInstance->outgoing_delivery_send(
              EXPORTING
                iv_document_uuid     = <deliveryLine>-DocumentUUID
                is_ubl_structure     = ls_delivery_ubl
                iv_ubl_xstring       = lv_delivery_ubl
                iv_ubl_hash          = lv_delivery_hash
                iv_receiver_alias    = PartyAlias
                iv_receiver_taxid    = PartyTaxID
              IMPORTING
                ev_integrator_uuid   = <deliveryLine>-IntegratorDocumentID
                ev_delivery_uuid     = DATA(lv_delivery_uuid)
                ev_delivery_no       = DATA(lv_delivery_no)
                ev_envelope_uuid     = DATA(lv_envelope_uuid) ).
            IF lv_delivery_uuid IS NOT INITIAL.
              <deliveryLine>-deliveryUUID = lv_delivery_uuid.
            ENDIF.
            IF lv_delivery_no IS NOT INITIAL.
              <deliveryLine>-deliveryID = lv_delivery_no.
            ENDIF.
            IF lv_envelope_uuid IS NOT INITIAL.
              <deliveryLine>-EnvelopeUUID = lv_envelope_uuid.
            ENDIF.

            <deliveryLine>-StatusCode = '1'.
            <deliveryLine>-Response = '0'.
            <deliveryLine>-Printed = ''.
            <deliveryLine>-Sender = sy-uname.
            <deliveryLine>-SendDate = cl_abap_context_info=>get_system_date( ).
            <deliveryLine>-SendTime = cl_abap_context_info=>get_system_time( ).

            APPEND VALUE #( DocumentUUID = <deliveryLine>-DocumentUUID
                            %msg = new_message( id       = 'ZETR_COMMON'
                                                number   = '033'
                                                severity = if_abap_behv_message=>severity-success ) ) TO reported-Outgoingdeliveries.


          CATCH zcx_etr_regulative_exception INTO DATA(RegulativeException).
            DATA(ErrorMessage) = CONV bapi_msg( RegulativeException->get_text( ) ).
            APPEND VALUE #( DocumentUUID = <deliveryLine>-DocumentUUID
                            %msg = new_message( id       = 'ZETR_COMMON'
                                                number   = '000'
                                                severity = if_abap_behv_message=>severity-information
                                                v1 = <deliveryLine>-DocumentNumber && '->' && ErrorMessage(35)
                                                v2 = ErrorMessage+35(50)
                                                v3 = ErrorMessage+85(50)
                                                v4 = ErrorMessage+135(*) ) ) TO reported-Outgoingdeliveries.
            <deliveryLine>-StatusCode = '2'.
            <deliveryLine>-StatusDetail = ErrorMessage.
            EXIT.
        ENDTRY.
      ENDIF.
    ENDLOOP.
    CHECK deliveryList IS NOT INITIAL.

    TRY.
        MODIFY ENTITIES OF zetr_ddl_i_outgoing_deliveries IN LOCAL MODE
          ENTITY Outgoingdeliveries
             UPDATE FIELDS ( Sender SendDate SendTime Printed deliveryUUID deliveryID IntegratorDocumentID EnvelopeUUID StatusCode Response )
             WITH VALUE #( FOR delivery IN deliveryList ( DocumentUUID = delivery-DocumentUUID
                                                          Sender = delivery-Sender
                                                          SendDate = delivery-SendDate
                                                          SendTime = delivery-SendTime
                                                          Printed = delivery-Printed
                                                          deliveryUUID = delivery-deliveryUUID
                                                          deliveryID = delivery-deliveryID
                                                          IntegratorDocumentID = delivery-IntegratorDocumentID
                                                          EnvelopeUUID = delivery-EnvelopeUUID
                                                          StatusCode = delivery-StatusCode
                                                          StatusDetail = delivery-StatusDetail
                                                          Response = delivery-Response
                                                          %control-Sender = if_abap_behv=>mk-on
                                                          %control-SendDate = if_abap_behv=>mk-on
                                                          %control-SendTime = if_abap_behv=>mk-on
                                                          %control-Printed = if_abap_behv=>mk-on
                                                          %control-deliveryUUID = if_abap_behv=>mk-on
                                                          %control-deliveryID = if_abap_behv=>mk-on
                                                          %control-IntegratorDocumentID = if_abap_behv=>mk-on
                                                          %control-EnvelopeUUID = if_abap_behv=>mk-on
                                                          %control-StatusCode = if_abap_behv=>mk-on
                                                          %control-StatusDetail = if_abap_behv=>mk-on
                                                          %control-Response = if_abap_behv=>mk-on ) )

                ENTITY Outgoingdeliveries
                    CREATE BY \_deliveryContents
                    FIELDS ( ArchiveUUID DocumentUUID ContentType )
                    AUTO FILL CID
                    WITH VALUE #( FOR delivery IN deliveryList WHERE ( StatusCode = '1' OR StatusCode = '5' )
                                     ( DocumentUUID = delivery-DocumentUUID
                                       %target = VALUE #( ( ArchiveUUID = cl_system_uuid=>create_uuid_c22_static( )
                                                            DocumentUUID = delivery-DocumentUUID
                                                            DocumentType = 'OUTDLVDOC'
                                                            ContentType = 'PDF' )
                                                          ( ArchiveUUID = cl_system_uuid=>create_uuid_c22_static( )
                                                            DocumentUUID = delivery-DocumentUUID
                                                            DocumentType = 'OUTDLVDOC'
                                                            ContentType = 'HTML' )
                                                          ( ArchiveUUID = cl_system_uuid=>create_uuid_c22_static( )
                                                            DocumentUUID = delivery-DocumentUUID
                                                            DocumentType = 'OUTDLVDOC'
                                                            ContentType = 'UBL' ) ) ) )

                  ENTITY Outgoingdeliveries
                    CREATE BY \_deliveryLogs
                    FIELDS ( loguuid documentuuid createdby creationdate creationtime logcode lognote )
                    AUTO FILL CID
                    WITH VALUE #( FOR delivery IN deliveryList WHERE ( StatusCode = '1' OR StatusCode = '5' )
                                     ( DocumentUUID = delivery-DocumentUUID
                                       %target = VALUE #( ( LogUUID = cl_system_uuid=>create_uuid_c22_static( )
                                                            DocumentUUID = delivery-DocumentUUID
                                                            CreatedBy = sy-uname
                                                            CreationDate = cl_abap_context_info=>get_system_date( )
                                                            CreationTime = cl_abap_context_info=>get_system_time( )
                                                            LogCode = zcl_etr_regulative_log=>mc_log_codes-sent ) ) ) )
             FAILED failed.
*             REPORTED reported.
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

    result = VALUE #( FOR delivery IN deliveryList ( %tky   = delivery-%tky
                                                     %param = delivery ) ).
  ENDMETHOD.

  METHOD setAsRejected.
    READ TABLE keys INTO DATA(ls_key) INDEX 1.

    READ ENTITIES OF zetr_ddl_i_outgoing_deliveries IN LOCAL MODE
    ENTITY OutgoingDeliveries
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(deliveries).

    TRY.
        MODIFY ENTITIES OF zetr_ddl_i_outgoing_deliveries IN LOCAL MODE
          ENTITY OutgoingDeliveries
             UPDATE FIELDS ( Response )
             WITH VALUE #( FOR delivery IN deliveries ( documentuuid = delivery-documentuuid
                                                     Response = 'R'
                                                     %control-Response = if_abap_behv=>mk-on ) )
                  ENTITY Outgoingdeliveries
                    CREATE BY \_deliverylogs
                    FIELDS ( loguuid documentuuid createdby creationdate creationtime logcode lognote )
                    AUTO FILL CID
                    WITH VALUE #( FOR deliverie IN deliveries
                                     ( documentuuid = deliverie-documentuuid
                                       %target = VALUE #( ( loguuid = cl_system_uuid=>create_uuid_c22_static( )
                                                            documentuuid = deliverie-documentuuid
                                                            createdby = sy-uname
                                                            creationdate = cl_abap_context_info=>get_system_date( )
                                                            creationtime = cl_abap_context_info=>get_system_time( )
                                                            lognote = ls_key-%param-Note
                                                            logcode = zcl_etr_regulative_log=>mc_log_codes-set_as_rejected ) ) )  )
             FAILED failed
             REPORTED reported.
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

    result = VALUE #( FOR delivery IN deliveries
                 ( %tky   = delivery-%tky
                   %param = delivery ) ).

    APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                        number   = '003'
                                        severity = if_abap_behv_message=>severity-success ) ) TO reported-OutgoingDeliveries.

  ENDMETHOD.

  METHOD statusUpdate.
    READ ENTITIES OF zetr_ddl_i_outgoing_deliveries IN LOCAL MODE
      ENTITY OutgoingDeliveries
      ALL FIELDS WITH
      CORRESPONDING #( keys )
      RESULT DATA(DeliveryList).

    LOOP AT DeliveryList ASSIGNING FIELD-SYMBOL(<DeliveryLine>).
      TRY.
          DATA(lo_delivery_operations) = zcl_etr_delivery_operations=>factory( <deliveryline>-companycode ).
*          lo_delivery_operations->ou

        CATCH zcx_etr_regulative_exception INTO DATA(lx_exception).
          DATA(lv_error) = CONV bapi_msg( lx_exception->get_text( ) ).
          APPEND VALUE #( DocumentUUID = <DeliveryLine>-DocumentUUID
                          %msg = new_message( id       = 'ZETR_COMMON'
                                              number   = '000'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = lv_error(50)
                                              v2 = lv_error+50(50)
                                              v3 = lv_error+100(50)
                                              v4 = lv_error+150(*) ) ) TO reported-outgoingdeliveries.
          DELETE DeliveryList.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZETR_DDL_I_OUTGOING_DELIVE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZETR_DDL_I_OUTGOING_DELIVE IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.