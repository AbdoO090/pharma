<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Support\Facades\Session;
use Auth;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use App\Mail\OrderMail;
use App\Models\Cart;

class CashController extends Controller
{
    public function CashOrder(Request $request){
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


     if (Session::has('coupon')) {
     	Session::forget('coupon');
     }

     Cart::destroy($cart);

     $notification = array(
			'message' => 'Your Order Place Successfully',
			'alert-type' => 'success'
		);

		return redirect()->route('dashboard')->with($notification);


    } // end method
}
