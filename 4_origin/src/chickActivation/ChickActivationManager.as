package chickActivation
{
   import chickActivation.model.ChickActivationModel;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class ChickActivationManager extends EventDispatcher
   {
      
      private static var _instance:ChickActivationManager;
      
      public static const CHICKACTIVATION_SHOWFRAME:String = "ChickActivationShowFrame";
       
      
      private var _model:ChickActivationModel;
      
      public function ChickActivationManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ChickActivationManager
      {
         if(_instance == null)
         {
            _instance = new ChickActivationManager();
         }
         return _instance;
      }
      
      public function get model() : ChickActivationModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new ChickActivationModel();
         initData();
         SocketManager.Instance.addEventListener("chickActivation_system",__chickActivationHandler);
      }
      
      private function initData() : void
      {
         var qualityDic:Dictionary = new Dictionary();
         qualityDic["0,0,1"] = 1;
         qualityDic["0,0,2"] = 1;
         qualityDic["0,0,3"] = 1;
         qualityDic["0,0,4"] = 1;
         qualityDic["0,0,5"] = 1;
         qualityDic["0,0,6"] = 1;
         qualityDic["0,0,0"] = 1;
         qualityDic["0,2,5"] = 2;
         qualityDic["0,2,6"] = 2;
         qualityDic["0,2,0"] = 2;
         qualityDic["0,1"] = 3;
         qualityDic["0,3"] = 12;
         qualityDic["1,0,1"] = 101;
         qualityDic["1,0,2"] = 101;
         qualityDic["1,0,3"] = 101;
         qualityDic["1,0,4"] = 101;
         qualityDic["1,0,5"] = 101;
         qualityDic["1,0,6"] = 101;
         qualityDic["1,0,0"] = 101;
         qualityDic["1,2,5"] = 102;
         qualityDic["1,2,6"] = 102;
         qualityDic["1,2,0"] = 102;
         qualityDic["1,1"] = 103;
         _model.qualityDic = qualityDic;
      }
      
      private function __chickActivationHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readInt();
         if(cmd == 1)
         {
            loginDataUpdate(pkg);
         }
         else if(cmd == 2)
         {
            dataUpdate(pkg);
         }
      }
      
      private function loginDataUpdate(pkg:PackageIn) : void
      {
         var i:int = 0;
         model.isKeyOpened = pkg.readInt();
         model.keyIndex = pkg.readInt();
         model.keyOpenedTime = pkg.readDate();
         model.keyOpenedType = pkg.readInt();
         var gainArr:Array = [];
         for(i = 0; i < 12; )
         {
            gainArr.push(pkg.readInt());
            i++;
         }
         model.gainArr = gainArr;
         model.dataChange("updateData");
      }
      
      private function dataUpdate(pkg:PackageIn) : void
      {
         var i:int = 0;
         var g:int = 0;
         model.isKeyOpened = pkg.readInt();
         model.keyIndex = pkg.readInt();
         model.keyOpenedTime = pkg.readDate();
         model.keyOpenedType = pkg.readInt();
         var gainArr:Array = [];
         for(i = 0; i < 12; )
         {
            gainArr.push(pkg.readInt());
            i++;
         }
         var temp1:* = -1;
         if(model.gainArr.length == 12)
         {
            for(g = 0; g < model.gainArr.length - 1; )
            {
               if(model.gainArr[g] != gainArr[g] && gainArr[g] > 0)
               {
                  temp1 = g;
                  break;
               }
               g++;
            }
            if(temp1 != -1)
            {
               model.dataChange("getReward",temp1);
            }
         }
         model.gainArr = gainArr;
         model.dataChange("updateData");
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         model.itemInfoList = dataList;
      }
      
      public function checkShowIcon() : void
      {
         model.isOpen = ServerConfigManager.instance.chickActivationIsOpen;
         HallIconManager.instance.updateSwitchHandler("chickActivation",model.isOpen);
      }
      
      public function showFrame() : void
      {
         var loader:* = null;
         if(model.itemInfoList)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            UIModuleLoader.Instance.addUIModuleImp("chickActivation");
         }
         else
         {
            loader = LoaderCreate.Instance.createActivitySystemItemsLoader();
            loader.addEventListener("complete",__dataLoaderCompleteHandler);
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      private function __dataLoaderCompleteHandler(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.loader;
         loader.removeEventListener("complete",__dataLoaderCompleteHandler);
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("chickActivation");
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "chickActivation")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "chickActivation")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            dispatchEvent(new Event("ChickActivationShowFrame"));
            SocketManager.Instance.out.sendChickActivationQuery();
         }
      }
   }
}
