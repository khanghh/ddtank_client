package bagAndInfo
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.info.PlayerInfoView;
   import beadSystem.beadSystemManager;
   import cardSystem.data.CardInfo;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.manager.DraftManager;
   import ddt.manager.PlayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import flash.events.Event;
   import petsBag.PetsBagManager;
   import petsBag.view.PetsBagOutView;
   import playerDress.PlayerDressManager;
   import playerDress.event.PlayerDressEvent;
   import texpSystem.controller.TexpManager;
   
   public class BagAndInfoFrame extends Sprite implements Disposeable
   {
       
      
      private var _info:SelfInfo;
      
      public var _infoView:PlayerInfoView;
      
      public var bagView:BagView;
      
      private var _petsView:PetsBagOutView;
      
      private var _beadInfoView:Sprite;
      
      private var _playerDressView:Sprite;
      
      private var _currentType:int;
      
      private var _visible:Boolean = false;
      
      private var _isFirstOpenBead:Boolean = true;
      
      private var _isLoadBeadComplete:Boolean = false;
      
      private var _isLoadStoreComplete:Boolean = false;
      
      public function BagAndInfoFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         bagView = ComponentFactory.Instance.creatCustomObject("bagFrameBagView");
         addChild(bagView);
         _infoView = ComponentFactory.Instance.creatCustomObject("bagAndInfoPersonalInfoView");
         _infoView.showSelfOperation = true;
         addChild(_infoView);
      }
      
      private function initEvents() : void
      {
         bagView.addEventListener("dragStart",__startShine);
         bagView.addEventListener("dragStop",__stopShine);
         bagView.addEventListener("tabChange",__changeHandler);
      }
      
      private function removeEvents() : void
      {
         bagView.removeEventListener("dragStart",__startShine);
         bagView.removeEventListener("dragStop",__stopShine);
         bagView.removeEventListener("tabChange",__changeHandler);
         PlayerDressManager.instance.removeEventListener("dressViewComplete",showPlayerDressView);
      }
      
      public function set isScreenFood(value:Boolean) : void
      {
         bagView.isScreenFood = value;
      }
      
      public function switchShow(type:int, bagtype:int = 0) : void
      {
         info = PlayerManager.Instance.Self;
         _currentType = type;
         bagView.enableOrdisableSB(true);
         bagView.showOrHideSB(true);
         if(type == 0)
         {
            if(TexpManager.Instance.isShow("texpView"))
            {
               TexpManager.Instance.changeVisible("texpView",false);
            }
            if(_petsView)
            {
               _petsView.visible = false;
            }
            _infoView.visible = true;
            if(DraftManager.instance.showDraft)
            {
               bagType = 8;
               bagView.showDressSelectedBtnOnly(true);
            }
            else
            {
               bagType = 0;
            }
            this.bagType = bagtype;
            bagView.isNeedCard(true);
            bagView.tableEnable = true;
            bagView.cardbtnVible = false;
            bagView.sortBagEnable = true;
            bagView.breakBtnEnable = true;
            bagView.sortBagFilter = ComponentFactory.Instance.creatFilters("lightFilter");
            bagView.breakBtnFilter = ComponentFactory.Instance.creatFilters("lightFilter");
            _infoView.visible = bagtype == 8?false:true;
         }
         else if(type == 3)
         {
            _infoView.visible = false;
            bagView.tableEnable = false;
            bagView.isNeedCard(false);
            bagView.cardbtnVible = true;
            bagView.cardbtnFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            bagView.sortBagEnable = false;
            bagView.breakBtnEnable = false;
            bagView.sortBagFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            bagView.breakBtnFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            bagView.enableDressSelectedBtn(false);
            showTexpView();
         }
         else if(type == 5)
         {
            _infoView.visible = false;
            bagView.tableEnable = false;
            bagView.isNeedCard(false);
            bagView.cardbtnVible = true;
            bagView.sortBagEnable = false;
            bagView.breakBtnEnable = false;
            bagView.sortBagFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            bagView.cardbtnFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            bagView.breakBtnFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            bagView.enableDressSelectedBtn(false);
            showPetsView();
         }
         else if(type == 21)
         {
            _infoView.visible = false;
            bagView.isNeedCard(true);
            bagView.tableEnable = true;
            bagView.cardbtnVible = false;
            bagView.sortBagEnable = true;
            bagView.breakBtnEnable = true;
            bagView.sortBagFilter = ComponentFactory.Instance.creatFilters("lightFilter");
            bagView.breakBtnFilter = ComponentFactory.Instance.creatFilters("lightFilter");
            bagType = 21;
            _currentType = 21;
            showBeadInfoView();
            bagView.enableOrdisableSB(false);
         }
      }
      
      public function clearTexpInfo() : void
      {
         if(TexpManager.Instance.isShow("texpView"))
         {
            TexpManager.Instance.cleanInfo();
         }
         if(_petsView)
         {
            _petsView.clearInfo();
         }
      }
      
      private function showTexpView() : void
      {
         if(!TexpManager.Instance.isShow("texpView"))
         {
            TexpManager.Instance.showTexpView("texpView",this);
         }
         if(_petsView)
         {
            _petsView.visible = false;
         }
         bagType = 1;
         TexpManager.Instance.changeVisible("texpView",true);
      }
      
      private function showPetsView() : void
      {
         try
         {
            if(_petsView == null)
            {
               _petsView = ComponentFactory.Instance.creatCustomObject("petsBagOutPnl");
               addChild(_petsView);
            }
            if(TexpManager.Instance.isShow("texpView"))
            {
               TexpManager.Instance.changeVisible("texpView",false);
            }
            bagType = 5;
            _petsView.visible = true;
            _petsView.infoPlayer = PlayerManager.Instance.Self;
            PetsBagManager.instance().view = _petsView;
            return;
         }
         catch(e:Error)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onPetsSmallLoadingClose);
            UIModuleLoader.Instance.addUIModuleImp("petsBag");
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__createPets);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onPetsUIProgress);
            return;
         }
      }
      
      private function __createPets(evt:UIModuleEvent) : void
      {
         if(evt.module == "petsBag")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",__onPetsSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__createPets);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onPetsUIProgress);
            showPetsView();
         }
      }
      
      private function __onPetsSmallLoadingClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onPetsSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__createPets);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onPetsUIProgress);
      }
      
      private function __onPetsUIProgress(event:UIModuleEvent) : void
      {
         if(event.module == "petsBag")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __changeHandler(event:Event) : void
      {
         if(this.bagView.bagType == 21)
         {
            _currentType = 21;
            showBeadInfoView();
            this.bagView.switchButtomVisible(false);
            if(_playerDressView)
            {
               _playerDressView.visible = false;
            }
            return;
         }
         this.bagView.switchButtomVisible(true);
         if(_beadInfoView)
         {
            _beadInfoView.visible = false;
         }
         if(bagView.bagType == 8)
         {
            _currentType = 8;
            PlayerDressManager.instance.addEventListener("dressViewComplete",showPlayerDressView);
            PlayerDressManager.instance.showView(0);
            return;
         }
         if(_playerDressView)
         {
            _playerDressView.visible = false;
         }
         if(_currentType != 2 && _currentType != 5 && _currentType != 3)
         {
            _infoView.switchShow(false);
            _infoView.visible = true;
         }
      }
      
      private function showPlayerDressView(event:PlayerDressEvent) : void
      {
         if(!_playerDressView)
         {
            _playerDressView = event.info;
            addChild(_playerDressView);
         }
         else
         {
            _playerDressView.visible = true;
            _playerDressView["updateModel"]();
         }
         if(_petsView)
         {
            _petsView.visible = false;
         }
         if(TexpManager.Instance.isShow("texpView"))
         {
            TexpManager.Instance.changeVisible("texpView",false);
         }
         if(_infoView)
         {
            _infoView.visible = false;
         }
      }
      
      private function showBeadInfoView() : void
      {
         if(!_beadInfoView)
         {
            beadSystemManager.Instance.addEventListener("createComplete",__onCreateComplete);
            beadSystemManager.Instance.showFrame("mainView");
         }
         else
         {
            _beadInfoView.visible = true;
         }
         if(_petsView)
         {
            _petsView.visible = false;
         }
         if(TexpManager.Instance.isShow("texpView"))
         {
            TexpManager.Instance.changeVisible("texpView",false);
         }
         if(_infoView)
         {
            _infoView.visible = false;
         }
      }
      
      private function __onCreateComplete(e:CEvent) : void
      {
         beadSystemManager.Instance.removeEventListener("createComplete",__onCreateComplete);
         if(e.data.type == "mainView")
         {
            _beadInfoView = e.data.spr;
            addChild(_beadInfoView);
            this.bagView.initBeadButton();
         }
      }
      
      private function __stopShine(event:CellEvent) : void
      {
         _infoView.stopShine();
         if(_beadInfoView)
         {
            _beadInfoView["stopShine"]();
         }
         if(TexpManager.Instance.isShow("texpView"))
         {
            TexpManager.Instance.shine(false);
         }
         if(_petsView)
         {
            _petsView.stopShine();
         }
         if(_petsView)
         {
            _petsView.stopShined(0);
         }
         if(_petsView)
         {
            _petsView.stopShined(1);
         }
         if(_petsView)
         {
            _petsView.stopShined(2);
         }
      }
      
      private function __startShine(event:CellEvent) : void
      {
         var categoryID:* = NaN;
         if(event.data is ItemTemplateInfo)
         {
            categoryID = categoryID;
            if(categoryID == 20 || categoryID == 53 || categoryID == 78)
            {
               if(TexpManager.Instance.isShow("texpView"))
               {
                  TexpManager.Instance.shine(true);
               }
            }
            else if(categoryID == 34)
            {
               if(_petsView)
               {
                  _petsView.startShine();
               }
            }
            else if(categoryID == 50)
            {
               if(_petsView)
               {
                  _petsView.playShined(0);
               }
            }
            else if(categoryID == 52)
            {
               if(_petsView)
               {
                  _petsView.playShined(2);
               }
            }
            else if(categoryID == 51)
            {
               if(_petsView)
               {
                  _petsView.playShined(1);
               }
            }
            else if((event.data as ItemTemplateInfo).Property1 != "31")
            {
               _infoView.startShine(event.data as ItemTemplateInfo);
            }
            else
            {
               _beadInfoView["startShine"](event.data as ItemTemplateInfo);
            }
         }
         else if(event.data is CardInfo)
         {
            _infoView.cardEquipShine(event.data as CardInfo);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(TexpManager.Instance.isShow("texpView"))
         {
            TexpManager.Instance.closeTexpView("texpView");
         }
         ObjectUtils.disposeObject(_beadInfoView);
         _beadInfoView = null;
         bagView.dispose();
         bagView = null;
         _infoView.dispose();
         _infoView = null;
         _info = null;
         if(_petsView)
         {
            _petsView.dispose();
            _petsView = null;
         }
         ObjectUtils.disposeObject(_playerDressView);
         _playerDressView = null;
         PlayerDressManager.instance.disposeView(0);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get info() : SelfInfo
      {
         return _info;
      }
      
      public function set info(value:SelfInfo) : void
      {
         _info = value;
         _infoView.info = value;
         bagView.info = value;
         _infoView.allowLvIconClick();
      }
      
      public function set bagType(value:int) : void
      {
         bagView.setBagType(value);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function get currentType() : int
      {
         return _currentType;
      }
      
      public function checkGuide() : void
      {
         if(_infoView)
         {
            _infoView.checkGuide();
         }
      }
   }
}
