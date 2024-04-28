<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Admin;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Auth;
use Image;

class AdminProfileController extends Controller
{
    public function profile(){
        $id = Auth::user()->id;
		$adminData = Admin::find($id);
        return view('admin.admin_profile_view',compact('admindata'));
    }
    public function editprofile(){
        $id = Auth::user()->id;
		$editData = Admin::find($id);
        return view('admin.admin_profile_edit',compact('editdata'));
    }
    public function profile_store(Request $request){
        $id = Auth::user()->id;
		$data = Admin::find($id);
        $data->name=$request->name;
        $data->email=$request->email;

//dd($request);
        if ($request->file('profile_photo')) {
			$file = $request->file('profile_photo');
			@unlink(public_path('upload/admin_images/'.$data->profile_photo_path));
			$filename = date('YmdHi').$file->getClientOriginalName();
			$file->move(public_path('upload/admin_images'),$filename);
			$data['profile_photo'] = $filename;
		}else{

		$file = $request->file('profile_photo');
    	$name_gen = hexdec(uniqid()).'.'.$file->getClientOriginalExtension();
    	Image::make($file)->save('upload/admin_images/'.$name_gen);
    	$save_url = 'upload/admin_images/'.$name_gen;

        }
		$data->save();
        $notification = array(
            'message' => 'Admin Inserted Successfully',
            'alert-type' => 'success'
          );


        return redirect()->route('admin.profile')->with($notification);
        }

    public function change_Password(){
        return view('admin.change_password');
    }
    public function update_pass(Request $request){
        $validatedata=$request->validate([
            'old_password'=>'required',
            'password'=>'required|confirmed'
        ]);
        $hashedPassword=Admin::find(1)->password;

        if (Hash::check($request->old_password,$hashedPassword)){
            $hashedPassword = Auth::user()->password;
            if (Hash::check($request->oldpassword,$hashedPassword)) {

                $admin = Admin::find(Auth::id());
                $admin->password = Hash::make($request->password);
                $admin->save();
                Auth::logout();

        }
        else{
              Session::flash('error','Current Password is Invalid!');
        }
        }
    }
        public function AllUsers(){
            $users = User::latest()->get();
            return view('backend.user.all_users',compact('users'));
        }
}
