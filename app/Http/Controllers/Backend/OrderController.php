<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;
use Auth;
use Carbon\Carbon;
use PDF;
use App\Models\Product;
use DB;
use Illuminate\Support\Facades\Http;




class OrderController extends Controller
{

    // Pending Orders
    public function PendingOrders()
    {
        $orders = Order::where('status', 'Pending')->orderBy('id', 'DESC')->get();
        return view('backend.orders.pending_orders', compact('orders'));
    } // end mehtod

    public function PendingOrdersDetails($order_id)
    {

        $order = Order::with('division', 'district', 'state', 'user')->where('id', $order_id)->first();
        $orderItem = OrderItem::with('product')->where('order_id', $order_id)->orderBy('id', 'DESC')->get();
        return view('backend.orders.pending_orders_details', compact('order', 'orderItem'));
    }
    public function ConfirmedOrders()
    {
        $orders = Order::where('status', 'confirm')->orderBy('id', 'DESC')->get();
        return view('backend.orders.confirmed_orders', compact('orders'));
    } // end mehtod


    // Processing Orders
    public function ProcessingOrders()
    {
        $orders = Order::where('status', 'processing')->orderBy('id', 'DESC')->get();
        return view('backend.orders.processing_orders', compact('orders'));
    } // end mehtod


    // Picked Orders
    public function PickedOrders()
    {
        $orders = Order::where('status', 'picked')->orderBy('id', 'DESC')->get();
        return view('backend.orders.picked_orders', compact('orders'));
    } // end mehtod



    // Shipped Orders
    public function ShippedOrders()
    {
        $orders = Order::where('status', 'shipped')->orderBy('id', 'DESC')->get();
        return view('backend.orders.shipped_orders', compact('orders'));
    } // end mehtod


    // Delivered Orders
    public function DeliveredOrders()
    {
        $orders = Order::where('status', 'delivered')->orderBy('id', 'DESC')->get();
        return view('backend.orders.delivered_orders', compact('orders'));
    } // end mehtod


    // Cancel Orders
    public function CancelOrders()
    {
        $orders = Order::where('status', 'cancel')->orderBy('id', 'DESC')->get();
        return view('backend.orders.cancel_orders', compact('orders'));
    } // end mehtod
    public function PendingToConfirm($order_id)
    {

        Order::findOrFail($order_id)->update(['status' => 'confirm']);

        $notification = array(
            'message' => 'Order Confirm Successfully',
            'alert-type' => 'success'
        );

        return redirect()->route('pending-orders')->with($notification);
    } // end method


    public function ConfirmToProcessing($order_id)
    {

        Order::findOrFail($order_id)->update(['status' => 'processing']);

        $notification = array(
            'message' => 'Order Processing Successfully',
            'alert-type' => 'success'
        );

        return redirect()->route('confirmed-orders')->with($notification);
    } // end method



    public function ProcessingToPicked($order_id)
    {

        Order::findOrFail($order_id)->update(['status' => 'picked']);

        $notification = array(
            'message' => 'Order Picked Successfully',
            'alert-type' => 'success'
        );

        return redirect()->route('processing-orders')->with($notification);
    } // end method


    public function PickedToShipped($order_id)
    {

        Order::findOrFail($order_id)->update(['status' => 'shipped']);

        $notification = array(
            'message' => 'Order Shipped Successfully',
            'alert-type' => 'success'
        );

        return redirect()->route('picked-orders')->with($notification);
    } // end method


    public function ShippedToDelivered($order_id)
    {
        $product = OrderItem::where('order_id', $order_id)->get();
        foreach ($product as $item) {
            Product::where('id', $item->product_id)
                ->update(['product_qyt' => DB::raw('product_qyt-' . $item->quantity)]);
        }

        Order::findOrFail($order_id)->update(['status' => 'delivered']);

        $notification = array(
            'message' => 'Order Delivered Successfully',
            'alert-type' => 'success'
        );

        return redirect()->route('shipped-orders')->with($notification);
    } // end method
    public function AdminInvoiceDownload($order_id)
    {

        $order = Order::with('division', 'district', 'state', 'user')->where('id', $order_id)->first();
        $orderItem = OrderItem::with('product')->where('order_id', $order_id)->orderBy('id', 'DESC')->get();

        $pdf = PDF::loadView('backend.orders.order_invoice', compact('order', 'orderItem'))->setPaper('a4')->setOptions([
            'tempDir' => public_path(),
            'chroot' => public_path(),
        ]);
        return $pdf->download('invoice.pdf');
    } // end method              <!--  href="{{ route('confirm.processing',$order->id) }}"-->

    public function returndata(Request $request)
    {

        $url = 'https://stgshom.amaanom.com/api/v1/third-party-apis/store'; // Replace with your actual endpoint URL
        // login

        $endpoint = $url . '/login';
        $data = [
            'email' => 'test1666760965@968.com',
            'password' => 'password',
            'password_confirmation' => 'password'
            // Add more data as needed
        ];

        // dd($endpoint);
        $headers = [
            'Authorization' => 'Bearer YOUR_ACCESS_TOKEN', // Replace with your actual access token
            'Content-Type' => 'application/json',
            // Add more headers as needed
        ];

        $response = Http::withHeaders($headers)->post($endpoint, $data);;
        $final = json_decode($response->body());

        $token = $final->token;


        //send order details to shipping


        // login
        $order = Order::find($request->order_id);

        $endpoint = $url . '/add-order';
        $city_id = $order->district_id;


        $address = $order->division->division_name . " ," . $order->district->district_name ;


        $data = [

            "Store_code" => "+",
            "customer_name" => $request->name,
            "customer_number" => $request->phone,
            "order_price" => $order->amount,
            "wilaya_id" => $city_id,
            "external_shipment_number" => "No data",
            "address" => $address

            // Add more data as needed
        ];
//dd($data);
        $headers = [
            'Authorization' => $token, // Replace with your actual access token
            'Content-Type' => 'application/json',
            // Add more headers as needed
        ];

        $response = Http::withHeaders($headers)->post($endpoint, $data);

        if($response->successful()){

            $order->status = 'processing';
            $order->save();
            $notification = array(
                'message' => 'Order Sent To Shipping Successfully',
                'alert-type' => 'success'
            );
            return redirect()->back()->with($notification);
        }else{
            dd($response);
        }




        // order status




    }
}
