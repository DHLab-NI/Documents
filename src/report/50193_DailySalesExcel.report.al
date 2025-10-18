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
            RequestFilterFields = "Entry No.", "G/L Account No.", "Source Code", "Source No.", "Global Dimension 1 Code", "Global Dimension 2 Code";

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
            trigger OnPreDataItem()
            begin

                // Apply date filter to the G/L Entry table
                GLEntry.SetRange("Posting Date", FromDate, ToDate);

            end;
        }
    }

    requestpage
    {
        savevalues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(FromDateFormula; FromDateFormula)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date Formula';
                        ToolTip = 'Enter a date formula for the start date (e.g., TODAY, TODAY-1, CM for current month)';
                    }
                    field(ToDateFormula; ToDateFormula)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date Formula';
                        ToolTip = 'Enter a date formula for the end date (e.g., TODAY, TODAY-1, CM for current month)';
                    }
                }
            }
        }
    }

    var
        FromDateFormula: DateFormula;
        ToDateFormula: DateFormula;
        FromDate: Date;
        ToDate: Date;

    trigger OnPreReport()
    var
        DefaultFromFormula: DateFormula;
        DefaultToFormula: DateFormula;
    begin
        // Set default formulas if not specified
        if Format(FromDateFormula) = '' then begin
            Evaluate(DefaultFromFormula, 'TODAY');
            FromDateFormula := DefaultFromFormula;
        end;
        if Format(ToDateFormula) = '' then begin
            Evaluate(DefaultToFormula, 'TODAY');
            ToDateFormula := DefaultToFormula;
        end;

        // Calculate actual dates from formulas
        FromDate := CalcDate(FromDateFormula, Today);
        ToDate := CalcDate(ToDateFormula, Today);

    end;
}