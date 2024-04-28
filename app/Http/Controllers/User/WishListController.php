<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Wishlist;
use App\Models\Product;

use Illuminate\Support\Facades\Auth;

use Carbon\Carbon;

class WishListController extends Controller
{
    public function addToWishlist(Request $request)
    {


        if (  Auth::check() ) {

          $product_id=$request->product_id;
        $pro=  Product::find($product_id);

          if($pro){

            $wish=new Wishlist();

            $wish->product_id=$product_id;
           $wish->user_id=Auth::id();
           $wish->save();
           $notification = array(
            'message' => 'Added To Wishlist Successfully',
            'alert-type' => 'success'
        );

        return redirect()->back()->with($notification);

          }

          else{

              $notification = array(
                  'message' => 'Failed To Added Wishlist ',
                  'alert-type' => 'danger'
              );

              return redirect()->back()->with($notification);    }



        }
        else{
            $notification = array(
                'message' => 'Login first ',
                'alert-type' => 'info'
            );

            return redirect()->back()->with($notification);    }

        }




    public function showWishlist(Request $request)
    {
        $wishlist = Wishlist::where('user_id', '=', Auth::id())->get();


        return view('frontend.wishlist.view_wishlist', compact('wishlist'));
    }



    public function delete(Request $request)
    {
        Wishlist::findOrFail($request->id)->delete();

       $notification = array(
        'message' => 'Item Deleted Successfully ',
        'alert-type' => 'danger'
    );
    return redirect()->back()->with($notification);




}
}
