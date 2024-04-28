<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ShipDivision;
use App\Models\ShipDistrict;
use App\Models\ShipState;

use Exception;

use Str;
use App\Models\Cart;
use App\Models\Product;
use App\Models\Category;
use App\Models\Slider;
use App\Models\Brand;
use App\Models\MultiImage;
use App\Models\BlogPost;
use App\Models\Wishlist;
use App\Models\Testominal;
use App\Models\Coupon;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Support\Facades\Session;
use Auth;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use App\Mail\OrderMail;

class CheckoutController extends Controller
{
    public function DistrictGetAjax($division_id){

    	$ship = ShipDistrict::where('division_id',$division_id)->orderBy('district_name','ASC')->get();
    	return json_encode($ship);

    } // end method


     public function StateGetAjax($district_id){

    	$ship = ShipState::where('district_id',$district_id)->orderBy('state_name','ASC')->get();
    	return json_encode($ship);

    } // end method
    public function CheckoutStore(Request $request){


        $user = Auth::user();

        $cart = \App\Models\Cart::where('user_id',$user->id)->get();

        $total = 0;

        foreach ($cart as $key => $item) {
            $total += $item->price * $item->quantity;
        }

if (Session::has('coupon')) {
    $total_amount = Session::get('coupon')['total_amount'];
}else{
    $total_amount = round($total);
}



    	// dd($request->all());


    	if ($request->payment_method == 'card') {








            $data['client_reference_id']=                rand(11111,99999);
            $data['mode']='payment';

            $carts = \App\Models\Cart::where('user_id',$user->id)->get();


            $pr = [];

            foreach($carts as $Key => $cart){

                $p = [];
                $p = [
                    'name'=>   $cart->name,
                    'quantity'=>  $cart->quantity,
                    'unit_amount'=> $total_amount *1000,

                ];

                array_push($pr,$p);

            }

            $data['products'] = $pr;
            $data['success_url']=                                       route('success');
            $data['cancel_url']=                                       route('cancel');
            $data['metadata']['customer_name']='Abdelrahamn Soliman';
            $data['metadata']['order_id']= Str::upper(Str::random(6)) ;



     $order_id = array();
     $order_id['user_id'] =  $user->id;

     $order_id['name'] = $request->shipping_name;
     $order_id['email'] = $request->shipping_email;
     $order_id['phone'] = $request->shipping_phone;
     $order_id['post_code'] = $request->post_code;
     $order_id['division_id'] = $request->division_id;
     $order_id['district_id'] = $request->district_id;

     $order_id['notes'] = $request->notes;
     $order_id['payment_method'] = $request->payment_method;
     $order_id['payment_type']='Card Order';


     $order_id['currency'] =  'OMR';
     $order_id['amount']  = $total_amount;

     $order_id['invoice_no']  = 'EOS'.mt_rand(10000000,99999999);
     $order_id['order_date']  = Carbon::now()->format('d F Y');
     $order_id['order_month']  = Carbon::now()->format('F');
     $order_id['order_year'] = Carbon::now()->format('Y');
     $order_id['status'] = 'Pending';
     $order_id['created_at']   = Carbon::now();


     $curl = curl_init();

     curl_setopt_array($curl, [
       CURLOPT_URL => "https://uatcheckout.thawani.om/api/v1/checkout/session",
       CURLOPT_RETURNTRANSFER => true,
       CURLOPT_ENCODING => "",
       CURLOPT_MAXREDIRS => 10,
       CURLOPT_TIMEOUT => 30,
       CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
       CURLOPT_CUSTOMREQUEST => "POST",
       CURLOPT_POSTFIELDS =>json_encode($data),
       CURLOPT_HTTPHEADER => [
         "Content-Type: application/json",
         "thawani-api-key: rRQ26GcsZzoEhbrP2HZvLYDbn9C9et"
       ],
     ]);

     $response = curl_exec($curl);

     $err = curl_error($curl);


     curl_close($curl);

    $result = json_decode($response);
    if($result->code == 2004){
        $session_id = json_decode($response)->data->session_id;

        \Session::put('session_id',$session_id);
        $Checkout_url='https://uatcheckout.thawani.om/pay/'.$session_id.'?key=HGvTMLDssJghr9tlN9gr4DVYt0qyBy';

        $order_id['session_id']  = $session_id;

  $order=Order::create($order_id);

  $invoice = $order;

  $data = [
  'invoice_no' => $invoice->invoice_no,
  'amount' => $total_amount,
  'name' => $invoice->name,
  'email' => $invoice->email,
  ];

  Mail::to($invoice->email)->send(new OrderMail($data));

  // End Send Email




  if (Session::has('coupon')) {
  Session::forget('coupon');
  }

  Cart::destroy($cart);



      //dd($Checkout_url);
      return redirect()->to($Checkout_url);
    }else{
        return $result->description;
    }


    	}

        else{

                $order_id = array();
                $order_id['user_id'] =  $user->id;
                $order_id['name'] = $request->shipping_name;
                $order_id['email'] = $request->shipping_email;
                $order_id['phone'] = $request->shipping_phone;
                $order_id['post_code'] = $request->post_code;
                $order_id['division_id'] = $request->division_id;
                $order_id['district_id'] = $request->district_id;
                $order_id['notes'] = $request->notes;
                $order_id['payment_method'] = $request->payment_method;
                $order_id['payment_type']='Cash Order';
                $order_id['currency'] =  'OMR';
                $order_id['amount']  = $total_amount;
                $order_id['invoice_no']  = 'EOS'.mt_rand(10000000,99999999);
                $order_id['order_date']  = Carbon::now()->format('d F Y');
                $order_id['order_month']  = Carbon::now()->format('F');
                $order_id['order_year'] = Carbon::now()->format('Y');
                $order_id['status'] = 'pending';
                $order_id['created_at']   = Carbon::now();



$order = Order::create($order_id);

$user = Auth::user();

$cart = \App\Models\Cart::where('user_id',$user->id)->get();

$total = 0;

foreach ($cart as $key => $item) {
    $total += $item->price * $item->quantity;
}

if (Session::has('coupon')) {
$total_amount = Session::get('coupon')['total_amount'];
}else{
$total_amount = round($total);
}



// dd($charge);


// Start Send Email
$invoice = $order;

$data = [
'invoice_no' => $invoice->invoice_no,
'amount' => $total_amount,
'name' => $invoice->name,
'email' => $invoice->email,
];

Mail::to($invoice->email)->send(new OrderMail($data));

// End Send Email




foreach ($cart as $car) {

    $it = new OrderItem();
    $it->order_id = $order->id;
    $it->product_id = $car->product_id;
    $it->qty = $car->quantity;
    $it->price = $car->price;
    $it->save();
}


if (Session::has('coupon')) {
Session::forget('coupon');
}

Cart::destroy($cart);


    		return view('frontend.payment.cash',compact('order_id',));
    	}


    }// end mehtod.




