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
       
      
      public function YYVipControl(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function __onOpenView(event:CEvent) : void
      {
         AssetModuleLoader.addModelLoader("yyvip",6);
         AssetModuleLoader.startCodeLoader(loadCompleteHandler);
      }
      
      private function loadCompleteHandler() : void
      {
         var tmp:YYVipMainFrame = ComponentFactory.Instance.creatComponentByStylename("YYVipMainFrame");
         LayerManager.Instance.addToLayer(tmp,3,true,1);
      }
      
      public function get openViewAwardList() : Vector.<Object>
      {
         var i:int = 0;
         var obj:* = null;
         var tmp:Array = YYVipManager.instance.awardList[YYVipManager.instance.award_id_list[0]] as Array;
         var len:int = tmp.length;
         var tmpList:Vector.<Object> = new Vector.<Object>();
         for(i = 0; i < len; )
         {
            obj = {};
            obj.itemInfo = ItemManager.Instance.getTemplateById(tmp[i].TemplateId);
            obj.itemCount = tmp[i].ItemCount;
            tmpList.push(obj);
            i++;
         }
         return tmpList;
      }
      
      public function getDailyLevelVipAwardList(index:int) : Vector.<Object>
      {
         var i:int = 0;
         var obj:* = null;
         var tmp:Array = YYVipManager.instance.awardList[YYVipManager.instance.award_id_list[index]] as Array;
         var len:int = tmp.length;
         var tmpList:Vector.<Object> = new Vector.<Object>();
         for(i = 0; i < len; )
         {
            obj = {};
            obj.itemInfo = ItemManager.Instance.getTemplateById(tmp[i].TemplateId);
            obj.itemCount = tmp[i].ItemCount;
            tmpList.push(obj);
            i++;
         }
         return tmpList;
      }
      
      public function get dailyViewYearAwardList() : Vector.<Object>
      {
         var i:int = 0;
         var obj:* = null;
         var tmp:Array = YYVipManager.instance.awardList[YYVipManager.instance.award_id_list[8]] as Array;
         var len:int = tmp.length;
         var tmpList:Vector.<Object> = new Vector.<Object>();
         for(i = 0; i < len; )
         {
            obj = {};
            obj.itemInfo = ItemManager.Instance.getTemplateById(tmp[i].TemplateId);
            obj.itemCount = tmp[i].ItemCount;
            tmpList.push(obj);
            i++;
         }
         return tmpList;
      }
      
      public function gotoOpenUrl() : void
      {
      }
   }
}
