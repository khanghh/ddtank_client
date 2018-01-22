package yyvip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import yyvip.view.YYVipMainFrame;
   
   public class YYVipControl extends EventDispatcher
   {
      
      private static var _instance:YYVipControl;
       
      
      public function YYVipControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : YYVipControl
      {
         if(_instance == null)
         {
            _instance = new YYVipControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         YYVipManager.instance.addEventListener("yyvipOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:CEvent) : void
      {
         AssetModuleLoader.addModelLoader("yyvip",6);
         AssetModuleLoader.startCodeLoader(loadCompleteHandler);
      }
      
      private function loadCompleteHandler() : void
      {
         var _loc1_:YYVipMainFrame = ComponentFactory.Instance.creatComponentByStylename("YYVipMainFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function get openViewAwardList() : Vector.<Object>
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = YYVipManager.instance.awardList[YYVipManager.instance.award_id_list[0]] as Array;
         var _loc3_:int = _loc1_.length;
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = {};
            _loc2_.itemInfo = ItemManager.Instance.getTemplateById(_loc1_[_loc5_].TemplateId);
            _loc2_.itemCount = _loc1_[_loc5_].ItemCount;
            _loc4_.push(_loc2_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getDailyLevelVipAwardList(param1:int) : Vector.<Object>
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = YYVipManager.instance.awardList[YYVipManager.instance.award_id_list[param1]] as Array;
         var _loc4_:int = _loc2_.length;
         var _loc5_:Vector.<Object> = new Vector.<Object>();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = {};
            _loc3_.itemInfo = ItemManager.Instance.getTemplateById(_loc2_[_loc6_].TemplateId);
            _loc3_.itemCount = _loc2_[_loc6_].ItemCount;
            _loc5_.push(_loc3_);
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function get dailyViewYearAwardList() : Vector.<Object>
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = YYVipManager.instance.awardList[YYVipManager.instance.award_id_list[8]] as Array;
         var _loc3_:int = _loc1_.length;
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = {};
            _loc2_.itemInfo = ItemManager.Instance.getTemplateById(_loc1_[_loc5_].TemplateId);
            _loc2_.itemCount = _loc1_[_loc5_].ItemCount;
            _loc4_.push(_loc2_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function gotoOpenUrl() : void
      {
      }
   }
}
