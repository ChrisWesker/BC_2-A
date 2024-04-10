pageextension 50104 "ARCO Ext. WH Shipment List" extends "Warehouse Shipment List"
{
    layout
    {
        addbefore("Total Shipment Amt. Exc. P&L")
        {
            field("ARCO Currency Code"; rec."ARCO Currency Code")
            {
                //Caption ='Currency';
                ApplicationArea = all;

            }
        }
    }
}
