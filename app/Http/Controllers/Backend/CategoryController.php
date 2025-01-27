<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;


class CategoryController extends Controller
{
    public function categoryView(){
        $categories=Category::latest()->get();
        return view('backend.category.category_view',compact('categories'));
     }

     public function categorystore(Request $request){
       $request->validate([
         'category_name_en'=>'required',
         'category_name_ar'=>'required',
         'category_icon'=>'required',

       ],[
         'category_name_en.required'=>'Input category English Name',
         'category_name_ar.required'=>'Input category Arabic Name',

       ]);


       Category::insert([
         'category_name_en'=>$request->category_name_en,
         'category_name_ar'=>$request->category_name_ar,
         'category_slug_en'=>strtolower(str_replace(' ', '-',$request->category_name_en)),
         'category_slug_ar'=>str_replace(' ', '-',$request->category_name_ar),
         'category_icon'=>$request->category_icon,

       ]);
       $notification = array(
         'message' => 'category Inserted Successfully',
         'alert-type' => 'success'


       );
       return redirect()->back()->with($notification);
     }
     public function categoryedit($id){
         $category=Category::findOrFail($id);
         return view('backend.category.category_edit',compact('category'));
     }
     public function categoryupdate(Request $request){
        $category_id=$request->id;

             Category::findOrFail($category_id)->update([
               'category_name_en'=>$request->category_name_en,
               'category_name_ar'=>$request->category_name_ar,
               'category_slug_en'=>strtolower(str_replace(' ', '-',$request->category_name_en)),
               'category_slug_ar'=>str_replace(' ', '-',$request->category_name_ar),
               'category_icon'=>$request->category_icon,

             ]);
             $notification = array(
               'message' => 'category Updated Successfully',
               'alert-type' => 'info'


             );
             return redirect()->route('all.category')->with($notification);


            }



 public function categorydelete($id){

     Category::findOrFail($id)->delete();
     $notification = array(
         'message' => 'Category Updated Successfully',
         'alert-type' => 'danger'
       );
       return redirect()->back()->with($notification);


 }

}
