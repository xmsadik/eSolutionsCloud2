managed implementation in class zbp_etr_ddl_i_outgoing_deliver unique;
strict ( 1 );

define behavior for zetr_ddl_i_outgoing_deliveries alias OutgoingDeliveries
//persistent table <???>
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{
  //  create;
  update ( features : instance );
  delete ( features : instance );

  field ( readonly : update ) DocumentUUID;
  field ( readonly ) TaxID;
  field ( features : instance )
  ProfileID,
  Aliass,
  DeliveryType,
  SerialPrefix,
  XSLTTemplate,
  CollectItems,
  DeliveryNote,
  ActualDeliveryDate,
  ActualDeliveryTime,
  VehiclePlate,
  TransportCompanyTaxID,
  TransportCompanyTitle,
  DeliveryAddressStreet,
  DeliveryAddressBuildingName,
  DeliveryAddressBuildingNumber,
  DeliveryAddressRegion,
  DeliveryAddressSubdivision,
  DeliveryAddressCity,
  DeliveryAddressCountry,
  DeliveryAddressPostalCode,
  DeliveryAddressTelephone,
  DeliveryAddressFax,
  DeliveryAddressEMail,
  DeliveryAddressWebsite,
  PrintedDocumentDate,
  PrintedDocumentNumber;

  association _deliveryContents { create; }
  association _deliveryLogs { create; }
  association _deliveryTransporters { create; }

  action ( features : instance ) sendDeliveries result [1] $self;
  action ( features : instance ) archiveDeliveries result [1] $self;
  action ( features : instance ) statusUpdate result [1] $self;
  action ( features : instance ) setAsRejected parameter ZETR_DDL_I_NOTE_SELECTION result [1] $self;
}

define behavior for zetr_ddl_i_outgoing_delcont alias DeliveryContents
persistent table zetr_t_arcd
lock dependent by _outgoingDeliveries
authorization dependent by _outgoingDeliveries
//etag master <field_name>
{
  update;
  delete;

  field ( readonly ) DocumentUUID;
  field ( readonly : update ) DocumentType, ContentType;

  association _outgoingDeliveries;

  mapping for zetr_t_arcd
    {
      ArchiveUUID  = arcid;
      DocumentUUID = docui;
      ContentType  = conty;
      DocumentType = docty;
      Content      = contn;
    }
}

define behavior for zetr_ddl_i_outgoing_dellogs alias Logs
persistent table zetr_t_logs
lock dependent by _outgoingDeliveries
authorization dependent by _outgoingDeliveries
//etag master <field_name>
{
  //  update;
  //  delete;

  field ( readonly : update ) LogUUID, DocumentUUID;

  association _outgoingDeliveries;

  mapping for zetr_t_logs
    {
      LogUUID      = logui;
      DocumentUUID = docui;
      CreatedBy    = uname;
      CreationDate = datum;
      CreationTime = uzeit;
      LogCode      = logcd;
      LogNote      = lnote;
    }
}

define behavior for zetr_ddl_i_outgoing_deltrns alias Transporters
persistent table zetr_t_odti
lock dependent by _outgoingDeliveries
authorization dependent by _outgoingDeliveries
//etag master <field_name>
{
  update;
  delete;

  field ( readonly ) DocumentUUID;
  field ( readonly : update ) ItemNumber;

  association _outgoingDeliveries;

  mapping for zetr_t_odti
    {
      DocumentUUID    = docui;
      ItemNumber      = buzei;
      TransporterType = trnst;
      Transporter     = trnsp;
      Title           = title;
      FirstName       = namef;
      LastName        = namel;
    }
}