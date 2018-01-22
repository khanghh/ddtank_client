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
      
      public function ChickActivationManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["0,0,1"] = 1;
         _loc1_["0,0,2"] = 1;
         _loc1_["0,0,3"] = 1;
         _loc1_["0,0,4"] = 1;
         _loc1_["0,0,5"] = 1;
         _loc1_["0,0,6"] = 1;
         _loc1_["0,0,0"] = 1;
         _loc1_["0,2,5"] = 2;
         _loc1_["0,2,6"] = 2;
         _loc1_["0,2,0"] = 2;
         _loc1_["0,1"] = 3;
         _loc1_["0,3"] = 12;
         _loc1_["1,0,1"] = 101;
         _loc1_["1,0,2"] = 101;
         _loc1_["1,0,3"] = 101;
         _loc1_["1,0,4"] = 101;
         _loc1_["1,0,5"] = 101;
         _loc1_["1,0,6"] = 101;
         _loc1_["1,0,0"] = 101;
         _loc1_["1,2,5"] = 102;
         _loc1_["1,2,6"] = 102;
         _loc1_["1,2,0"] = 102;
         _loc1_["1,1"] = 103;
         _model.qualityDic = _loc1_;
      }
      
      private function __chickActivationHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ == 1)
         {
            loginDataUpdate(_loc3_);
         }
         else if(_loc2_ == 2)
         {
            dataUpdate(_loc3_);
         }
      }
      
      private function loginDataUpdate(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         model.isKeyOpened = param1.readInt();
         model.keyIndex = param1.readInt();
         model.keyOpenedTime = param1.readDate();
         model.keyOpenedType = param1.readInt();
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _loc2_.push(param1.readInt());
            _loc3_++;
         }
         model.gainArr = _loc2_;
         model.dataChange("updateData");
      }
      
      private function dataUpdate(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         model.isKeyOpened = param1.readInt();
         model.keyIndex = param1.readInt();
         model.keyOpenedTime = param1.readDate();
         model.keyOpenedType = param1.readInt();
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < 12)
         {
            _loc4_.push(param1.readInt());
            _loc5_++;
         }
         var _loc3_:* = -1;
         if(model.gainArr.length == 12)
         {
            _loc2_ = 0;
            while(_loc2_ < model.gainArr.length - 1)
            {
               if(model.gainArr[_loc2_] != _loc4_[_loc2_] && _loc4_[_loc2_] > 0)
               {
                  _loc3_ = _loc2_;
                  break;
               }
               _loc2_++;
            }
            if(_loc3_ != -1)
            {
               model.dataChange("getReward",_loc3_);
            }
         }
         model.gainArr = _loc4_;
         model.dataChange("updateData");
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         model.itemInfoList = param1;
      }
      
      public function checkShowIcon() : void
      {
         model.isOpen = ServerConfigManager.instance.chickActivationIsOpen;
         HallIconManager.instance.updateSwitchHandler("chickActivation",model.isOpen);
      }
      
      public function showFrame() : void
      {
         var _loc1_:* = null;
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
            _loc1_ = LoaderCreate.Instance.createActivitySystemItemsLoader();
            _loc1_.addEventListener("complete",__dataLoaderCompleteHandler);
            LoadResourceManager.Instance.startLoad(_loc1_);
         }
      }
      
      private function __dataLoaderCompleteHandler(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader;
         _loc2_.removeEventListener("complete",__dataLoaderCompleteHandler);
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("chickActivation");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "chickActivation")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "chickActivation")
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
