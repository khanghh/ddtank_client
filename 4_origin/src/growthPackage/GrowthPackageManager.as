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
      
      public function GrowthPackageManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function __growthPackageHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
               updateData(pkg);
               break;
            case 1:
               updateData(pkg);
               break;
            case 2:
               isOpenHandler(pkg);
         }
      }
      
      private function updateData(pkg:PackageIn) : void
      {
         var i:int = 0;
         model.isBuy = pkg.readInt();
         var arr:Array = [];
         for(i = 0; i < indexMax; )
         {
            arr.push(pkg.readInt());
            i++;
         }
         model.isCompleteList = arr;
         model.dataChange("dataChange");
      }
      
      private function isOpenHandler(pkg:PackageIn) : void
      {
         growthPackageIsOpen = pkg.readBoolean();
         showEnterIcon();
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         model.itemInfoList = dataList;
      }
      
      private function __iconCloseHandler(evt:GrowthPackageEvent) : void
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
      
      public function onClickIcon(e:MouseEvent) : void
      {
         var loader:* = null;
         if(model.itemInfoList)
         {
            loadUIModule(showFrame);
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
         loadUIModule(showFrame);
      }
      
      public function showBuyFrame() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var buyPrice:Number = ServerConfigManager.instance.growthPackagePrice;
         var _buyFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.growthPackage.buyPriceMsg",buyPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2,null,"SimpleAlert",30,true,1);
         _buyFrame.addEventListener("response",__onBuyFrameResponse);
      }
      
      private function __onBuyFrameResponse(evt:FrameEvent) : void
      {
         var buyPrice:Number = NaN;
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               buyPrice = ServerConfigManager.instance.growthPackagePrice;
               CheckMoneyUtils.instance.checkMoney(frame.isBand,buyPrice,onCompleteHandler);
         }
         frame.removeEventListener("response",__onBuyFrameResponse);
         ObjectUtils.disposeAllChildren(frame);
         ObjectUtils.disposeObject(frame);
         frame = null;
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.sendGrowthPackageOpen(CheckMoneyUtils.instance.isBind);
      }
      
      public function showFrame() : void
      {
         var frame:GrowthPackageFrame = ComponentFactory.Instance.creatComponentByStylename("GrowthPackageFrame");
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      public function loadUIModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("growthPackage");
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "growthPackage")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "growthPackage")
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
