codeunit 50100 "Order Creation WebService"
{

    Permissions = tabledata "Sales Header" = im,
                  tabledata "Sales Line" = im;

    procedure CreateThisOrder(CustomerNo: Code[20]; ItemNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
#if ReleaseAfterCreation
        ReleaseSalesDocument: Codeunit "Release Sales Document";
#endif
    begin
        CreateSalesHeader(SalesHeader, CustomerNo);
        CreateSalesLine(SalesHeader, ItemNo);
#if ReleaseAfterCreation
        ReleaseSalesDocument.PerformManualRelease(SalesHeader);
#endif
    end;

    local procedure CreateSalesHeader(var SalesHeader: Record "Sales Header"; CustomerNo: Code[20])
    begin
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
#if ReleaseAfterCreation
        SalesHeader.Validate("External Document No.", 'WebService2');
#else
        SalesHeader.Validate("External Document No.", 'WebService');
#endif
        SalesHeader.Validate("Order Date", Today());
        SalesHeader.Modify(true);
    end;

    local procedure CreateSalesLine(var SalesHeader: Record "Sales Header"; ItemNo: Code[20])
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Insert(true);

        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", ItemNo);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);
    end;

    procedure IncomingOrders()
    begin
        CreateThisOrder('10000', '1000');
        CreateThisOrder('20000', '1900');
        CreateThisOrder('01905899', '80013');
        CreateThisOrder('01905902', '80216-T');
    end;

}