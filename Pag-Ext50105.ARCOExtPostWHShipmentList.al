pageextension 50105 "ARCO Ext. Post_WH ShipmentList" extends "Posted Whse. Shipment List"
{
    layout
    {
        addbefore("Total Shipment Amt. Exc. P&L")
        {
            field("ARCO Currency Code"; Rec."ARCO Currency Code")
            {
                //Caption ='';
                ApplicationArea = all;
            }
        }
    }
}
