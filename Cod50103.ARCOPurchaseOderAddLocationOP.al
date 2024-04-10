codeunit 50103 ARCOPurchaseOderAddLocationOP
{
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnBeforeCalculateCurrentShippingAndPayToOption, '', false, false)]
    local procedure OnBeforeCalculateCurrentShippingAndPayToOption(var PurchaseHeader: Record "Purchase Header"; var ShipToOptions: Option; var PayToOptions: Option; var IsHandled: Boolean);
    begin
        IsHandled := true;
        case true of
            PurchaseHeader."Sell-to Customer No." <> '':
                ShipToOptions := 2;
            (PurchaseHeader."Location Code" <> '') and (ShipToOptions = 1):
                ShipToOptions := 1;
            (PurchaseHeader."Location Code" <> '') and (ShipToOptions = 3):
                ShipToOptions := 3;
            else
                if PurchaseHeader.ShipToAddressEqualsCompanyShipToAddress() then
                    ShipToOptions := 0
                else
                    ShipToOptions := 3
        end;
        case true of
            (PurchaseHeader."Pay-to Vendor No." = PurchaseHeader."Buy-from Vendor No.") and PurchaseHeader.BuyFromAddressEqualsPayToAddress():
                PayToOptions := 0;
            (PurchaseHeader."Pay-to Vendor No." = PurchaseHeader."Buy-from Vendor No.") and (not PurchaseHeader.BuyFromAddressEqualsPayToAddress()):
                PayToOptions := 1;
            PurchaseHeader."Pay-to Vendor No." <> PurchaseHeader."Buy-from Vendor No.":
                PayToOptions := 2;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnAfterCalculateCurrentShippingAndPayToOption, '', false, false)]
    local procedure OnAfterCalculateCurrentShippingAndPayToOption(var ShipToOptions: Option; var PayToOptions: Option; PurchaseHeader: Record "Purchase Header");
    begin
    end;
}
