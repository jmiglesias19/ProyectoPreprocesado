pageextension 50100 "Create Incoming WS Orders" extends "Sales Order List"
{
    layout
    {

    }

    actions
    {
        addfirst(processing)
        {
            group("New Document")
            {
                Caption = 'New Document';

                action(CreateIncomingWSOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Create Incoming WS Orders';
                    ToolTip = 'Create four incoming webservice orders.';
                    Image = Order;

                    trigger OnAction()
                    var
                        IncomingOrders: Codeunit "Order Creation WebService";
                    begin
                        IncomingOrders.IncomingOrders();
                        Message('Orders Created!');
                    end;
                }
            }
        }
    }

}
