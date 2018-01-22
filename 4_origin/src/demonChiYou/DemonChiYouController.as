package demonChiYou
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import demonChiYou.view.DemonChiYouRewardBuyCardFrame;
   import demonChiYou.view.DemonChiYouRewardResultFrame;
   import demonChiYou.view.DemonChiYouRewardSelectFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DemonChiYouController extends EventDispatcher
   {
      
      private static var _instance:DemonChiYouController;
       
      
      private var _mgr:DemonChiYouManager;
      
      private var _rewardSelectFrame:DemonChiYouRewardSelectFrame;
      
      private var _rewardResultFrame:DemonChiYouRewardResultFrame;
      
      private var _rewardBuyCardFrame:DemonChiYouRewardBuyCardFrame;
      
      public function DemonChiYouController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : DemonChiYouController
      {
         if(_instance == null)
         {
            _instance = new DemonChiYouController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _mgr = DemonChiYouManager.instance;
         _mgr.addEventListener("complete",onComplete);
      }
      
      protected function onComplete(param1:Event) : void
      {
         var _loc2_:int = _mgr.frameType;
         if(_loc2_ == 1)
         {
            disposeRewardSelectFrame();
            _rewardSelectFrame = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.DemonChiYouRewardSelectFrame");
            LayerManager.Instance.addToLayer(_rewardSelectFrame,3,true,1);
         }
         else if(_loc2_ == 2)
         {
            disposeRewardResultFrame();
            _rewardResultFrame = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.DemonChiYouRewardResultFrame");
            LayerManager.Instance.addToLayer(_rewardResultFrame,3,true,1);
         }
         else if(_loc2_ == 3)
         {
            disposeRewardBuyCardFrame();
            _rewardBuyCardFrame = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.DemonChiYouRewardBuyCardFrame");
            LayerManager.Instance.addToLayer(_rewardBuyCardFrame,3,true,1);
         }
      }
      
      public function disposeRewardSelectFrame() : void
      {
         if(_rewardSelectFrame)
         {
            _rewardSelectFrame.dispose();
            _rewardSelectFrame = null;
         }
      }
      
      public function disposeRewardResultFrame() : void
      {
         if(_rewardResultFrame)
         {
            _rewardResultFrame.dispose();
            _rewardResultFrame = null;
         }
      }
      
      public function disposeRewardBuyCardFrame() : void
      {
         if(_rewardBuyCardFrame)
         {
            _rewardBuyCardFrame.dispose();
            _rewardBuyCardFrame = null;
         }
      }
   }
}
