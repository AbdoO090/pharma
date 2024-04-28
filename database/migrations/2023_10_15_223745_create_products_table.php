<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->integer('brand_id');
            $table->integer('category_id');
            $table->integer('subcategory_id');
            $table->string('product_name_en');
            $table->string('product_name_ar');
            $table->string('product_slug_en');
            $table->string('product_slug_ar');
            $table->string('product_code');
            $table->string('product_size_ar')->nullable();
            $table->string('product_size_en')->nullable();
            $table->string('selling_price');
            $table->string('discount_price')->nullable();
            $table->string('short_desc_en');
            $table->string('short_desc_ar');
            $table->string('long_desc_en');
            $table->string('long_desc_ar');
            $table->string('product_thambnail');
            $table->integer('hot_deals')->nullable();
            $table->integer('feature')->nullable();
            $table->integer('special_offer')->nullable();
            $table->integer('special_deal')->nullable();
            $table->integer('status')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
