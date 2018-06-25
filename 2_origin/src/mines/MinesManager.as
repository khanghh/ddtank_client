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
      
      public function MinesManager(single:inner)
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
      
      private function levelUpArm(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.headExp = pkg.readInt();
         _model.clothExp = pkg.readInt();
         _model.weaponExp = pkg.readInt();
         _model.shieldExp = pkg.readInt();
         _model.setEquipLevel();
         dispatchEvent(new Event(LEVEL_UP_ARM));
      }
      
      private function levelUpTool(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.toolExp = pkg.readInt();
         pkg.readInt();
         dispatchEvent(new Event(LEVEL_UP_TOOL));
      }
      
      private function shopInfo(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         var info1:* = null;
         _model.shopDropList = new Vector.<ShopDropInfo>();
         _model.shopExchangeList = new Vector.<ShopExchangeInfo>();
         var pkg:PackageIn = e.pkg;
         viewOpen = pkg.readBoolean();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            info = new ShopDropInfo();
            info.templateID = pkg.readInt();
            info.price = pkg.readInt();
            info.limitedCount = pkg.readInt();
            _model.shopDropList.push(info);
            i++;
         }
         var count1:int = pkg.readInt();
         for(j = 0; j < count1; )
         {
            info1 = new ShopExchangeInfo();
            info1.id = pkg.readInt();
            info1.activityType = pkg.readInt();
            info1.quality = pkg.readInt();
            info1.templateID = pkg.readInt();
            info1.name = pkg.readUTF();
            info1.price = pkg.readInt();
            info1.strengthLevel = pkg.readInt();
            info1.attackCompose = pkg.readInt();
            info1.defendCompose = pkg.readInt();
            info1.agilityCompose = pkg.readInt();
            info1.luckCompose = pkg.readInt();
            info1.isBind = pkg.readBoolean();
            info1.validDate = pkg.readInt();
            info1.count = pkg.readInt();
            pkg.readInt();
            pkg.readBoolean();
            pkg.readBoolean();
            pkg.readBoolean();
            info1.position = pkg.readInt();
            info1.limitedCount = pkg.readInt();
            _model.shopExchangeList.push(info1);
            j++;
         }
         dispatchEvent(new Event(UPDATA_SHOP));
      }
      
      private function digHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         pkg.readInt();
         _model.isFull = pkg.readBoolean();
         var arr:Array = [];
         arr[0] = pkg.readUTF();
         arr[1] = pkg.readInt();
         if(arr[1] != 0 || _model.isFull)
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
               _model.digShowList.push(arr);
            }
            dispatchEvent(new Event(INFOLABEL));
         }
      }
      
      private function openHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.toolExp = pkg.readInt();
         _model.headExp = pkg.readInt();
         _model.clothExp = pkg.readInt();
         _model.weaponExp = pkg.readInt();
         _model.shieldExp = pkg.readInt();
         _model.setEquipLevel();
         show();
      }
      
      private function show() : void
      {
         AssetModuleLoader.addModelLoader("mines",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var frame:* = ClassUtils.CreatInstance("mines.MinesMainFrame");
            LayerManager.Instance.addToLayer(frame,3,true,1);
         });
      }
      
      public function templateDropDataSetup(analyzer:MinesDropAnalyzer) : void
      {
         if(analyzer is MinesDropAnalyzer)
         {
            _model.dropList = analyzer.list;
         }
      }
      
      public function templateLevelDataSetup(analyzer:MinesLevelAnalyzer) : void
      {
         if(analyzer is MinesLevelAnalyzer)
         {
            _model.toolList = analyzer.toolList;
            _model.equipList = analyzer.equipList;
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