    public function success(){
        $user = Auth::user();

        $cart = \App\Models\Cart::where('user_id',$user->id)->get();


        $session_id=   \Session::get('session_id');

        $or = Order::where('session_id',$session_id)->first();
        $or->update(['status' => 'confirm']);
        $products = Product::where('status',1)->orderBy('id','DESC')->limit(6)->get();
        $blogpost = BlogPost::latest()->get();
        $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();
        $categories = Category::orderBy('category_name_en','ASC')->get();
        $feature = Product::where('feature',1)->orderBy('id','DESC')->limit(6)->get();
        $hot_deals = Product::where('hot_deals',1)->where('discount_price','!=',NULL)->orderBy('id','DESC')->limit(3)->get();
        $special_offer = Product::where('special_offer',1)->orderBy('id','DESC')->limit(6)->get();
        $special_deals = Product::where('special_deal',1)->orderBy('id','DESC')->limit(3)->get();
        $skip_category_0 = Category::skip(0)->first();
        $skip_product_0 = Product::where('status',1)->where('category_id',$skip_category_0->id)->orderBy('id','DESC')->get();
        $skip_category_1 = Category::skip(1)->first();
        $skip_product_1 = Product::where('status',1)->where('category_id',$skip_category_1->id)->orderBy('id','DESC')->get();
        $skip_brand_1 = Brand::skip(1)->first();
        $skip_brand_product_1 = Product::where('status',1)->where('brand_id',$skip_brand_1->id)->orderBy('id','DESC')->get();
        $brands = Brand::orderBy('brand_name_en','ASC')->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();



   $response=  $this->transactionStatus($session_id);


     \Session::forget('session_id');
     Cart::destroy($cart);

     $notification = array(
        'message' => 'Payment Done Sussefully',
        'alert-type' => 'danger'
    );
    return view('frontend.index',compact('sliders','blogpost','categories','products','feature','hot_deals','special_offer','special_deals',
    'skip_category_0','skip_product_0','skip_category_1','skip_product_1','skip_brand_1','skip_brand_product_1','brands','testominals'))->with( $notification);

    }
    public function cancel(){

        $user = Auth::user();

        $cart = \App\Models\Cart::where('user_id',$user->id)->get();

        $session_id=   \Session::get('session_id');

        $or = Order::where('session_id',$session_id)->first();
        $or->update(['status' => 'cancel']);
        $products = Product::where('status',1)->orderBy('id','DESC')->limit(6)->get();
        $blogpost = BlogPost::latest()->get();
        $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();
        $categories = Category::orderBy('category_name_en','ASC')->get();
        $feature = Product::where('feature',1)->orderBy('id','DESC')->limit(6)->get();
        $hot_deals = Product::where('hot_deals',1)->where('discount_price','!=',NULL)->orderBy('id','DESC')->limit(3)->get();
        $special_offer = Product::where('special_offer',1)->orderBy('id','DESC')->limit(6)->get();
        $special_deals = Product::where('special_deal',1)->orderBy('id','DESC')->limit(3)->get();
        $skip_category_0 = Category::skip(0)->first();
        $skip_product_0 = Product::where('status',1)->where('category_id',$skip_category_0->id)->orderBy('id','DESC')->get();
        $skip_category_1 = Category::skip(1)->first();
        $skip_product_1 = Product::where('status',1)->where('category_id',$skip_category_1->id)->orderBy('id','DESC')->get();
        $skip_brand_1 = Brand::skip(1)->first();
        $skip_brand_product_1 = Product::where('status',1)->where('brand_id',$skip_brand_1->id)->orderBy('id','DESC')->get();
        $brands = Brand::orderBy('brand_name_en','ASC')->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();
   $response=  $this->transactionStatus($session_id);
     \Session::forget('session_id');



     Cart::destroy($cart);



     $notification = array(
        'message' => 'Payment Faild ',
        'alert-type' => 'danger'
    );
    return view('frontend.index',compact('sliders','blogpost','categories','products','feature','hot_deals','special_offer','special_deals',
    'skip_category_0','skip_product_0','skip_category_1','skip_product_1','skip_brand_1','skip_brand_product_1','brands','testominals'))->with( $notification);

    }


    public function transactionStatus($session_id){
        $curl = curl_init();

        curl_setopt_array($curl, [
          CURLOPT_URL => "https://uatcheckout.thawani.om/api/v1/checkout/session/".$session_id,
          CURLOPT_RETURNTRANSFER => true,
          CURLOPT_ENCODING => "",
          CURLOPT_MAXREDIRS => 10,
          CURLOPT_TIMEOUT => 30,
          CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
          CURLOPT_CUSTOMREQUEST => "GET",
          CURLOPT_HTTPHEADER => [
            "Accept: application/json",
            "thawani-api-key: rRQ26GcsZzoEhbrP2HZvLYDbn9C9et"
          ],
        ]);
        $response = curl_exec($curl);
        $err = curl_error($curl);
        curl_close($curl);

        if ($err) {
            return $err;
          } else {
            return json_decode($response) ;
        }

    }




}
