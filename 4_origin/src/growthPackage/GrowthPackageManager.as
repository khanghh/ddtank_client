package growthPackage
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import growthPackage.event.GrowthPackageEvent;
   import growthPackage.model.GrowthPackageModel;
   import growthPackage.view.GrowthPackageFrame;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GrowthPackageManager extends EventDispatcher
   {
      
      public static var indexMax:int = 9;
      
      private static var _instance:GrowthPackageManager;
       
      
      private var _model:GrowthPackageModel;
      
      private var growthPackageIsOpen:Boolean;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function GrowthPackageManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : GrowthPackageManager
      {
         if(!_instance)
         {
            _instance = new GrowthPackageManager();
         }
         return _instance;
      }
      
      public function get model() : GrowthPackageModel
      {
         return this._model;
      }
      
      public function setup() : void
      {
         _model = new GrowthPackageModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("growthPackage",__growthPackageHandler);
         model.addEventListener("icon_close",__iconCloseHandler);
      }
      
      private function __growthPackageHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
               updateData(_loc3_);
               break;
            case 1:
               updateData(_loc3_);
               break;
            case 2:
               isOpenHandler(_loc3_);
         }
      }
      
      private function updateData(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         model.isBuy = param1.readInt();
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < indexMax)
         {
            _loc2_.push(param1.readInt());
            _loc3_++;
         }
         model.isCompleteList = _loc2_;
         model.dataChange("dataChange");
      }
      
      private function isOpenHandler(param1:PackageIn) : void
      {
         growthPackageIsOpen = param1.readBoolean();
         showEnterIcon();
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         model.itemInfoList = param1;
      }
      
      private function __iconCloseHandler(param1:GrowthPackageEvent) : void
      {
         disposeEnterIcon();
      }
      
      public function showEnterIcon() : void
      {
         if(model.isShowIcon && growthPackageIsOpen)
         {
            HallIconManager.instance.updateSwitchHandler("growthPackage",true);
         }
         else
         {
            disposeEnterIcon();
         }
      }
      
      public function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("growthPackage",false);
      }
      
      public function onClickIcon(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(model.itemInfoList)
         {
            loadUIModule(showFrame);
         }
         else
         {
            _loc2_ = LoaderCreate.Instance.createActivitySystemItemsLoader();
            _loc2_.addEventListener("complete",__dataLoaderCompleteHandler);
            LoadResourceManager.Instance.startLoad(_loc2_);
         }
      }
      
      private function __dataLoaderCompleteHandler(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader;
         _loc2_.removeEventListener("complete",__dataLoaderCompleteHandler);
         loadUIModule(showFrame);
      }
      
      public function showBuyFrame() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc1_:Number = ServerConfigManager.instance.growthPackagePrice;
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.growthPackage.buyPriceMsg",_loc1_),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2,null,"SimpleAlert",30,true,1);
         _loc2_.addEventListener("response",__onBuyFrameResponse);
      }
      
      private function __onBuyFrameResponse(param1:FrameEvent) : void
      {
         var _loc3_:Number = NaN;
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               _loc3_ = ServerConfigManager.instance.growthPackagePrice;
               CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_loc3_,onCompleteHandler);
         }
         _loc2_.removeEventListener("response",__onBuyFrameResponse);
         ObjectUtils.disposeAllChildren(_loc2_);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.sendGrowthPackageOpen(CheckMoneyUtils.instance.isBind);
      }
      
      public function showFrame() : void
      {
         var _loc1_:GrowthPackageFrame = ComponentFactory.Instance.creatComponentByStylename("GrowthPackageFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("growthPackage");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "growthPackage")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "growthPackage")
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
   }
}
