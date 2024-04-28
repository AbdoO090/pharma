<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Blog\BlogPostCategory;
use App\Models\BlogPost;

use App\Models\Testominal;


class HomeBlogController extends Controller
{
    public function AddBlogPost(){

    	$blogcategory = BlogPostCategory::latest()->get();
    	$blogpost = BlogPost::latest()->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

    	return view('frontend.blog.blog_list',compact('blogpost','blogcategory','testominals'));

    }
    public function DetailsBlogPost($id){

        $blogcategory = BlogPostCategory::latest()->get();
    	$blogpost = BlogPost::findOrFail($id);
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

    	return view('frontend.blog.blog_details',compact('blogpost','blogcategory','testominals'));
    }
    public function HomeBlogCatPost($category_id){

    	$blogcategory = BlogPostCategory::latest()->get();
    	$blogpost = BlogPost::where('category_id',$category_id)->orderBy('id','DESC')->get();
        $testominals = Testominal::orderBy('testominal_name','ASC')->get();

    	return view('frontend.blog.blog_cat_list',compact('blogpost','blogcategory','testominals'));

    } // end mehtod



}
