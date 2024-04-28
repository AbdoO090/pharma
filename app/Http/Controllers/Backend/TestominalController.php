<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Testominal;
use Image;

class TestominalController extends Controller
{
    public function TestominalView(){
		$testominals = Testominal::latest()->get();
		return view('backend.testominal.testominlal_view',compact('testominals'));
	}
    public function TestominalStore(Request $request){

    	$request->validate([

    		'testominal_img' => 'required',
    	],[
    		'testominal_img.required' => 'Plz Select One Image',

    	]);

    	$image = $request->file('testominal_img');
    	$name_gen = hexdec(uniqid()).'.'.$image->getClientOriginalExtension();
    	Image::make($image)->save('upload/testominal/'.$name_gen);
    	$save_url = 'upload/testominal/'.$name_gen;

        Testominal::insert([
        'testominal_name' => $request->testominal_name,
		'testominal_title' => $request->testominal_title,
		'testominal_description' => $request->testominal_description,
		'testominal_img' => $save_url,

    	]);

	    $notification = array(
			'message' => 'testominal Inserted Successfully',
			'alert-type' => 'success'
		);

		return redirect()->back()->with($notification);

    } // end method

    public function TestominalEdit($id){
        $testominals = Testominal::findOrFail($id);
            return view('backend.testominal.testominal_edit',compact('testominals'));
        }


    public function TestominalUpdate(Request $request){

            $testominal_id = $request->id;
            $old_img = $request->old_image;

            if ($request->file('testominal_img')) {

            @unlink($old_img);
            $image = $request->file('testominal_img');
            $name_gen = hexdec(uniqid()).'.'.$image->getClientOriginalExtension();
            Image::make($image)->save('upload/testominal/'.$name_gen);
            $save_url = 'upload/testominal/'.$name_gen;

            Testominal::findOrFail($testominal_id)->update([
            'testominal_name' => $request->testominal_name,
		'testominal_title' => $request->testominal_title,
		'testominal_description' => $request->testominal_description,
		'testominal_img' => $save_url,

            ]);

            $notification = array(
                'message' => 'testominal Updated Successfully',
                'alert-type' => 'info'
            );

            return redirect()->route('manage-testominal')->with($notification);

            }else{

                Testominal::findOrFail($testominal_id)->update([
                'testominal_name' => $request->testominal_name,
                'testominal_title' => $request->testominal_title,
                'testominal_description' => $request->testominal_description,
                'testominal_img' => $save_url,


            ]);

            $notification = array(
                'message' => 'testominal Updated Without Image Successfully',
                'alert-type' => 'info'
            );

            return redirect()->route('manage-testominal')->with($notification);

            } // end else
        } // end method
        public function TestominalDelete($id){
            $testominal = Testominal::findOrFail($id);
            $img = $testominal->testominal_img;
            @unlink($img);
            Testominal::findOrFail($id)->delete();

            $notification = array(
                'message' => 'testominal Delectd Successfully',
                'alert-type' => 'info'
            );

            return redirect()->back()->with($notification);

        } // end method
}
