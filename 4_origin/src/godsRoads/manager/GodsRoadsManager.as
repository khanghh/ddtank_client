package godsRoads.manager
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import godsRoads.analyze.GodsRoadsDataAnalyzer;
   import godsRoads.data.GodsRoadsMissionVo;
   import godsRoads.data.GodsRoadsStepVo;
   import godsRoads.data.GodsRoadsVo;
   import godsRoads.model.GodsRoadsModel;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GodsRoadsManager extends EventDispatcher
   {
      
      private static var _instance:GodsRoadsManager;
      
      public static const GODSROADS_CHANGESTEPS:String = "godsroadschangesteps";
      
      public static const GODSROADS_OPENFRAME:String = "godsroadsopenframe";
      
      public static const GODSROADS_DISPOSE:String = "godsroadsdispose";
       
      
      public var _model:GodsRoadsModel;
      
      private var _isOpen:Boolean = false;
      
      private var _func:Function;
      
      private var _xml:XML;
      
      private var _funcParams:Array;
      
      public var level:int;
      
      public function GodsRoadsManager(param1:PrivateClass)
      {
         _funcParams = [];
         super();
         _model = new GodsRoadsModel();
      }
      
      public static function get instance() : GodsRoadsManager
      {
         if(GodsRoadsManager._instance == null)
         {
            GodsRoadsManager._instance = new GodsRoadsManager(new PrivateClass());
         }
         return GodsRoadsManager._instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("gods_roads",pkgHandler);
      }
      
      public function loadGodsRoadsModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("godsroads");
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "godsroads")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "godsroads")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 86)
         {
            case 0:
               _isOpen = _loc4_.readBoolean();
               if(_isOpen)
               {
                  showGodsRoads();
               }
               else
               {
                  hideGodsRoadsIcon();
               }
               break;
            case 1:
               doOpenGodsRoads(_loc4_);
               break;
            case 2:
               _loc3_ = _loc4_.readBoolean();
               if(_loc3_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.godsRoads.getawards"));
               }
               sendEnter();
         }
      }
      
      public function changeSteps(param1:int) : void
      {
         level = param1;
         dispatchEvent(new Event("godsroadschangesteps"));
      }
      
      public function templateDataSetup(param1:DataAnalyzer) : void
      {
         if(param1 is GodsRoadsDataAnalyzer)
         {
            _model.missionInfo = GodsRoadsDataAnalyzer(param1).dataList;
         }
         dispatchEvent(new Event("XMLdata_Complete"));
      }
      
      public function showGodsRoads() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("godsRoads",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("godsRoads",true,10);
         }
      }
      
      private function hideGodsRoadsIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("godsRoads",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("godsRoads",false);
      }
      
      public function openGodsRoads(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
            return;
         }
         loadGodsRoadsModule(sendEnter);
      }
      
      private function sendEnter() : void
      {
         SocketManager.Instance.out.enterGodsRoads();
      }
      
      private function doOpenGodsRoads(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc11_:* = null;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc13_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:* = null;
         var _loc14_:* = null;
         _model.godsRoadsData = new GodsRoadsVo();
         var _loc8_:GodsRoadsVo = _model.godsRoadsData;
         _loc8_.Level = param1.readInt();
         _loc8_.currentLevel = param1.readInt();
         _loc8_.steps = new Vector.<GodsRoadsStepVo>();
         _loc9_ = 0;
         while(_loc9_ < _loc8_.Level)
         {
            _loc4_ = new GodsRoadsStepVo();
            _loc4_.isGetAwards = param1.readBoolean();
            _loc4_.missionsNum = param1.readInt();
            _loc4_.currentStep = _loc9_ + 1;
            _loc4_.awards = [];
            _loc4_.missionVos = [];
            _loc2_ = 0;
            while(_loc2_ < _loc4_.missionsNum)
            {
               _loc11_ = new GodsRoadsMissionVo();
               _loc11_.ID = param1.readInt();
               _loc11_.isFinished = param1.readBoolean();
               _loc11_.condition1 = param1.readInt();
               _loc11_.condition2 = param1.readInt();
               _loc11_.condition3 = param1.readInt();
               _loc11_.condition4 = param1.readInt();
               _loc11_.isGetAwards = param1.readBoolean();
               _loc11_.awardsNum = param1.readInt();
               _loc11_.awards = [];
               _loc5_ = 0;
               while(_loc5_ < _loc11_.awardsNum)
               {
                  _loc10_ = param1.readInt();
                  _loc13_ = ItemManager.Instance.getTemplateById(_loc10_);
                  _loc7_ = new InventoryItemInfo();
                  ObjectUtils.copyProperties(_loc7_,_loc13_);
                  _loc7_.TemplateID = _loc10_;
                  _loc7_.StrengthenLevel = param1.readInt();
                  _loc7_.Count = param1.readInt();
                  _loc7_.ValidDate = param1.readInt();
                  _loc7_.AttackCompose = param1.readInt();
                  _loc7_.DefendCompose = param1.readInt();
                  _loc7_.AgilityCompose = param1.readInt();
                  _loc7_.LuckCompose = param1.readInt();
                  _loc7_.IsBinds = param1.readBoolean();
                  _loc11_.awards.push(_loc7_);
                  _loc5_++;
               }
               _loc4_.missionVos.push(_loc11_);
               _loc2_++;
            }
            _loc8_.steps.push(_loc4_);
            _loc4_.awadsNum = param1.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc4_.awadsNum)
            {
               _loc12_ = param1.readInt();
               _loc3_ = ItemManager.Instance.getTemplateById(_loc12_);
               _loc14_ = new InventoryItemInfo();
               ObjectUtils.copyProperties(_loc14_,_loc3_);
               _loc14_.TemplateID = _loc12_;
               _loc14_.StrengthenLevel = param1.readInt();
               _loc14_.Count = param1.readInt();
               _loc14_.ValidDate = param1.readInt();
               _loc14_.AttackCompose = param1.readInt();
               _loc14_.DefendCompose = param1.readInt();
               _loc14_.AgilityCompose = param1.readInt();
               _loc14_.LuckCompose = param1.readInt();
               _loc14_.IsBinds = param1.readBoolean();
               _loc4_.awards.push(_loc14_);
               _loc6_++;
            }
            _loc9_++;
         }
         dispatchEvent(new Event("godsroadsopenframe"));
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get XMLData() : XML
      {
         return _xml;
      }
      
      public function set XMLData(param1:XML) : void
      {
         _xml = param1;
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
