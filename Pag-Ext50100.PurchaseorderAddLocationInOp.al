pageextension 50102 Purchase_order_AddLocationInOp extends "Purchase Order"
{
    layout
    {
        modify(Control98) // add loactoin code in custom
        {
            //Visible = false;
            Visible = (ShipToOptions = ShipToOptions::Location) or (ShipToOptions = ShipToOptions::"Customer Address") or (ShipToOptions = ShipToOptions::"Custom Address");

        }
        modify("Location Code")
        {
            Editable = (ShipToOptions = ShipToOptions::Location) or (ShipToOptions = ShipToOptions::"Custom Address");
            Importance = Additional;

        }
        // modify(ShippingOptionWithLocation)
        // {
        //     trigger OnAfterValidate()

        //     begin
        //         // case ShipToOptions of
        //         //     shipToOptions::"Custom Address":
        //         //         if (xrec."Location Code" = '') and (xRec."Ship-to Address" = '') then
        //         //             rec.Validate("Ship-to Address", '');

        //         // end;
        //     end;
        // }


    }

}
