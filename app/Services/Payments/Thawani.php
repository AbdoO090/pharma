<?php
namespace App\Services\Payments;

use Illuminate\Support\Facades\Http;

Class Thawani{


    const TEST_BASE_URL='https://uatcheckout.thawani.om/api/v1' ;
    const LIVE_BASE_URL = 'https://checkout.thawani.om/api/v1';

    protected $secretKey;
    protected $publishableKey;
    protected $baseUrl;
    protected $mode;


    public function __construct($secretKey,$publishableKey,$mode='test')
    {
        $this->mode=$mode;
        $this->secretKey=$secretKey;
        $this->publishableKey=$publishableKey;
        if ($mode=='live'){
            $this->baseUrl=self::LIVE_BASE_URL;
            }else{
                $this->baseUrl=self::TEST_BASE_URL;
                }

    }
    public function CreateCheckoutSession($data){



      $response=  Http::baseUrl($this->baseUrl)->withHeaders([
            'thawani-api-key'=> $this->secretKey,

        ])->asjson()
        ->post('checkout/session',$data);


        $body= $response->json();

        if($body['success']== true && $body['code']==2004){
            return $body['data']['session_id'];
        }


      }



    public function getPayUrl($session_id){
        if($this->mode == 'test'){
            return   "https://uatcheckout.thawani.om/pay/{$session_id}?key={$this->publishableKey}";

        }
        return   "https://checkout.thawani.om/pay/{$session_id}?key={$this->publishableKey}";


}





}



