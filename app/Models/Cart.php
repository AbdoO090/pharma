<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Cart extends Model
{
    use HasFactory;
    protected $fillable = [
        'product_id',
        'user_id',
        'quantity',
        'price',
        'image',
        'name',

    ];
    public function product()
    {
        return $this->belongsTo(Product::class,'product_id','id');
    }

     public function clear()
    {
        if ($this->fireEvent('clearing') === false) {
            return false;
        }

        $this->session->put(
            $this->sessionKeyCartItems,
            array()
        );

        $this->fireEvent('cleared');
        return true;
    }


}
