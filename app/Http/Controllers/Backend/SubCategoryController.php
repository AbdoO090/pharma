<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SubCategory;
use App\Models\Category;

class SubCategoryController extends Controller
{
    public function subcategoryView(){
        $categories = Category::orderBy('category_name_en','ASC')->get();

        $subcategories=SubCategory::latest()->get();
        return view('backend.subcategory.subcategory_view',compact('subcategories','categories'));
     }

     public function GetSubCategory($category_id){

        $subcat = SubCategory::where('category_id',$category_id)->orderBy('subcategory_name_en','ASC')->get();
        return json_encode($subcat);
    }

     public function subcategorystore(Request $request){
       $request->validate([
        'category_id' => 'required',
         'subcategory_name_en'=>'required',
         'subcategory_name_ar'=>'required',


       ],[
        'category_id.required'=>'Input category name',
         'subcategory_name_en.required'=>'Input category English Name',
         'subcategory_name_ar.required'=>'Input category Arabic Name',

       ]);


       SubCategory::insert([
        'category_id'=>$request->category_id,
         'subcategory_name_en'=>$request->subcategory_name_en,
         'subcategory_name_ar'=>$request->subcategory_name_ar,
         'subcategory_slug_en'=>strtolower(str_replace(' ', '-',$request->subcategory_name_en)),
         'subcategory_slug_ar'=>str_replace(' ', '-',$request->subcategory_name_ar),


       ]);
       $notification = array(
         'message' => 'subcategory Inserted Successfully',
         'alert-type' => 'success'


       );
       return redirect()->back()->with($notification);
     }
     public function subcategoryedit($id){

        $categories = Category::orderBy('category_name_en','ASC')->get();
         $subcategory=SubCategory::findOrFail($id);
         return view('backend.subcategory.subcategory_edit',compact('subcategory','categories'));
     }
     public function subcategoryupdate(Request $request){


        $subcategory_id=$request->id;

             SubCategory::findOrFail($subcategory_id)->update([
                'category_id'=>$request->category_id,
               'subcategory_name_en'=>$request->subcategory_name_en,
               'subcategory_name_ar'=>$request->subcategory_name_ar,
               'subcategory_slug_en'=>strtolower(str_replace(' ', '-',$request->subcategory_name_en)),
               'subcategory_slug_ar'=>str_replace(' ', '-',$request->subcategory_name_ar),


             ]);
             $notification = array(
               'message' => 'subcategory Updated Successfully',
               'alert-type' => 'info'


             );
             return redirect()->route('all.subcategory')->with($notification);


            }


 public function subcategorydelete($id){

     SubCategory::findOrFail($id)->delete();
     $notification = array(
         'message' => 'subCategory Updated Successfully',
         'alert-type' => 'danger'
       );
       return redirect()->back()->with($notification);


 }
}
