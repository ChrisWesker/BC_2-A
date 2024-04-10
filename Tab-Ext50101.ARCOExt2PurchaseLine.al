tableextension 50101 "ARCO Ext.2 Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50100; "ARCO Price Starting date"; Date)
        {
            Caption = 'ARCO Price Starting date';
            DataClassification = ToBeClassified;
            Editable = false;

        }
    }
}
