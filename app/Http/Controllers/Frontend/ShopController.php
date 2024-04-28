<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Category;
use App\Models\Brand;
use App\Models\Product;
use App\Models\Testominal;
use App\Models\Slider;




class ShopController extends Controller
{
    public function ShopPage(){

        $products = Product::query();

        if (!empty($_GET['category'])) {
            $slugs = explode(',',$_GET['category']);
            $catIds = Category::select('id')->whereIn('category_slug_en',$slugs)->pluck('id')->toArray();
            $products = $products->whereIn('category_id',$catIds);

        }
         if (!empty($_GET['brand'])) {
            $slugs = explode(',',$_GET['brand']);
            $brandIds = Brand::select('id')->whereIn('brand_slug_en',$slugs)->pluck('id')->toArray();
            $products = $products->whereIn('brand_id',$brandIds);        }
        else{
             $products = Product::where('status',1)->orderBy('id','DESC');
        }
        $brands = Brand::orderBy('brand_name_en','ASC')->get();
        $categories = Category::orderBy('category_name_en','ASC')->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();
        $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();


        return view('frontend.shop.shop_page',compact('products','categories','brands','testominals','sliders'));


    } // end Method

    public function ShopFilter(Request $request){
        //dd($request->all());

        {
            $category_id = $request->input('category');
            $brand_id = $request->input('brand');
            $testominals = Testominal::orderBy('testominal_name','ASC')->get();
            $brando = Brand::orderBy('brand_name_en','ASC')->get();
            $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();

            $products = Product::when($category_id, function ($query) use ($category_id) {
                return $query->where('category_id', $category_id);
            })->when($brand_id, function ($query) use ($brand_id) {
                return $query->where('brand_id', $brand_id);
            })->get();

            $categories = Category::all();
            $brands = Brand::all();

            return view('frontend.shop.shop_page', compact('products', 'categories', 'brands','testominals','brando','sliders'));
        }


    } // end Method
    }



