<?php

namespace App\Http\Controllers\Frontend;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
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
use Illuminate\Support\Facades\Session;




use Carbon\Carbon;






class CartController extends Controller
{





   public function addcart( Request $request ){
    if (Session::has('coupon')) {
        Session::forget('coupon');
     }
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




 // if(session()->has('id')){

   $product= Product::find((int)$request->product_id);

   $item= Cart::create([
   'quantity'=>(int)$request->product_qyt,
    'product_id'=>$product->id,
    'name'=>$product->product_name_en,
    'price'=>$product->selling_price,
   'user_id'=>$request->user()->id,
   'image' => $product->product_thambnail,
    ]);
    $notification = array(
        'message' => 'Shopping At list One Product',
        'alert-type' => 'success'
    );

    return view('frontend.index',compact('item','sliders','blogpost','categories','products','feature','hot_deals','special_offer','special_deals',
    'skip_category_0','skip_product_0','skip_category_1','skip_product_1','skip_brand_1','skip_brand_product_1','brands','testominals'))->with($notification);

////} else{



   }



   public function cartList()
    {

        $cartItems = Cart::latest()->get();
        $brands = Brand::orderBy('brand_name_en','ASC')->get();

        // dd($cartItems);
    	return view('frontend.wishlist.view_mycart',compact('cartItems','brands'));
    }

    public function removeCart(Request $request)
    {

        $cartItems= new Cart;
        $cartItems->destroy($request->id);
        if (Session::has('coupon')) {
            Session::forget('coupon');
         }
         $notification = array(
            'message' => 'Cart Removed Successfully',
            'alert-type' => 'warning'
        );



    	return redirect()->back()->with($notification);

    }

     // add to wishlist mehtod

    public function CouponApply(Request $request){
        json_encode($request);

        $request->total;
        $carts = Cart::where('user_id', $request->user()->id)->get();



        $coupon = Coupon::where('coupon_name',$request->coupon_name)->where('coupon_validity','>=',Carbon::now()->format('Y-m-d'))->first();


        if (isset($coupon)) {
            Session::put('coupon',[
                'coupon_name' => $coupon->coupon_name,
                'coupon_discount' => $coupon->coupon_discount,
                'discount_amount' => round( $request->total * $coupon->coupon_discount/100),
                'total_amount' => round( $request->total -  $request->total * $coupon->coupon_discount/100),
                'validity' => true,


            ]);

            return "done";



        }else{
            return response()->json(['error' => 'Invalid Coupon']);
        }
    } // end method
    public function CouponCalculation(Request $request){
        $request->total;
        if (Session::has('coupon')) {
            return response()->json(array(
                'subtotal' => $request->total,
                'coupon_name' => session()->get('coupon')['coupon_name'],
                'coupon_discount' => session()->get('coupon')['coupon_discount'],
                'discount_amount' => session()->get('coupon')['discount_amount'],
                'total_amount' => session()->get('coupon')['total_amount'],
            ));
        }else{
            return response()->json(array(
                'total' =>  $request->total,
            ));
        }
    } // end method
 // Remove Coupon
    public function CouponRemove(){
        Session::forget('coupon');
        return response()->json(['success' => 'Coupon Remove Successfully']);
    }

             public function CheckoutCreate(){

                $user = Auth::user();

                $cart = \App\Models\Cart::where('user_id',$user->id)->get();

                $total = 0;

                foreach ($cart as $key => $item) {
                    $total += $item->price * $item->quantity;
                }
                if (Auth::check()) {
                    if ($total > 0) {

                $divisions = ShipDivision::orderBy('division_name','ASC')->get();
                return view('frontend.checkout.checkout_view',compact('divisions','cart',));

                    }else{

                    $notification = array(
                    'message' => 'Shopping At list One Product',
                    'alert-type' => 'error'
                );
                return redirect()->to('/')->with($notification);
                    }

                }else{
                     $notification = array(
                    'message' => 'You Need to Login First',
                    'alert-type' => 'error'
                );
                return redirect()->route('login')->with($notification);

                }


            } // end method




    }








