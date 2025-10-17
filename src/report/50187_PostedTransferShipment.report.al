// DHLab Posted Transfer Shipment
// SGH 12/03/25
report 50187 PostedTransferShipment
{
    //Make the report searchable from Tell me under the Administration category.
    //UsageCategory = Administration;
    //ApplicationArea = All;
    Caption = 'DHLab Posted Transfer Shipment';
    //
    DefaultLayout = Word;
    WordLayout = '50187_DHLab_Posted_Trfr_Shipmt.docx';

    dataset
    {

        dataitem(Header; "Transfer Shipment Header")
        {
            DataItemTableView = Sorting("No.");
            RequestFilterFields = "No.";

            column(DocNo_Header; "No.")
            {
                IncludeCaption = true;

            }

            column(Transfer_from_Code; "Transfer-from Code")
            {
                IncludeCaption = true;
            }

            column(Transfer_to_Code; "Transfer-to Code")
            {
            }

            column(Transfer_from_Name; "Transfer-from Name")
            {
            }

            column(Transfer_to_Name; "Transfer-to Name")
            {
            }

            column(Transfer_Order_Date; "Transfer Order Date")
            {
            }

            column(Transfer_Order_No_; "Transfer Order No.")
            {
            }

            column(Posting_Date; "Posting Date")
            {
            }

            column(Shipment_Date; "Shipment Date")
            {
            }

            column(Receipt_Date; "Receipt Date")
            {
            }
            column(External_Document_No; "External Document No.")
            {
                //Caption = 'Currency';
            }

            dataitem(Line; "Transfer Shipment Line")
            {

                DataItemTableView = sorting("Line No.");
                DataItemLink = "Document No." = field("No.");

                column(Item_No; "Item No.")
                {
                    IncludeCaption = true;

                }

                column(Description_Line; "Description")
                {
                    IncludeCaption = true;

                }

                column(Description2_Line; "Description 2")
                {
                    IncludeCaption = true;

                }

                column(UnitOfMeasure_Line; "Unit of Measure")
                {
                    IncludeCaption = true;

                }

                column(UnitOfMeasureCode_Line; "Unit of Measure Code")
                {
                    IncludeCaption = true;

                }

                column(Quantity_Line; "Quantity")
                {
                    IncludeCaption = true;

                }
                dataitem(Item; Item)
                {

                    DataItemLink = "No." = field("Item No.");

                    column(Shelf_No; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }

                }

            }



        }

        dataitem(CompanyInfo; "Company Information")
        {

            column(Name_CompanyInfo; "Name")
            {
                IncludeCaption = true;

            }

            column(Name2_CompanyInfo; "Name 2")
            {
                IncludeCaption = true;

            }

            column(Address_CompanyInfo; "Address")
            {
                IncludeCaption = true;

            }

            column(Address2_CompanyInfo; "Address 2")
            {
                IncludeCaption = true;

            }

            column(City_CompanyInfo; "City")
            {
                IncludeCaption = true;

            }

            column(PhoneNo_CompanyInfo; "Phone No.")
            {
                IncludeCaption = true;

            }

            column(BankName_CompanyInfo; "Bank Name")
            {
                IncludeCaption = true;

            }

            column(BankBranchNo_CompanyInfo; "Bank Branch No.")
            {
                IncludeCaption = true;

            }

            column(BankAccountNo_CompanyInfo; "Bank Account No.")
            {
                IncludeCaption = true;

            }

            column(VatRegistrationNo_CompanyInfo; "VAT Registration No.")
            {
                IncludeCaption = true;

            }

            column(RegistrationNo_CompanyInfo; "Registration No.")
            {
                IncludeCaption = true;

            }

            column(Picture_CompanyInfo; "Picture")
            {
                IncludeCaption = true;

            }

            column(PostCode_CompanyInfo; "Post Code")
            {
                IncludeCaption = true;

            }

            column(County_CompanyInfo; "County")
            {
                IncludeCaption = true;

            }

            column(EMail_CompanyInfo; "E-Mail")
            {
                IncludeCaption = true;

            }

            column(HomePage_CompanyInfo; "Home Page")
            {
                IncludeCaption = true;

            }
            column(Country_CompanyInfo; "Country/Region Code")
            {
                IncludeCaption = true;

            }

            column(Iban_CompanyInfo; "IBAN")
            {
                IncludeCaption = true;

            }

            column(SwiftCode_CompanyInfo; "SWIFT Code")
            {
                IncludeCaption = true;

            }

            column(RegisteredName_CompanyInfo; "Registered Name")
            {
                IncludeCaption = true;

            }


            column(RegisteredName2_CompanyInfo; "Registered Name 2")
            {
                IncludeCaption = true;

            }

            column(RegisteredAddress_CompanyInfo; "Registered Address")
            {
                IncludeCaption = true;

            }

            column(RegisteredAddress2_CompanyInfo; "Registered Address 2")
            {
                IncludeCaption = true;

            }

            column(RegisteredCity_CompanyInfo; "Registered City")
            {
                IncludeCaption = true;

            }

            column(RegisteredCounty_CompanyInfo; "Registered County")
            {
                IncludeCaption = true;

            }

            column(RegisteredPostCode_CompanyInfo; "Registered Post Code")
            {
                IncludeCaption = true;

            }

        }

    }

    // Variables for totals calculation



    // These labels will be used later as captions in the report layout.  
    labels
    {
        Trfr_Shipmt_Document_Caption = 'Transfer Shipment';
    }

    var


}