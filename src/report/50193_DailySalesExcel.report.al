report 50193 "DHLab Daily Sales Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'DailySalesReport.xlsx';

    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.") where("G/L Account No." = filter('5100..5899'));
            RequestFilterFields = "Entry No.", "Posting Date", "G/L Account No.", "Source Code", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code";

            column(EntryNo; "Entry No.")
            {
                IncludeCaption = true;
            }
            column(GLAccountNo; "G/L Account No.")
            {
                IncludeCaption = true;
            }
            column(GLAccountName; "G/L Account Name")
            {
                IncludeCaption = true;
            }
            column(PostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(DocumentType; "Document Type")
            {
                IncludeCaption = true;
            }
            column(DocumentNo; "Document No.")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(SourceCode; "Source Code")
            {
                IncludeCaption = true;
            }
            column(SourceNo; "Source No.")
            {
                IncludeCaption = true;
            }
            column(Amount; Amount)
            {
                IncludeCaption = true;
            }
            column(REGION; "Global Dimension 1 Code")
            {
                IncludeCaption = true;
            }
            column(DEPT; "Global Dimension 2 Code")
            {
                IncludeCaption = true;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                }
            }
        }
    }

    var

    trigger OnPreReport()
    begin

    end;
}