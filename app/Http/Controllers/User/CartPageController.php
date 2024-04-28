<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Cart;


class CartPageController extends Controller
{
    public function MyCart(){

        $carts = Cart::latest()->get();
    	return view('frontend.wishlist.view_mycart',compact('carts'));

    }









}

