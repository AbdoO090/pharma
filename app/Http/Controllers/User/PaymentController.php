<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
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
use App\Models\ShipDivision;
use App\Models\Order;
use App\Models\OrderItem;
use App\Mail\OrderMail;

use Illuminate\Support\Facades\Session;
use Auth;
use Carbon\Carbon;

class PaymentController extends Controller
{

    public function checkoutPay(){
        $user = Auth::user();

        $cart = \App\Models\Cart::where('user_id',$user->id)->get();

        $total = 0;

        foreach ($cart as $key => $item) {
            $total += $item->price * $item->quantity;
        }




        if (Session::has('coupon')) {
    		$total_amount = Session::get('coupon')['total_amount'];
    	}else{
    		$total_amount = round(  $total);
    	}


        $data['client_reference_id']=                rand(11111,99999);
        $data['mode']='payment';
        $data['products']=[
        [
            'name'=>    'personal Laptop',
            'quantity'=>  1,
            'unit_amount'=>100,

        ],
        [
            'name'=>    'mouse',
            'quantity'=>  2,
            'unit_amount'=>$total_amount*100,

        ],
        ];

        $data['success_url']=                                       route('success');
        $data['cancel_url']=                                       route('cancel');
        $data['metadata']['customer_name']=                           'Abdelrahamn Soliman';
        $data['metadata']['order_id']=                          Str::upper(Str::random(6)) ;


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

 $session_id = json_decode($response)->data->session_id;
 \Session::put('session_id',$session_id);
 $Checkout_url='https://uatcheckout.thawani.om/pay/'.$session_id.'?key=HGvTMLDssJghr9tlN9gr4DVYt0qyBy';
//dd($Checkout_url);
return redirect()->to($Checkout_url);


    }

    public function success(Request $request){
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

   $order_id = Order::insertGetId([
   'user_id' => Auth::id(),
   'division_id' => $request->division_id,
   'district_id' => $request->district_id,
   'state_id' => $request->state_id,
   'name' => $request->name,
   'email' => $request->email,
   'phone' => $request->phone,
   'post_code' => $request->post_code,
   'notes' => $request->notes,
   'payment_type' => 'Cash By debit Card',
   'payment_method' => 'Cash by Debit Card',

   'currency' =>  'OMR',
   'amount' => $total_amount,


   'invoice_no' => 'EOS'.mt_rand(10000000,99999999),
   'order_date' => Carbon::now()->format('d F Y'),
   'order_month' => Carbon::now()->format('F'),
   'order_year' => Carbon::now()->format('Y'),
   'status' => 'Pending',
   'created_at' => Carbon::now(),

   ]);

   // Start Send Email
   $invoice = Order::findOrFail($order_id);
   $data = [
     'invoice_no' => $invoice->invoice_no,
     'amount' => $total_amount,
     'name' => $invoice->name,
     'email' => $invoice->email,
   ];

   Mail::to($request->email)->send(new OrderMail($data));

   // End Send Email



   foreach ($cart as $cart) {
   OrderItem::insert([
     'order_id' => $order_id,
     'product_id' => $cart->id,

     'qty' => $cart->quantity,
     'price' => $cart->price,
     'created_at' => Carbon::now(),

   ]);
   }


   if (Session::has('coupon')) {
   Session::forget('coupon');
   }

   Cart::destroy($cart);

   $notification = array(
    'message' => 'Your Order Place Successfully',
    'alert-type' => 'success'
   );









     $session_id=   \Session::get('session_id');
     $response=  $this->transactionStatus($session_id);
     \Session::forget('session_id');


    return view('frontend.index',compact('sliders','blogpost','categories','products','feature','hot_deals','special_offer','special_deals',
    'skip_category_0','skip_product_0','skip_category_1','skip_product_1','skip_brand_1','skip_brand_product_1','brands','testominals'))->with($notification);

    }

    public function cancel(){
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






        $session_id=   \Session::get('session_id');
        $response=  $this->transactionStatus($session_id);
        \Session::forget('session_id');
        $notification = array(
            'message' => 'Paymet Canceled',
            'alert-type' => 'danger'
        );

        return view('frontend.index',compact('sliders','blogpost','categories','products','feature','hot_deals','special_offer','special_deals',
        'skip_category_0','skip_product_0','skip_category_1','skip_product_1','skip_brand_1','skip_brand_product_1','brands','testominals'))->with($notification);


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
