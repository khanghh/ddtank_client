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
   import petsBag.view.item.StarBar;
   import road7th.data.DictionaryEvent;
   import road7th.utils.StringHelper;
   import store.HelpFrame;
   
   public class PetsBagOutView extends PetsBagView
   {
       
      
      private var _rePetNameBtn:TextButton;
      
      private var _revertPetBtn:TextButton;
      
      private var _washBoneBtn:TextButton;
      
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
         _washBoneBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.washBonePet");
         _washBoneBtn.text = LanguageMgr.GetTranslation("ddt.pets.washBone");
         addChild(_washBoneBtn);
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
         _washBoneBtn.addEventListener("click",__washBonePet);
         _revertPetBtn.addEventListener("click",__revertPet);
         _unFightBtn.addEventListener("click",__unFight);
         _fightBtn.addEventListener("click",__fight);
         _feedBtn.addEventListener("click",__feedPet);
         _groomBtn.addEventListener("click",__groomPet);
      }
      
      private function __washBonePet(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var curPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(curPet.StarLevel < StarBar.TOTAL_STAR)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.washBone.starEnoughfailtMsg"));
            return;
         }
         var washBoneFrame:PetWashBoneFrame = ComponentFactory.Instance.creat("petsBag.washBoneFrame");
         washBoneFrame.show();
      }
      
      override protected function __onChange(event:Event) : void
      {
         super.__onChange(event);
         switchFightUnFight(_currentPet && !_currentPet.IsEquip);
      }
      
      override public function set infoPlayer(value:PlayerInfo) : void
      {
         .super.infoPlayer = value;
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
      
      private function __updateInfoChange(e:DictionaryEvent) : void
      {
         var updatePetinfo:PetInfo = e.data as PetInfo;
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(updatePetinfo)
         {
            var _loc4_:* = e.type;
            if("add" !== _loc4_)
            {
               if("update" !== _loc4_)
               {
                  if("remove" === _loc4_)
                  {
                     _petMoveScroll.refreshPetInfo(updatePetinfo,2);
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
                  _petMoveScroll.refreshPetInfo(updatePetinfo);
                  if(currentPet && currentPet.Place == updatePetinfo.Place)
                  {
                     PetsBagManager.instance().petModel.currentPetInfo = updatePetinfo;
                  }
               }
            }
            else
            {
               _petMoveScroll.refreshPetInfo(updatePetinfo,1);
            }
         }
         updatePetBagView();
      }
      
      private function __rePetName(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var alertRePetName:RePetNameFrame = ComponentFactory.Instance.creat("petsBag.rePetNameFrame");
         alertRePetName.addEventListener("response",__AlertRePetNameResponse);
         alertRePetName.show();
      }
      
      protected function __AlertRePetNameResponse(evt:FrameEvent) : void
      {
         var alert:RePetNameFrame = evt.currentTarget as RePetNameFrame;
         alert.removeEventListener("response",__AlertRePetNameResponse);
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               if(BuriedManager.Instance.checkMoney(alert.selecetItem.isBind,500))
               {
                  alert.dispose();
                  return;
               }
               if(PetsBagManager.instance().petModel.currentPetInfo && alert.petName.length > 0)
               {
                  SocketManager.Instance.out.sendPetRename(PetsBagManager.instance().petModel.currentPetInfo.Place,alert.petName,alert.selecetItem.isBind);
               }
               alert.dispose();
               break;
         }
      }
      
      protected function __revertPet(event:MouseEvent) : void
      {
         var alertAsk:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pets.revertPetAlertMsg",StringHelper.trim(PetsBagManager.instance().petModel.currentPetInfo.Name)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alertAsk.addEventListener("response",__alertRevertPet);
         }
      }
      
      protected function __alertRevertPet(event:FrameEvent) : void
      {
         var alertAsk:* = null;
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pets.revertPetCostMsg",PetconfigAnalyzer.PetCofnig.RecycleCost),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
               alertAsk.addEventListener("response",__revertPetCostConfirm);
         }
         event.currentTarget.removeEventListener("response",__alertRevertPet);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      protected function __revertPetCostConfirm(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(alert.isBand,PetconfigAnalyzer.PetCofnig.RecycleCost,onCheckComplete2);
         }
         event.currentTarget.removeEventListener("response",__revertPetCostConfirm);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      protected function onCheckComplete2() : void
      {
         SocketManager.Instance.out.sendRevertPet(_petMoveScroll.currentPage * 5 + _petMoveScroll.selectedIndex,CheckMoneyUtils.instance.isBind);
      }
      
      private function __releasePet(e:MouseEvent) : void
      {
         var alertAsk:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpPetInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(tmpPetInfo)
         {
            if(tmpPetInfo.StarLevel >= PetconfigAnalyzer.PetCofnig.NotRemoveStar)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.releaseCannotTxt"));
            }
            else
            {
               alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.farms.releasePet",StringHelper.trim(PetsBagManager.instance().petModel.currentPetInfo.Name)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               alertAsk.addEventListener("response",__alertReleasePet);
            }
         }
      }
      
      private function __alertReleasePet(event:FrameEvent) : void
      {
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.pets.length == 1 || PlayerManager.Instance.Self.currentPet == PetsBagManager.instance().petModel.currentPetInfo)
               {
                  PetSpriteManager.Instance.dispatchEvent(new Event("close"));
               }
               SocketManager.Instance.out.sendReleasePet(PetsBagManager.instance().petModel.currentPetInfo.Place);
         }
         event.currentTarget.removeEventListener("response",__alertReleasePet);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __alertReleasePet3(event:FrameEvent) : void
      {
         var tmpIsBind:Boolean = false;
         var tmpNeedMoney:int = 0;
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               tmpIsBind = (event.currentTarget as SimpleAlert).isBand;
               tmpNeedMoney = PetconfigAnalyzer.PetCofnig.HighRemoveStarCost;
               if(tmpIsBind && PlayerManager.Instance.Self.BandMoney >= tmpNeedMoney || PlayerManager.Instance.Self.Money >= tmpNeedMoney)
               {
                  if(PlayerManager.Instance.Self.pets.length == 1 || PlayerManager.Instance.Self.currentPet == PetsBagManager.instance().petModel.currentPetInfo)
                  {
                     PetSpriteManager.Instance.dispatchEvent(new Event("close"));
                  }
                  SocketManager.Instance.out.sendReleasePet(PetsBagManager.instance().petModel.currentPetInfo.Place,true,tmpIsBind);
                  break;
               }
               LeavePageManager.showFillFrame();
               break;
         }
         event.currentTarget.removeEventListener("response",__alertReleasePet3);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __unFight(e:MouseEvent) : void
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
      
      private function __fight(e:MouseEvent) : void
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
      
      private function switchFightUnFight(bool:Boolean = true) : void
      {
         _fightBtn.visible = bool;
         _unFightBtn.visible = !bool;
      }
      
      private function __feedPet(e:MouseEvent) : void
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
      
      private function isCanFeed(_info:InventoryItemInfo) : Boolean
      {
         var needMaxFood:int = needMaxFoods(PetsBagManager.instance().petModel.currentPetInfo.Hunger,int(_info.Property1));
         var breakGrade:int = PetsBagManager.instance().petModel.currentPetInfo.breakGrade;
         switch(int(breakGrade) - 1)
         {
            case 0:
               breakGrade = 63;
               break;
            case 1:
               breakGrade = 65;
               break;
            case 2:
               breakGrade = 68;
               break;
            case 3:
               breakGrade = 70;
         }
         var playerGrade:int = PlayerManager.Instance.Self.Grade;
         var petsLevel:int = PetsBagManager.instance().petModel.currentPetInfo.Level;
         if(!int(needMaxFood))
         {
            if(petsLevel == breakGrade || petsLevel == playerGrade)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.hungerFull"));
               return false;
            }
            return true;
         }
         if(petsLevel == breakGrade || petsLevel == playerGrade)
         {
            return true;
         }
         return true;
      }
      
      private function needMaxFoods(hunger:int, addHunger:int) : int
      {
         var maxFood:int = 0;
         var limitHunger:int = PetconfigAnalyzer.PetCofnig.MaxHunger - hunger;
         maxFood = Math.ceil(limitHunger / addHunger);
         return maxFood;
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
      
      private function __help(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("petsBag.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("petsBag.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("ddt.petsBag.readme");
         LayerManager.Instance.addToLayer(helpPage,1,true,1);
      }
      
      private function __groomPet(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PetsAdvancedManager.Instance.addEventListener("petsAdvanceFrameClose",__closeHandler);
         PetsAdvancedManager.Instance.showFrame();
         _showPet.removeDragInfoArea();
      }
      
      private function __closeHandler(evt:Event) : void
      {
         PetsAdvancedManager.Instance.removeEventListener("petsAdvanceFrameClose",__closeHandler);
         if(_showPet)
         {
            _showPet.addDragInfoArea();
         }
      }
      
      private function __addPet_upGrade_evolution_eat(e:Event) : void
      {
         petCultrueGuilde();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _rePetNameBtn.removeEventListener("click",__rePetName);
         _revertPetBtn.removeEventListener("click",__revertPet);
         _washBoneBtn.removeEventListener("click",__washBonePet);
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
         ObjectUtils.disposeObject(_washBoneBtn);
         _washBoneBtn = null;
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
