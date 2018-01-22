package petsBag.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpBtnEnable;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import pet.sprite.PetSpriteManager;
   import petsBag.PetsBagManager;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import petsBag.view.item.FeedItem;
   import road7th.data.DictionaryEvent;
   import road7th.utils.StringHelper;
   import store.HelpFrame;
   
   public class PetsBagOutView extends PetsBagView
   {
       
      
      private var _rePetNameBtn:TextButton;
      
      private var _revertPetBtn:TextButton;
      
      private var _feedItem:FeedItem;
      
      private var _releaseBtn:TextButton;
      
      private var _unFightBtn:TextButton;
      
      private var _petGameSkillPnl:PetGameSkillPnl;
      
      private var _fightSkillLbl:FilterFrameText;
      
      private var _bg2:Bitmap;
      
      private var _feedBtn:TextButton;
      
      private var _groomBtn:SimpleBitmapButton;
      
      public function PetsBagOutView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         removeAllPetCultrueGuilde();
         _bg2 = ComponentFactory.Instance.creat("assets.petsBag.bg1");
         addChild(_bg2);
         _rePetNameBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.rePetName");
         _rePetNameBtn.text = LanguageMgr.GetTranslation("ddt.pets.rePetName");
         addChild(_rePetNameBtn);
         _releaseBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.releaseName");
         _releaseBtn.tipData = LanguageMgr.GetTranslation("ddt.pets.releaseCanTransTipTxt",PetconfigAnalyzer.PetCofnig.HighRemoveStar);
         _releaseBtn.text = LanguageMgr.GetTranslation("ddt.pets.release");
         addChild(_releaseBtn);
         _revertPetBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.revertPet");
         _revertPetBtn.text = LanguageMgr.GetTranslation("ddt.pets.revert");
         addChild(_revertPetBtn);
         _feedItem = ComponentFactory.Instance.creat("petsBag.feedItem");
         addChild(_feedItem);
         _unFightBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.unFight");
         addChild(_unFightBtn);
         _unFightBtn.text = LanguageMgr.GetTranslation("ddt.pets.unfight");
         _petGameSkillPnl = ComponentFactory.Instance.creat("petsBag.petGameSkillPnl");
         addChild(_petGameSkillPnl);
         _petSkillPnl = ComponentFactory.Instance.creat("petsBag.petSkillPnl",[false]);
         addChild(_petSkillPnl);
         _fightSkillLbl = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.fightSkill");
         addChild(_fightSkillLbl);
         _fightSkillLbl.text = LanguageMgr.GetTranslation("ddt.pets.fightSkill");
         _fightBtn.filters = null;
         _fightBtn.mouseChildren = true;
         _fightBtn.mouseEnabled = true;
         _fightBtn.visible = false;
         _unFightBtn.visible = false;
         _feedBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.feed");
         addChild(_feedBtn);
         _feedBtn.text = LanguageMgr.GetTranslation("ddt.pets.feed");
         _groomBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.groom");
         addChild(_groomBtn);
         HelpBtnEnable.getInstance().addMouseOverTips(_groomBtn,30,"ddt.petsBag.isOpen");
         petFarmGuilde();
      }
      
      private function petFarmGuilde() : void
      {
         if(PetsBagManager.instance().haveTaskOrderByID(368))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(95);
            PetsBagManager.instance().showPetFarmGuildArrow(97,50,"farmTrainer.feedPetArrowPos","asset.farmTrainer.feedPet","farmTrainer.feedPetTipPos",this);
         }
         if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] > 0)
         {
            PetsBagManager.instance().showPetFarmGuildArrow(117,30,"farmTrainer.petSkillConfigArrowPos","asset.farmTrainer.petSkillConfig","farmTrainer.petSkillConfigTipPos",this);
         }
      }
      
      private function petCultrueGuilde() : void
      {
      }
      
      private function removeAllPetCultrueGuilde() : void
      {
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _rePetNameBtn.addEventListener("click",__rePetName);
         _releaseBtn.addEventListener("click",__releasePet);
         _revertPetBtn.addEventListener("click",__revertPet);
         _unFightBtn.addEventListener("click",__unFight);
         _fightBtn.addEventListener("click",__fight);
         _feedBtn.addEventListener("click",__feedPet);
         _groomBtn.addEventListener("click",__groomPet);
      }
      
      override protected function __onChange(param1:Event) : void
      {
         super.__onChange(param1);
         switchFightUnFight(_currentPet && !_currentPet.IsEquip);
      }
      
      override public function set infoPlayer(param1:PlayerInfo) : void
      {
         .super.infoPlayer = param1;
         addInfoChangeEvent();
         if(PetsBagManager.instance().petModel.currentPetInfo && PetsBagManager.instance().petModel.currentPetInfo.IsEquip)
         {
            if(PetsBagManager.instance().petModel.currentPetInfo.Hunger / 10000 < 0.5)
            {
               SocketManager.Instance.out.sendPetFightUnFight(PetsBagManager.instance().petModel.currentPetInfo.Place,false);
               PetSpriteManager.Instance.dispatchEvent(new Event("close"));
            }
         }
      }
      
      override public function updatePetBagView() : void
      {
         super.updatePetBagView();
         if(!hasPet)
         {
            this.mouseChildren = true;
            clearInfo();
            _petGameSkillPnl.mouseChildren = false;
            _fightBtn.visible = hasPet;
            _unFightBtn.visible = hasPet;
         }
         else
         {
            switchFightUnFight(_currentPet && !_currentPet.IsEquip);
         }
         updateGameSkill();
         if(_currentPet && _currentPet.GP > 0 && !_currentPet.IsEquip)
         {
            _revertPetBtn.enable = true;
         }
         else
         {
            _revertPetBtn.enable = false;
         }
      }
      
      private function updateGameSkill() : void
      {
         _petGameSkillPnl.pet = PetsBagManager.instance().petModel.currentPetInfo;
      }
      
      private function addInfoChangeEvent() : void
      {
         _infoPlayer.pets.addEventListener("update",__updateInfoChange);
         _infoPlayer.pets.addEventListener("add",__updateInfoChange);
         _infoPlayer.pets.addEventListener("remove",__updateInfoChange);
      }
      
      private function removeInfoChangeEvent() : void
      {
         _infoPlayer.pets.removeEventListener("update",__updateInfoChange);
         _infoPlayer.pets.removeEventListener("add",__updateInfoChange);
         _infoPlayer.pets.removeEventListener("remove",__updateInfoChange);
      }
      
      private function __updateInfoChange(param1:DictionaryEvent) : void
      {
         var _loc2_:PetInfo = param1.data as PetInfo;
         var _loc3_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(_loc2_)
         {
            var _loc4_:* = param1.type;
            if("add" !== _loc4_)
            {
               if("update" !== _loc4_)
               {
                  if("remove" === _loc4_)
                  {
                     _petMoveScroll.refreshPetInfo(_loc2_,2);
                     if(_infoPlayer.pets.length > 0)
                     {
                        PetsBagManager.instance().petModel.currentPetInfo = getFirstPet(_infoPlayer);
                     }
                     else
                     {
                        PetsBagManager.instance().petModel.currentPetInfo = null;
                     }
                  }
               }
               else
               {
                  _petMoveScroll.refreshPetInfo(_loc2_);
                  if(_loc3_ && _loc3_.Place == _loc2_.Place)
                  {
                     PetsBagManager.instance().petModel.currentPetInfo = _loc2_;
                  }
               }
            }
            else
            {
               _petMoveScroll.refreshPetInfo(_loc2_,1);
            }
         }
         updatePetBagView();
      }
      
      private function __rePetName(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:RePetNameFrame = ComponentFactory.Instance.creat("petsBag.rePetNameFrame");
         _loc2_.addEventListener("response",__AlertRePetNameResponse);
         _loc2_.show();
      }
      
      protected function __AlertRePetNameResponse(param1:FrameEvent) : void
      {
         var _loc2_:RePetNameFrame = param1.currentTarget as RePetNameFrame;
         _loc2_.removeEventListener("response",__AlertRePetNameResponse);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(BuriedManager.Instance.checkMoney(_loc2_.selecetItem.isBind,500))
               {
                  _loc2_.dispose();
                  return;
               }
               if(PetsBagManager.instance().petModel.currentPetInfo && _loc2_.petName.length > 0)
               {
                  SocketManager.Instance.out.sendPetRename(PetsBagManager.instance().petModel.currentPetInfo.Place,_loc2_.petName,_loc2_.selecetItem.isBind);
               }
               _loc2_.dispose();
               break;
         }
      }
      
      protected function __revertPet(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pets.revertPetAlertMsg",StringHelper.trim(PetsBagManager.instance().petModel.currentPetInfo.Name)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc2_.addEventListener("response",__alertRevertPet);
         }
      }
      
      protected function __alertRevertPet(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pets.revertPetCostMsg",PetconfigAnalyzer.PetCofnig.RecycleCost),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
               _loc2_.addEventListener("response",__revertPetCostConfirm);
         }
         param1.currentTarget.removeEventListener("response",__alertRevertPet);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function __revertPetCostConfirm(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,PetconfigAnalyzer.PetCofnig.RecycleCost,onCheckComplete2);
         }
         param1.currentTarget.removeEventListener("response",__revertPetCostConfirm);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function onCheckComplete2() : void
      {
         SocketManager.Instance.out.sendRevertPet(_petMoveScroll.currentPage * 5 + _petMoveScroll.selectedIndex,CheckMoneyUtils.instance.isBind);
      }
      
      private function __releasePet(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(_loc2_)
         {
            if(_loc2_.StarLevel >= PetconfigAnalyzer.PetCofnig.NotRemoveStar)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.releaseCannotTxt"));
            }
            else
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.farms.releasePet",StringHelper.trim(PetsBagManager.instance().petModel.currentPetInfo.Name)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc3_.addEventListener("response",__alertReleasePet);
            }
         }
      }
      
      private function __alertReleasePet(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.pets.length == 1 || PlayerManager.Instance.Self.currentPet == PetsBagManager.instance().petModel.currentPetInfo)
               {
                  PetSpriteManager.Instance.dispatchEvent(new Event("close"));
               }
               SocketManager.Instance.out.sendReleasePet(PetsBagManager.instance().petModel.currentPetInfo.Place);
         }
         param1.currentTarget.removeEventListener("response",__alertReleasePet);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __alertReleasePet3(param1:FrameEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               _loc2_ = (param1.currentTarget as SimpleAlert).isBand;
               _loc3_ = PetconfigAnalyzer.PetCofnig.HighRemoveStarCost;
               if(_loc2_ && PlayerManager.Instance.Self.BandMoney >= _loc3_ || PlayerManager.Instance.Self.Money >= _loc3_)
               {
                  if(PlayerManager.Instance.Self.pets.length == 1 || PlayerManager.Instance.Self.currentPet == PetsBagManager.instance().petModel.currentPetInfo)
                  {
                     PetSpriteManager.Instance.dispatchEvent(new Event("close"));
                  }
                  SocketManager.Instance.out.sendReleasePet(PetsBagManager.instance().petModel.currentPetInfo.Place,true,_loc2_);
                  break;
               }
               LeavePageManager.showFillFrame();
               break;
         }
         param1.currentTarget.removeEventListener("response",__alertReleasePet3);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __unFight(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            SocketManager.Instance.out.sendPetFightUnFight(PetsBagManager.instance().petModel.currentPetInfo.Place,false);
         }
         PetSpriteManager.Instance.dispatchEvent(new Event("showPetTip"));
         PetSpriteManager.Instance.dispatchEvent(new Event("close"));
      }
      
      private function __fight(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            SocketManager.Instance.out.sendPetFightUnFight(PetsBagManager.instance().petModel.currentPetInfo.Place);
            if(PetsBagManager.instance().haveTaskOrderByID(368))
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(96);
               PetsBagManager.instance().showPetFarmGuildArrow(97,50,"farmTrainer.feedPetArrowPos","asset.farmTrainer.feedPet","farmTrainer.feedPetTipPos",this);
            }
         }
         PetSpriteManager.Instance.dispatchEvent(new Event("open"));
      }
      
      private function switchFightUnFight(param1:Boolean = true) : void
      {
         _fightBtn.visible = param1;
         _unFightBtn.visible = !param1;
      }
      
      private function __feedPet(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            if(!_feedItem.itemInfo)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.feedNoFood"));
               return;
            }
            if(!isCanFeed(_feedItem.itemInfo))
            {
               return;
            }
            SocketManager.Instance.out.sendPetFeed(_feedItem.itemInfo.Place,_feedItem.itemInfo.BagType,PetsBagManager.instance().petModel.currentPetInfo.Place);
            if(PetsBagManager.instance().haveTaskOrderByID(368))
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(97);
            }
         }
      }
      
      private function isCanFeed(param1:InventoryItemInfo) : Boolean
      {
         var _loc5_:int = needMaxFoods(PetsBagManager.instance().petModel.currentPetInfo.Hunger,int(param1.Property1));
         var _loc3_:int = PetsBagManager.instance().petModel.currentPetInfo.breakGrade;
         switch(int(_loc3_) - 1)
         {
            case 0:
               _loc3_ = 63;
               break;
            case 1:
               _loc3_ = 65;
               break;
            case 2:
               _loc3_ = 68;
               break;
            case 3:
               _loc3_ = 70;
         }
         var _loc2_:int = PlayerManager.Instance.Self.Grade;
         var _loc4_:int = PetsBagManager.instance().petModel.currentPetInfo.Level;
         if(!int(_loc5_))
         {
            if(_loc4_ == _loc3_ || _loc4_ == _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.hungerFull"));
               return false;
            }
            return true;
         }
         if(_loc4_ == _loc3_ || _loc4_ == _loc2_)
         {
            return true;
         }
         return true;
      }
      
      private function needMaxFoods(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = PetconfigAnalyzer.PetCofnig.MaxHunger - param1;
         _loc3_ = Math.ceil(_loc4_ / param2);
         return _loc3_;
      }
      
      public function startShine() : void
      {
         if(!hasPet)
         {
            return;
         }
         _feedItem.startShine();
      }
      
      public function stopShine() : void
      {
         _feedItem.stopShine();
      }
      
      public function clearInfo() : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
         _feedItem.info = null;
      }
      
      private function __help(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("petsBag.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("petsBag.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("ddt.petsBag.readme");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function __groomPet(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PetsAdvancedManager.Instance.addEventListener("petsAdvanceFrameClose",__closeHandler);
         PetsAdvancedManager.Instance.showFrame();
         _showPet.removeDragInfoArea();
      }
      
      private function __closeHandler(param1:Event) : void
      {
         PetsAdvancedManager.Instance.removeEventListener("petsAdvanceFrameClose",__closeHandler);
         if(_showPet)
         {
            _showPet.addDragInfoArea();
         }
      }
      
      private function __addPet_upGrade_evolution_eat(param1:Event) : void
      {
         petCultrueGuilde();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _rePetNameBtn.removeEventListener("click",__rePetName);
         _revertPetBtn.removeEventListener("click",__revertPet);
         _releaseBtn.removeEventListener("click",__releasePet);
         _unFightBtn.removeEventListener("click",__unFight);
         _fightBtn.removeEventListener("click",__fight);
         removeInfoChangeEvent();
         if(_feedBtn)
         {
            _feedBtn.removeEventListener("click",__feedPet);
         }
         _groomBtn.removeEventListener("click",__groomPet);
      }
      
      public function getUnLockItemIndex() : int
      {
         if(_petGameSkillPnl)
         {
            return _petGameSkillPnl.UnLockItemIndex;
         }
         return -1;
      }
      
      override public function dispose() : void
      {
         clearInfo();
         removeEvent();
         removeInfoChangeEvent();
         removeAllPetCultrueGuilde();
         PetsBagManager.instance().petModel.currentPetInfo = null;
         super.dispose();
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
            _bg2 = null;
         }
         if(_fightSkillLbl)
         {
            ObjectUtils.disposeObject(_fightSkillLbl);
            _fightSkillLbl = null;
         }
         if(_petGameSkillPnl)
         {
            ObjectUtils.disposeObject(_petGameSkillPnl);
            _petGameSkillPnl = null;
         }
         if(_unFightBtn)
         {
            ObjectUtils.disposeObject(_unFightBtn);
            _unFightBtn = null;
         }
         if(_releaseBtn)
         {
            ObjectUtils.disposeObject(_releaseBtn);
            _releaseBtn = null;
         }
         if(_feedItem)
         {
            ObjectUtils.disposeObject(_feedItem);
            _feedItem = null;
         }
         if(_rePetNameBtn)
         {
            ObjectUtils.disposeObject(_rePetNameBtn);
            _rePetNameBtn = null;
         }
         if(_revertPetBtn)
         {
            ObjectUtils.disposeObject(_revertPetBtn);
            _revertPetBtn = null;
         }
         if(_feedBtn)
         {
            ObjectUtils.disposeObject(_feedBtn);
            _feedBtn = null;
         }
         if(_groomBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_groomBtn);
            ObjectUtils.disposeObject(_groomBtn);
            _groomBtn = null;
         }
         _groomBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
