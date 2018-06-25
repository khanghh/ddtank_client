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
      
      public function PrayIndianaController(pct:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : PrayIndianaController
      {
         if(PrayIndianaController._instance == null)
         {
            PrayIndianaController._instance = new PrayIndianaController(new PrivateClass());
         }
         return PrayIndianaController._instance;
      }
      
      public function setup() : void
      {
         PrayIndianaManager.Instance.addEventListener("prayindianaOpenFrame",__onPrayIndianaOpenFrame);
         PrayIndianaManager.Instance.addEventListener("updateLotterynumber",__onUpdateLotteryNumber);
         PrayIndianaManager.Instance.addEventListener("updatelottery",__onUpdateLottery);
         PrayIndianaManager.Instance.addEventListener("prayindianaDispose",__onPrayIndianaDispose);
      }
      
      private function __onPrayIndianaDispose(evt:Event) : void
      {
         if(_pray != null && PrayIndianaManager.Instance.model.isOpen)
         {
            ObjectUtils.disposeObject(_pray);
            _pray = null;
         }
      }
      
      private function __onUpdateLottery(evt:Event) : void
      {
         if(_pray != null)
         {
            _pray.updateLotteryNumber();
            _pray.goodsJump();
         }
      }
      
      private function __onUpdateLotteryNumber(evt:Event) : void
      {
         if(_pray != null)
         {
            _pray.updateLotteryNumber();
         }
      }
      
      private function __onPrayIndianaOpenFrame(evt:Event) : void
      {
         if(_pray != null)
         {
            ObjectUtils.disposeObject(_pray);
            _pray = null;
         }
         _pray = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaManager.PrayIndianaFrame");
         LayerManager.Instance.addToLayer(_pray,3,true,1);
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
