pageextension 50106 "ARCO Ext. PurchaseQuoteSubform" extends "Purchase Quote Subform"
{
    layout
    {
        addafter("Item Reference No.")
        {
            // << 2024.01.10 Chris test for pirce strat date>>
            field("ARCO Price Starting date"; rec."ARCO Price Starting date")
            {
                Caption = '報價開始日期';
                ApplicationArea = all;
            }
        }
    }
}
