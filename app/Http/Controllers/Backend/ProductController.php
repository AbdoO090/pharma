<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Brand;
use App\Models\Category;
use App\Models\SubCategory;
use Carbon\Carbon;
use Image;
use App\Models\MultiImage;
use App\Models\Testominal;


class ProductController extends Controller
{
    public function productadd() {
        $categories = Category::latest()->get();
        $brands = Brand::latest()->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

        return view('backend.product.product_create', compact('categories','brands','testominals'));

    //
}
public function productstore(Request $request){

    $image = $request->file('product_thambnail');
    $name_gen = hexdec(uniqid()).'.'.$image->getClientOriginalExtension();
    Image::make($image)->resize(917,1000)->save('upload/products/thambnail/'.$name_gen);
    $save_url = 'upload/products/thambnail/'.$name_gen;


    $product_id = Product::insertGetId([
      'brand_id' => $request->brand_id,
      'category_id' => $request->category_id,
     'subcategory_id' => $request->subcategory_id,

      'product_name_en' => $request->product_name_en,
      'product_name_ar' => $request->product_name_ar,
      'product_slug_en' =>  strtolower(str_replace(' ', '-', $request->product_name_en)),
      'product_slug_ar' => str_replace(' ', '-', $request->product_name_ar),
      'product_code' => $request->product_code,

      'product_qyt' => $request->product_qyt,
      'product_tag_en' => $request->product_tag_en,
      'product_tag_ar' => $request->product_tag_ar,
      'product_size_en' => $request->product_size_en,
      'product_size_ar' => $request->product_size_ar,


      'selling_price' => $request->selling_price,
      'discount_price' => $request->discount_price,
      'short_desc_en' => $request->short_desc_en,
      'short_desc_ar' => $request->short_desc_ar,
      'long_desc_en' => $request->long_desc_en,
      'long_desc_ar' => $request->long_desc_ar,

      'hot_deals' => $request->hot_deals,
      'feature' => $request->feature,
      'special_offer' => $request->special_offer,
      'special_deal' => $request->special_deal,

      'product_thambnail' => $save_url,
      'status' => 1,
      'created_at' => Carbon::now(),





  ]);
  $images = $request->file('multi_images');
  foreach ($images as $img) {
      $make_name = hexdec(uniqid()).'.'.$img->getClientOriginalExtension();
    Image::make($img)->resize(917,1000)->save('upload/products/multi-image/'.$make_name);
    $uploadPath = 'upload/products/multi-image/'.$make_name;

	MultiImage::insert([

        'product_id' => $product_id,
        'product_photo' => $uploadPath,
        'created_at' => Carbon::now(),

    ]);

  }

  ////////// Een Multiple Image Upload Start ///////////


   $notification = array(
        'message' => 'Product Inserted Successfully',
        'alert-type' => 'success'
    );

    return redirect()->route('manage-product')->with($notification);
}


public function ManageProduct(){

    $products = Product::latest()->get();

    return view('backend.product.product_view',compact('products'));
}
public function EditProduct($id){
	$multiImgs = MultiImage::where('product_id',$id)->get();
    $categories = Category::latest()->get();
    $brands = Brand::latest()->get();
    $subcategory = SubCategory::latest()->get();

    $products = Product::findOrFail($id);
    return view('backend.product.product_edit',compact('categories','brands','subcategory','products','multiImgs'));

}
public function ProductDataUpdate(Request $request){

    $product_id = $request->id;

     Product::findOrFail($product_id)->update([
      'brand_id' => $request->brand_id,
      'category_id' => $request->category_id,
      'subcategory_id' => $request->subcategory_id,
      'product_name_en' => $request->product_name_en,
      'product_name_ar' => $request->product_name_ar,
      'product_slug_en' =>  strtolower(str_replace(' ', '-', $request->product_name_en)),
      'product_slug_ar' => str_replace(' ', '-', $request->product_name_hin),
      'product_code' => $request->product_code,

      'product_qyt' => $request->product_qyt,
      'product_tag_en' => $request->product_tag_en,
      'product_tag_ar' => $request->product_tag_ar,
      'product_size_en' => $request->product_size_en,
      'product_size_ar' => $request->product_size_ar,


      'selling_price' => $request->selling_price,
      'discount_price' => $request->discount_price,
      'short_desc_en' => $request->short_desc_en,
      'short_desc_ar' => $request->short_desc_ar,
      'long_desc_en' => $request->long_desc_en,
      'long_desc_ar' => $request->long_desc_ar,

      'hot_deals' => $request->hot_deals,
      'feature' => $request->feature,
      'special_offer' => $request->special_offer,
      'special_deal' => $request->special_deal,
      'status' => 1,
      'created_at' => Carbon::now(),

  ]);

      $notification = array(
        'message' => 'Product Updated Without Image Successfully',
        'alert-type' => 'success'
    );

    return redirect()->route('manage-product')->with($notification);


} // end method
public function MultiImageUpdate(Request $request){
    $imgs = $request->multi_image;

    foreach ($imgs as $id => $img) {
   // $imgDel = MultiImage::findOrFail($id);
    //unlink($imgDel->product_photo);
    $make_name = hexdec(uniqid()).'.'.$img->getClientOriginalExtension();
    Image::make($img)->resize(917,1000)->save('upload/products/multi-image/'.$make_name);
    $uploadPath = 'upload/products/multi-image/'.$make_name;

    MultiImage::where('id',$id)->update([
        'product_photo' => $uploadPath,
        'updated_at' => Carbon::now(),

    ]);

 } // end foreach

   $notification = array(
        'message' => 'Product Image Updated Successfully',
        'alert-type' => 'info'
    );

    return redirect()->back()->with($notification);

} // end mehtod
public function ThambnailImageUpdate(Request $request){
    $pro_id = $request->id;

     $oldImage = $request->old_img;
     @unlink($oldImage);

   $image = $request->file('product_thambnail');
       $name_gen = hexdec(uniqid()).'.'.$image->getClientOriginalExtension();
       Image::make($image)->resize(917,1000)->save('upload/products/thambnail/'.$name_gen);
       $save_url = 'upload/products/thambnail/'.$name_gen;

       Product::findOrFail($pro_id)->update([
           'product_thambnail' => $save_url,
           'updated_at' => Carbon::now(),

       ]);

        $notification = array(
           'message' => 'Product Image Thambnail Updated Successfully',
           'alert-type' => 'info'
       );

       return redirect()->route('manage-product')->with($notification);
    } // end method


    public function MultiImageDelete($id){

        $oldimg = MultiImage::findOrFail($id);
        @unlink($oldimg->product_photo);
        MultiImage::findOrFail($id)->delete();

        $notification = array(
           'message' => 'Product Image Deleted Successfully',
           'alert-type' => 'success'
       );

       return redirect()->back()->with($notification);

    } // end method
    public function ProductInactive($id){
        Product::findOrFail($id)->update(['status' => 0]);
        $notification = array(
           'message' => 'Product Inactive',
           'alert-type' => 'success'
       );

       return redirect()->back()->with($notification);
    }


 public function ProductActive($id){
     Product::findOrFail($id)->update(['status' => 1]);
        $notification = array(
           'message' => 'Product Active',
           'alert-type' => 'success'
       );

       return redirect()->back()->with($notification);

    }





public function productdelete($id){

    Product::findOrFail($id)->delete();
    $notification = array(
        'message' => 'product Updated Successfully',
        'alert-type' => 'danger'
      );
      return redirect()->back()->with($notification);


}
public function ProductStock(){

    $products = Product::latest()->get();
    return view('backend.product.product_stock',compact('products'));
  }


} // end method



