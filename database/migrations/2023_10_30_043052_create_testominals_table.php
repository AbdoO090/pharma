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
        Schema::create('testominals', function (Blueprint $table) {
            $table->id();
            $table->string('testominal_name')->nullable();
            $table->string('testominal_img')->nullable();
            $table->string('testominal_title')->nullable();
            $table->text('testominal_description')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('testominals');
    }
};
