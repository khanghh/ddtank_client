package mines
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import mines.analyzer.MinesDropAnalyzer;
   import mines.analyzer.MinesLevelAnalyzer;
   import mines.analyzer.ShopDropInfo;
   import mines.analyzer.ShopExchangeInfo;
   import mines.model.MinesModel;
   import road7th.comm.PackageIn;
   
   public class MinesManager extends EventDispatcher
   {
      
      private static var _instance:MinesManager;
      
      public static var INFOLABEL:String = "infoLabel";
      
      public static var UPDATA_SHOP:String = "updataShop";
      
      public static var LEVEL_UP_TOOL:String = "levelUpTool";
      
      public static var LEVEL_UP_ARM:String = "levelUpArm";
       
      
      private var _model:MinesModel;
      
      public var viewOpen:Boolean;
      
      public function MinesManager(param1:inner)
      {
         super();
      }
      
      public static function get instance() : MinesManager
      {
         if(!_instance)
         {
            _instance = new MinesManager(new inner());
         }
         return _instance;
      }
      
      public function get model() : MinesModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new MinesModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(414,1),digHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(414,2),openHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(414,8),shopInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(414,3),levelUpTool);
         SocketManager.Instance.addEventListener(PkgEvent.format(414,6),levelUpArm);
      }
      
      public function checkMinesIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            HallIconManager.instance.updateSwitchHandler("mines",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("mines",true,20);
         }
      }
      
      private function levelUpArm(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.headExp = _loc2_.readInt();
         _model.clothExp = _loc2_.readInt();
         _model.weaponExp = _loc2_.readInt();
         _model.shieldExp = _loc2_.readInt();
         _model.setEquipLevel();
         dispatchEvent(new Event(LEVEL_UP_ARM));
      }
      
      private function levelUpTool(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.toolExp = _loc2_.readInt();
         _loc2_.readInt();
         dispatchEvent(new Event(LEVEL_UP_TOOL));
      }
      
      private function shopInfo(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         _model.shopDropList = new Vector.<ShopDropInfo>();
         _model.shopExchangeList = new Vector.<ShopExchangeInfo>();
         var _loc5_:PackageIn = param1.pkg;
         viewOpen = _loc5_.readBoolean();
         var _loc2_:int = _loc5_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc2_)
         {
            _loc7_ = new ShopDropInfo();
            _loc7_.templateID = _loc5_.readInt();
            _loc7_.price = _loc5_.readInt();
            _loc7_.limitedCount = _loc5_.readInt();
            _model.shopDropList.push(_loc7_);
            _loc8_++;
         }
         var _loc4_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = new ShopExchangeInfo();
            _loc3_.id = _loc5_.readInt();
            _loc3_.activityType = _loc5_.readInt();
            _loc3_.quality = _loc5_.readInt();
            _loc3_.templateID = _loc5_.readInt();
            _loc3_.name = _loc5_.readUTF();
            _loc3_.price = _loc5_.readInt();
            _loc3_.strengthLevel = _loc5_.readInt();
            _loc3_.attackCompose = _loc5_.readInt();
            _loc3_.defendCompose = _loc5_.readInt();
            _loc3_.agilityCompose = _loc5_.readInt();
            _loc3_.luckCompose = _loc5_.readInt();
            _loc3_.isBind = _loc5_.readBoolean();
            _loc3_.validDate = _loc5_.readInt();
            _loc3_.count = _loc5_.readInt();
            _loc5_.readInt();
            _loc5_.readBoolean();
            _loc5_.readBoolean();
            _loc5_.readBoolean();
            _loc3_.position = _loc5_.readInt();
            _loc3_.limitedCount = _loc5_.readInt();
            _model.shopExchangeList.push(_loc3_);
            _loc6_++;
         }
         dispatchEvent(new Event(UPDATA_SHOP));
      }
      
      private function digHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         _loc3_.readInt();
         _model.isFull = _loc3_.readBoolean();
         var _loc2_:Array = [];
         _loc2_[0] = _loc3_.readUTF();
         _loc2_[1] = _loc3_.readInt();
         if(_loc2_[1] != 0 || _model.isFull)
         {
            if(_model.digShowList.length > 9)
            {
               _model.digShowList.shift();
            }
            if(_model.isFull)
            {
               _model.digShowList.push(["",0]);
            }
            else
            {
               _model.digShowList.push(_loc2_);
            }
            dispatchEvent(new Event(INFOLABEL));
         }
      }
      
      private function openHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.toolExp = _loc2_.readInt();
         _model.headExp = _loc2_.readInt();
         _model.clothExp = _loc2_.readInt();
         _model.weaponExp = _loc2_.readInt();
         _model.shieldExp = _loc2_.readInt();
         _model.setEquipLevel();
         show();
      }
      
      private function show() : void
      {
         AssetModuleLoader.addModelLoader("mines",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var _loc1_:* = ClassUtils.CreatInstance("mines.MinesMainFrame");
            LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         });
      }
      
      public function templateDropDataSetup(param1:MinesDropAnalyzer) : void
      {
         if(param1 is MinesDropAnalyzer)
         {
            _model.dropList = param1.list;
         }
      }
      
      public function templateLevelDataSetup(param1:MinesLevelAnalyzer) : void
      {
         if(param1 is MinesLevelAnalyzer)
         {
            _model.toolList = param1.toolList;
            _model.equipList = param1.equipList;
         }
      }
      
      public function getMinesProp() : void
      {
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
