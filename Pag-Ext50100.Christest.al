// pageextension 59997 Chris_test extends "Sales & Receivables Setup"
// {
//     actions
//     {
//         addafter("Update SO Stock Info")
//         {
//             action("update_chris test")
//             {
//                 ApplicationArea = all;
//                 trigger OnAction()
//                 var
//                     ARCOUpdate_C: Report "ARCO Update SO Stock Info_c";
//                 begin
//                     ARCOUpdate_C.Run();
//                 end;
//             }
//         }
//     }
// }
