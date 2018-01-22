package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import store.events.ChoosePanelEvnet;
   import store.events.StoreIIEvent;
   import store.newFusion.view.FusionNewMainView;
   import store.view.Compose.StoreIIComposeBG;
   import store.view.exalt.StoreExaltBG;
   import store.view.strength.StoreIIStrengthBG;
   import store.view.transfer.StoreIITransferBG;
   import trainer.view.NewHandContainer;
   
   public class StoreMainView extends Sprite implements Disposeable
   {
      
      public static const STRENGTH:int = 0;
      
      public static const EXALT:int = 1;
      
      public static const COMPOSE:int = 2;
      
      public static const TRANSF:int = 3;
      
      public static const FUSION:int = 4;
      
      public static const GHOST:int = 7;
       
      
      private var _composePanel:StoreIIComposeBG;
      
      private var _strengthPanel:StoreIIStrengthBG;
      
      private var _newFusionView:FusionNewMainView;
      
      private var _transferPanel:StoreIITransferBG;
      
      private var _exaltPanel:StoreExaltBG;
      
      private var _currentPanelIndex:int;
      
      private var _tabSelectedButtonContainer:VBox;
      
      private var _tabSelectedButtonGroup:SelectedButtonGroup;
      
      private var strength_btn:SelectedButton;
      
      private var compose_btn:SelectedButton;
      
      private var fusion_btn:SelectedButton;
      
      private var embed_btn:SelectedButton;
      
      private var transf_Btn:SelectedButton;
      
      private var _exaltBtn:SelectedButton;
      
      private var bg:ScaleFrameImage;
      
      private var _embedBtn_shine:MovieImage;
      
      private var _disEnabledFilters:Array;
      
      public function StoreMainView()
      {
         super();
         init();
         initEvent();
         setIndex();
      }
      
      private function setIndex() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = _tabSelectedButtonGroup.length();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _tabSelectedButtonGroup.getItemByIndex(_loc3_) as ITipedDisplay;
            if(HelpBtnEnable.getInstance().isForbidden(_loc1_) == false)
            {
               _tabSelectedButtonGroup.selectIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
      }
      
      private function init() : void
      {
         _tabSelectedButtonGroup = new SelectedButtonGroup();
         _tabSelectedButtonContainer = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.TabSelectedBtnContainer");
         bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.MainViewBg");
         addChild(bg);
         strength_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.StrengthenTabBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(strength_btn,5,"tips.open");
         _tabSelectedButtonContainer.addChild(strength_btn);
         _tabSelectedButtonGroup.addSelectItem(strength_btn);
         if(!_disEnabledFilters)
         {
            _disEnabledFilters = [ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ButtonDisenable")];
         }
         _exaltBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.exaltBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_exaltBtn,25,"tips.open");
         _tabSelectedButtonContainer.addChild(_exaltBtn);
         _tabSelectedButtonGroup.addSelectItem(_exaltBtn);
         compose_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.ComposeTabBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(compose_btn,5,"tips.open");
         _tabSelectedButtonContainer.addChild(compose_btn);
         _tabSelectedButtonGroup.addSelectItem(compose_btn);
         transf_Btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.TransferTabBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(transf_Btn,5,"tips.open");
         _tabSelectedButtonContainer.addChild(transf_Btn);
         _tabSelectedButtonGroup.addSelectItem(transf_Btn);
         fusion_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.FusionTabBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(fusion_btn,5,"tips.open");
         _tabSelectedButtonContainer.addChild(fusion_btn);
         _tabSelectedButtonGroup.addSelectItem(fusion_btn);
         _embedBtn_shine = ComponentFactory.Instance.creatComponentByStylename("ddtstore.embed_btnMC");
         addChild(_embedBtn_shine);
         addChild(_tabSelectedButtonContainer);
         _strengthPanel = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBGView");
         _composePanel = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIICompose");
         _transferPanel = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIITransfer");
         _exaltPanel = ComponentFactory.Instance.creatCustomObject("ddtstore.exalt.StoreExaltBG");
         addChild(_strengthPanel);
         _strengthPanel.show();
         addChild(_composePanel);
         addChild(_transferPanel);
         addChild(_exaltPanel);
         var _loc1_:Boolean = false;
         _embedBtn_shine.mouseEnabled = _loc1_;
         _embedBtn_shine.mouseChildren = _loc1_;
         _embedBtn_shine.movie.gotoAndStop(1);
         bg.setFrame(1);
         _tabSelectedButtonContainer.arrange();
         currentPanelIndex = 0;
         changeToTab(currentPanelIndex);
      }
      
      public function changeToConsortiaState() : void
      {
         _strengthPanel.consortiaRate();
      }
      
      public function changeToBaseState() : void
      {
         _strengthPanel.consortiaRate();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
         _tabSelectedButtonGroup.addEventListener("change",__groupChangeHandler);
         strength_btn.addEventListener("click",__strengthClick);
         compose_btn.addEventListener("click",__composeClick);
         fusion_btn.addEventListener("click",__fusionClick);
         transf_Btn.addEventListener("click",__transferClick);
         _exaltBtn.addEventListener("click",__exaltBtnClick);
         _strengthPanel.addEventListener("change",changeHandler);
      }
      
      protected function __exaltBtnClick(param1:MouseEvent) : void
      {
         if(currentPanelIndex == 1)
         {
            return;
         }
         currentPanelIndex = 1;
         changeToTab(currentPanelIndex);
      }
      
      protected function __groupChangeHandler(param1:Event) : void
      {
         _tabSelectedButtonContainer.arrange();
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
         strength_btn.removeEventListener("click",__strengthClick);
         compose_btn.removeEventListener("click",__composeClick);
         fusion_btn.removeEventListener("click",__fusionClick);
         transf_Btn.addEventListener("click",__transferClick);
         _strengthPanel.removeEventListener("change",changeHandler);
         _exaltBtn.removeEventListener("click",__exaltBtnClick);
      }
      
      private function changeHandler(param1:Event) : void
      {
         _embedBtn_shine.movie.gotoAndStop(1);
      }
      
      private function __updateStoreBag(param1:BagEvent) : void
      {
         currentPanel.refreshData(param1.changedSlots);
      }
      
      public function set currentPanelIndex(param1:int) : void
      {
         _currentPanelIndex = param1;
         dispatchEvent(new ChoosePanelEvnet(_currentPanelIndex));
      }
      
      public function get currentPanelIndex() : int
      {
         return _currentPanelIndex;
      }
      
      public function get currentPanel() : IStoreViewBG
      {
         switch(int(this.currentPanelIndex))
         {
            case 0:
               return _strengthPanel;
            case 1:
               return _exaltPanel;
            case 2:
               return _composePanel;
            case 3:
               return _transferPanel;
            case 4:
               if(!_newFusionView)
               {
                  _newFusionView = new FusionNewMainView();
                  PositionUtils.setPos(_newFusionView,"store.newFusion.mainViewPos");
                  addChild(_newFusionView);
               }
               return _newFusionView;
         }
      }
      
      public function get StrengthPanel() : StoreIIStrengthBG
      {
         return _strengthPanel;
      }
      
      private function __strengthClick(param1:MouseEvent) : void
      {
         if(currentPanelIndex == 0)
         {
            return;
         }
         currentPanelIndex = 0;
         if(param1 == null)
         {
            changeToTab(currentPanelIndex,false);
         }
         else
         {
            changeToTab(currentPanelIndex);
         }
      }
      
      private function __composeClick(param1:MouseEvent) : void
      {
         if(currentPanelIndex == 2)
         {
            return;
         }
         currentPanelIndex = 2;
         changeToTab(currentPanelIndex);
      }
      
      public function skipFromWantStrong(param1:int) : void
      {
         currentPanelIndex = param1;
         _tabSelectedButtonGroup.selectIndex = param1;
         changeToTab(currentPanelIndex);
      }
      
      private function __fusionClick(param1:MouseEvent) : void
      {
         if(currentPanelIndex == 4)
         {
            return;
         }
         currentPanelIndex = 4;
         SocketManager.Instance.addEventListener(PkgEvent.format(68,24),__onGetPetsFormInfo);
         SocketManager.Instance.out.sendPetFormInfo();
      }
      
      protected function __onGetPetsFormInfo(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,24),__onGetPetsFormInfo);
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc5_.readInt();
            _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
            PetsAdvancedManager.Instance.formDataList[_loc2_].State = 1;
            PetsAdvancedManager.Instance.formDataList[_loc2_].ShowBtn = 1;
            PetsAdvancedManager.Instance.formDataList[_loc2_].valid = null;
            _loc7_++;
         }
         _loc3_ = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc5_.readInt();
            _loc4_ = _loc5_.readDate();
            if(_loc4_.getTime() < TimeManager.Instance.Now().getTime())
            {
               _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
               PetsAdvancedManager.Instance.formDataList[_loc2_].State = 0;
               PetsAdvancedManager.Instance.formDataList[_loc2_].ShowBtn = 3;
               PetsAdvancedManager.Instance.formDataList[_loc2_].valid = null;
            }
            else
            {
               _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
               PetsAdvancedManager.Instance.formDataList[_loc2_].State = 1;
               PetsAdvancedManager.Instance.formDataList[_loc2_].ShowBtn = 1;
               PetsAdvancedManager.Instance.formDataList[_loc2_].valid = _loc4_;
            }
            _loc7_++;
         }
         changeToTab(currentPanelIndex);
      }
      
      private function __lianhuaClick(param1:MouseEvent) : void
      {
      }
      
      private function __transferClick(param1:MouseEvent) : void
      {
         if(currentPanelIndex == 3)
         {
            return;
         }
         currentPanelIndex = 3;
         changeToTab(currentPanelIndex);
      }
      
      private function changeToTab(param1:int, param2:Boolean = true) : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
         SoundManager.instance.play("008");
         _composePanel.hide();
         _strengthPanel.hide();
         if(_newFusionView)
         {
            _newFusionView.hide();
         }
         _transferPanel.hide();
         _exaltPanel.hide();
         if(currentPanel)
         {
            currentPanel.show();
         }
         bg.setFrame(param1 + 1);
         _embedBtn_shine.movie.gotoAndStop(1);
         judgePointComposeArrow();
         judgePointTransfArrow();
      }
      
      private function judgePointComposeArrow() : void
      {
         var _loc1_:* = null;
         if(currentPanelIndex != 2)
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(75))
            {
               _loc1_ = TaskManager.instance.getQuestByID(566);
               if(TaskManager.instance.isAvailableQuest(_loc1_,true) && !_loc1_.isCompleted)
               {
                  NewHandContainer.Instance.showArrow(13,270,new Point(57,348),"","",LayerManager.Instance.getLayerByType(2));
               }
               TaskManager.instance.checkSendRequestAddQuestDic();
            }
         }
      }
      
      private function judgePointTransfArrow() : void
      {
         var _loc1_:* = null;
         if(currentPanelIndex != 3)
         {
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(88))
            {
               _loc1_ = TaskManager.instance.getQuestByID(351);
               if(TaskManager.instance.isAvailableQuest(_loc1_,true) && !_loc1_.isCompleted)
               {
                  NewHandContainer.Instance.showArrow(13,270,new Point(57,348),"","",LayerManager.Instance.getLayerByType(2));
               }
            }
         }
      }
      
      private function __openAssetManager(param1:MouseEvent) : void
      {
      }
      
      private function sortBtn() : void
      {
         addChild(fusion_btn);
         addChild(transf_Btn);
         addChild(compose_btn);
         addChild(_exaltBtn);
         addChild(strength_btn);
      }
      
      public function shineEmbedBtn() : void
      {
         addChild(_embedBtn_shine);
         _embedBtn_shine.movie.play();
      }
      
      private function embedInfoChangeHandler(param1:StoreIIEvent) : void
      {
         dispatchEvent(new StoreIIEvent("embedInfoChange"));
      }
      
      public function refreshCurrentPanel() : void
      {
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
         _composePanel.hide();
         _strengthPanel.hide();
         if(_newFusionView)
         {
            _newFusionView.hide();
         }
         _transferPanel.hide();
         _exaltPanel.hide();
         if(currentPanel)
         {
            currentPanel.show();
         }
      }
      
      public function deleteSomeDataTemp() : void
      {
         _strengthPanel.hide();
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_composePanel)
         {
            ObjectUtils.disposeObject(_composePanel);
         }
         _composePanel = null;
         if(_strengthPanel)
         {
            ObjectUtils.disposeObject(_strengthPanel);
         }
         _strengthPanel = null;
         ObjectUtils.disposeObject(_newFusionView);
         _newFusionView = null;
         if(_transferPanel)
         {
            ObjectUtils.disposeObject(_transferPanel);
         }
         _transferPanel = null;
         ObjectUtils.disposeObject(_exaltPanel);
         _exaltPanel = null;
         if(_exaltBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_exaltBtn);
            ObjectUtils.disposeObject(_exaltBtn);
         }
         _exaltBtn = null;
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         bg = null;
         if(_tabSelectedButtonContainer)
         {
            _tabSelectedButtonContainer.dispose();
            _tabSelectedButtonContainer = null;
         }
         if(_tabSelectedButtonGroup)
         {
            ObjectUtils.disposeObject(_tabSelectedButtonGroup);
         }
         _tabSelectedButtonGroup = null;
         if(strength_btn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(strength_btn);
            ObjectUtils.disposeObject(strength_btn);
         }
         strength_btn = null;
         if(transf_Btn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(transf_Btn);
            ObjectUtils.disposeObject(transf_Btn);
         }
         transf_Btn = null;
         if(compose_btn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(compose_btn);
            ObjectUtils.disposeObject(compose_btn);
         }
         compose_btn = null;
         if(_embedBtn_shine)
         {
            ObjectUtils.disposeObject(_embedBtn_shine);
         }
         _embedBtn_shine = null;
         if(fusion_btn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(fusion_btn);
            ObjectUtils.disposeObject(fusion_btn);
         }
         fusion_btn = null;
         SocketManager.Instance.out.sendClearStoreBag();
         SocketManager.Instance.out.sendSaveDB();
         TaskManager.instance.addEquipUpdateListener();
         NewHandContainer.Instance.clearArrowByID(13);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
