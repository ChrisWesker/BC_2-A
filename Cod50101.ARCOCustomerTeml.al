codeunit 50101 ARCOCustomerTeml
{
    TableNo = Customer;

    trigger OnRun()
    begin

    end;

    // [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterCopyFromNewCustomerTemplate', '', true, true)]
    // local procedure "Customer_OnAfterCopyFromNewCustomerTemplate"
    // (
    //     var Customer: Record "Customer";
    //     CustomerTemplate: Record "Customer Templ."
    // )
    // begin
    //     Customer."ARCO Payment Term Desc." := CustomerTemplate."ARCO Payment Term Desc.";
    //     Customer."ARCO Delivery" := CustomerTemplate."ARCO Delivery";
    //     Customer."ARCO Insurance" := CustomerTemplate."ARCO Insurance";
    //     Customer."ARCO Shipment" := CustomerTemplate."ARCO Shipment";
    // end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnAfterApplyCustomerTemplate', '', true, true)]
    // local procedure "Customer Templ. Mgt._OnAfterApplyCustomerTemplate"
    // (
    //     var Customer: Record "Customer";
    //     CustomerTempl: Record "Customer Templ."
    // )
    // begin
    //     Customer."ARCO Payment Term Desc." := CustomerTempl."ARCO Payment Term Desc.";
    //     Customer."ARCO Delivery" := CustomerTempl."ARCO Delivery";
    //     Customer."ARCO Insurance" := CustomerTempl."ARCO Insurance";
    //     Customer."ARCO Shipment" := CustomerTempl."ARCO Shipment";
    // end;
}
