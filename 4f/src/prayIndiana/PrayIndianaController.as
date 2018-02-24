package prayIndiana
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import prayIndiana.view.PrayIndianaFrame;
   
   public class PrayIndianaController
   {
      
      private static var _instance:PrayIndianaController;
       
      
      private var _pray:PrayIndianaFrame;
      
      public function PrayIndianaController(param1:PrivateClass){super();}
      
      public static function get Instance() : PrayIndianaController{return null;}
      
      public function setup() : void{}
      
      private function __onPrayIndianaDispose(param1:Event) : void{}
      
      private function __onUpdateLottery(param1:Event) : void{}
      
      private function __onUpdateLotteryNumber(param1:Event) : void{}
      
      private function __onPrayIndianaOpenFrame(param1:Event) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
