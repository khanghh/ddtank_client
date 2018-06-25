package godOfWealth
{
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GodOfWealthManager extends EventDispatcher
   {
      
      public static const OPEN_VIEW:String = "gow_open_view";
      
      public static const UPDATE:String = "gow_update";
      
      public static const RESULT_SUC:String = "gow_result_suc";
      
      private static var instance:GodOfWealthManager;
       
      
      private var _nextPayNeeded:int;
      
      private var _nextRewardMin:int;
      
      private var _nextRewardMax:int;
      
      private var _reward:int;
      
      private var _dateEndTime:Number = 0;
      
      private var _btnEnter:MovieClip;
      
      private var _isOpen:Boolean = false;
      
      public function GodOfWealthManager(single:inner)
      {
         super();
      }
      
      public static function getInstance() : GodOfWealthManager
      {
         if(!instance)
         {
            instance = new GodOfWealthManager(new inner());
         }
         return instance;
      }
      
      public function get nextPayNeeded() : int
      {
         return _nextPayNeeded;
      }
      
      public function get nextRewardMin() : int
      {
         return _nextRewardMin;
      }
      
      public function get nextRewardMax() : int
      {
         return _nextRewardMax;
      }
      
      public function get reward() : int
      {
         return _reward;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(341,1),onIsOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(341,2),onPay);
         SocketManager.Instance.addEventListener(PkgEvent.format(341,3),onInfo);
      }
      
      protected function onInfo(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _nextPayNeeded = pkg.readInt();
         _nextRewardMin = pkg.readInt();
         _nextRewardMax = pkg.readInt();
         _dateEndTime = pkg.readDate().time;
         dispatchEvent(new CEvent("gow_update"));
      }
      
      protected function onPay(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _reward = pkg.readInt();
         _nextPayNeeded = pkg.readInt();
         _nextRewardMin = pkg.readInt();
         _nextRewardMax = pkg.readInt();
         if(_reward > 0)
         {
            dispatchEvent(new CEvent("gow_result_suc"));
         }
         dispatchEvent(new CEvent("gow_update"));
      }
      
      protected function onIsOpen(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var isOpen:Boolean = pkg.readBoolean();
         if(isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("godOfWealth.activity.isOpen"));
         }
         else if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("godOfWealth.activity.isClose"));
         }
         _isOpen = isOpen;
         HallIconManager.instance.updateSwitchHandler("godOfWealth",_isOpen);
      }
      
      private function onEnterBtnClick(e:MouseEvent) : void
      {
         show();
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("godOfWealth",6);
         AssetModuleLoader.startCodeLoader(dispatchShow);
      }
      
      private function dispatchShow() : void
      {
         dispatchEvent(new CEvent("gow_open_view"));
      }
      
      public function endTime() : Number
      {
         return _dateEndTime;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
