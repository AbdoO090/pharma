<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use Auth;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\SubCategory;

use App\Models\User;
use App\Models\Slider;
use App\Models\Product;
use App\Models\Brand;
use App\Models\Testominal;
use App\Models\MultiImage;
use App\Models\BlogPost;
use App\Models\Cart;

use Illuminate\Support\Facades\Hash;

class IndexController extends Controller
{
    public function index(){
        $products = Product::where('status',1)->orderBy('id','DESC')->limit(6)->get();
        $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

    	$categories = Category::orderBy('category_name_en','ASC')->get();
    	$brands = Brand::orderBy('brand_name_en','ASC')->get();
        $feature = Product::where('feature',1)->orderBy('id','DESC')->limit(6)->get();
        $hot_deals = Product::where('hot_deals',1)->where('discount_price','!=',NULL)->orderBy('id','DESC')->limit(3)->get();
        $special_offer = Product::where('special_offer',1)->orderBy('id','DESC')->limit(6)->get();
        $special_deals = Product::where('special_deal',1)->orderBy('id','DESC')->limit(3)->get();
    	$blogpost = BlogPost::latest()->get();

    	$skip_category_0 = Category::skip(0)->first();
    	$skip_product_0 = Product::where('status',1)->where('category_id',$skip_category_0->id)->orderBy('id','DESC')->get();

        	$skip_category_1 = Category::skip(1)->first();
    	$skip_product_1 = Product::where('status',1)->where('category_id',$skip_category_1->id)->orderBy('id','DESC')->get();
        $cartItems = Cart::latest()->get();




    	// return $skip_category->id;
    	// die();


    	return view('frontend.index',compact('categories','sliders','products','feature','hot_deals','special_offer','special_deals','skip_category_0','skip_product_0','skip_category_1','skip_product_1','blogpost','brands','testominals','cartItems'));



    }
    public function ProductDetails($id,$slug){
		$product = Product::findOrFail($id);
        $multiImag = MultiImage::where('product_id',$id)->get();
        $cat_id = $product->category_id;
		$relatedProduct = Product::where('category_id',$cat_id)->where('id','!=',$id)->orderBy('id','DESC')->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();
        $special_deals = Product::where('special_deal',1)->orderBy('id','DESC')->limit(3)->get();
        $cartItems = Cart::latest()->get();




        return view('frontend.product.product_details',compact('product','multiImag','relatedProduct','cat_id','testominals','special_deals','cartItems'));


	}
    public function TagWiseProduct($tag){
        $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();

		$products = Product::where('status',1)->where('product_tag_en',$tag)->where('product_tag_ar',$tag)->orderBy('id','DESC')->paginate(3);
		$categories = Category::orderBy('category_name_en','ASC')->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

		return view('frontend.tags.tags_view',compact('products','categories','testominals','sliders'));



	}
    public function SubCatWiseProduct($subcat_id,$slug){
		$products = Product::where('status',1)->where('subcategory_id',$subcat_id)->orderBy('id','DESC')->paginate(3);
		$categories = Category::orderBy('category_name_en','ASC')->get();
        $breadsubcat = SubCategory::with(['category'])->where('id',$subcat_id)->get();
        $sliders = Slider::where('status',1)->orderBy('id','DESC')->limit(3)->get();

        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

		return view('frontend.product.subcategory_view',compact('products','categories','breadsubcat','testominals','sliders'));


	}
    public function ProductViewAjax($id){
        $product = Product::with('category','brand')->findOrFail($id);
		return response()->json(array(
			'product' => $product,
		));

	} // end method


    //////// user profile functions
    public function UserLogout(){
    	Auth::logout();
    	return Redirect()->route('login');
    }
    public function UserProfile(){
    	$id = Auth::user()->id;
    	$user = User::find($id);
    	return view('frontend.profile.user_profile',compact('user'));
    }
    public function UserProfileStore(Request $request){
        $data = User::find(Auth::user()->id);
		$data->name = $request->name;
		$data->email = $request->email;
		$data->phone = $request->phone;
		if ($request->file('profile_photo_path')) {
			$file = $request->file('profile_photo_path');
			@unlink(public_path('upload/user_images/'.$data->profile_photo_path));
			$filename = date('YmdHi').$file->getClientOriginalName();
			$file->move(public_path('upload/user_images'),$filename);
			$data['profile_photo_path'] = $filename;
		}
		$data->save();
		$notification = array(
			'message' => 'User Profile Updated Successfully',
			'alert-type' => 'success'
		);
		return redirect()->route('dashboard')->with($notification);
    } // end method
    public function UserChangePassword(){
    	$id = Auth::user()->id;
    	$user = User::find($id);
    	return view('frontend.profile.change_password',compact('user'));
    }
    public function UserPasswordUpdate(Request $request){
		$validateData = $request->validate([
			'oldpassword' => 'required',
			'password' => 'required|confirmed',
		]);
		$hashedPassword = Auth::user()->password;
		if (Hash::check($request->oldpassword,$hashedPassword)) {
			$user = User::find(Auth::id());
			$user->password = Hash::make($request->password);
			$user->save();
			Auth::logout();
			return redirect()->route('user.logout');
		}else{
			return redirect()->back();
		}
	}// end method

     // Product Seach
	public function ProductSearch(Request $request){
		$request->validate(["search" => "required"]);
        $item = $request->search;
		// echo "$item";

        $categories = Category::orderBy('category_name_en','ASC')->get();
		$products = Product::where('product_name_en','LIKE',"%$item%")->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

		return view('frontend.product.search',compact('products','categories','testominals'));
    }


    public function SearchProduct(Request $request){
		$request->validate(["search" => "required"]);

		$item = $request->search;

		$products = Product::where('product_name_en','LIKE',"%$item%")->select('product_name_en','product_thambnail','selling_price','id','product_slug_en')->limit(5)->get();
		return view('frontend.product.search_product',compact('products'));




	} // end method

}
