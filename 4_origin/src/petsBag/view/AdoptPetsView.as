package petsBag.view
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import farm.control.FarmComposeHouseController;
   import farm.viewx.newPet.NewPetViewFrame;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingBless.KingBlessManager;
   import pet.data.PetInfo;
   import pet.data.PetSkill;
   import pet.data.PetTemplateInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.AdoptItemInfo;
   import petsBag.event.PetItemEvent;
   import petsBag.view.item.AdoptItem;
   import road7th.comm.PackageIn;
   
   public class AdoptPetsView extends Frame
   {
       
      
      private var _adoptBtn:SimpleBitmapButton;
      
      private var _adoptItemBtn:SimpleBitmapButton;
      
      private var _refreshBtn:TextButton;
      
      private var _listView:SimpleTileList;
      
      private var _petsImgVec:Vector.<AdoptItem>;
      
      public var currentPet:AdoptItem;
      
      private var _refreshTimerTxt:FilterFrameText;
      
      private var _titleBg:DisplayObject;
      
      private var _bg2:DisplayObject;
      
      private var _refreshTimer:Timer;
      
      private var _refreshVolumeImg:Bitmap;
      
      private var _refreshVolumeTxt:FilterFrameText;
      
      private var _refreshVolumeTxtBG:Scale9CornerImage;
      
      private var _refreshVolumeTip:StripTip;
      
      private var _newPetView:NewPetViewFrame;
      
      private var _refreshPetPnl:RefreshPetAlertFrame;
      
      private var _isband:Boolean;
      
      public function AdoptPetsView()
      {
         super();
         _petsImgVec = new Vector.<AdoptItem>();
         initView();
         initEvent();
         escEnable = true;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         SocketManager.Instance.out.sendRefreshPet();
         updateTimer(FarmComposeHouseController.instance().getNextUpdatePetTimes());
         updateRefreshVolume();
         if(PetsBagManager.instance().haveTaskOrderByID(367))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(91);
            PetsBagManager.instance().showPetFarmGuildArrow(92,-150,"farmTrainer.selectPetArrowPos","asset.farmTrainer.clickHere","farmTrainer.selectPetTipPos",this);
         }
      }
      
      private function initView() : void
      {
         _bg2 = ComponentFactory.Instance.creat("farm.adoptPetsView.bg2");
         addToContent(_bg2);
         _titleBg = ComponentFactory.Instance.creat("assets.farm.adoptPets");
         addChild(_titleBg);
         _adoptBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.adopt");
         addToContent(_adoptBtn);
         _adoptItemBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.adoptItem");
         _adoptItemBtn.visible = false;
         addToContent(_adoptItemBtn);
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.refresh");
         addToContent(_refreshBtn);
         _refreshTimerTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.adoptRefreshTimer");
         addToContent(_refreshTimerTxt);
         _refreshVolumeTxtBG = ComponentFactory.Instance.creatComponentByStylename("farmHouse.adoptRefreshVolumeTxtBG");
         addToContent(_refreshVolumeTxtBG);
         _listView = ComponentFactory.Instance.creatCustomObject("farm.simpleTileList.petAdop",[4]);
         addToContent(_listView);
         _refreshVolumeImg = ComponentFactory.Instance.creatBitmap("assets.farm.petRefreshVolumeImg");
         addToContent(_refreshVolumeImg);
         _refreshVolumeTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.adoptRefreshVolumeTxt");
         addToContent(_refreshVolumeTxt);
         _refreshVolumeTip = ComponentFactory.Instance.creat("farm.refreshVolumeStripTip");
         addToContent(_refreshVolumeTip);
         _refreshVolumeTip.setView(_refreshVolumeImg);
         _refreshVolumeTip.tipData = LanguageMgr.GetTranslation("ddt.farms.petRefreshVolume");
         _refreshVolumeTip.width = _refreshVolumeImg.width;
         _refreshVolumeTip.height = _refreshVolumeImg.height;
         _refreshTimer = new Timer(60000);
         _refreshTimer.start();
         updateAdoptBtnStatus();
         refreshPetBtn(null);
      }
      
      private function update(pets:Array, items:Array) : void
      {
         var petIcon:* = null;
         if(pets && pets.length >= 1)
         {
            removeItem();
            var _loc6_:int = 0;
            var _loc5_:* = pets;
            for each(var petInfo in pets)
            {
               petIcon = ComponentFactory.Instance.creat("farm.petAdoptItem",[petInfo]);
               _petsImgVec.push(petIcon);
            }
         }
         updateItems(items);
         currentPet = null;
         addItem();
         updateAdoptBtnStatus();
      }
      
      private function updateRefreshVolume() : void
      {
         _refreshVolumeTxt.text = FarmComposeHouseController.instance().refreshVolume();
      }
      
      public function updateTimer(timeStr:String) : void
      {
         _refreshTimerTxt.text = timeStr;
      }
      
      private function addItem() : void
      {
         var index:int = 0;
         for(index = 0; index < _petsImgVec.length; )
         {
            _petsImgVec[index].addEventListener("itemclick",__petItemClick);
            _listView.addChild(_petsImgVec[index]);
            index++;
         }
      }
      
      private function updateAdoptBtnStatus() : void
      {
         var _loc1_:* = _petsImgVec.length > 0 && currentPet?true:false;
         _adoptBtn.enable = _loc1_;
         _adoptItemBtn.enable = _loc1_;
         if(currentPet)
         {
            _adoptItemBtn.visible = currentPet.isGoodItem;
            _adoptBtn.visible = !currentPet.isGoodItem;
         }
         _refreshBtn.enable = true;
      }
      
      private function removeItem() : void
      {
         var index:int = 0;
         for(index = 0; index < _petsImgVec.length; )
         {
            _petsImgVec[index].removeEventListener("itemclick",__petItemClick);
            _petsImgVec[index].dispose();
            _petsImgVec[index] = null;
            index++;
         }
         _petsImgVec.splice(0,_petsImgVec.length);
      }
      
      private function removeItemByPetInfo(petInfo:PetInfo) : void
      {
         var index:int = 0;
         for(index = 0; index < _petsImgVec.length; )
         {
            if(_petsImgVec[index].info)
            {
               if(_petsImgVec[index].info.TemplateID == petInfo.TemplateID && _petsImgVec[index].info.Place == petInfo.Place)
               {
                  _petsImgVec[index].removeEventListener("itemclick",__petItemClick);
                  _petsImgVec[index].dispose();
                  _petsImgVec[index] = null;
                  _petsImgVec.splice(index,1);
                  PetsBagManager.instance().petModel.adoptPets.remove(petInfo.Place);
                  break;
               }
            }
            index++;
         }
      }
      
      private function removeItemByPlace(place:int) : void
      {
         var index:int = 0;
         for(index = 0; index < _petsImgVec.length; )
         {
            if(_petsImgVec[index].itemInfo && place == _petsImgVec[index].place)
            {
               _petsImgVec[index].removeEventListener("itemclick",__petItemClick);
               _petsImgVec[index].dispose();
               _petsImgVec[index] = null;
               _petsImgVec.splice(index,1);
               PetsBagManager.instance().petModel.adoptItems.remove(place);
               break;
            }
            index++;
         }
      }
      
      private function __petItemClick(e:PetItemEvent) : void
      {
         SoundManager.instance.play("008");
         currentPet = e.data as AdoptItem;
         if(currentPet)
         {
            setSelectUnSelect(currentPet);
         }
         updateAdoptBtnStatus();
         if(PetsBagManager.instance().haveTaskOrderByID(367))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(92);
            PetsBagManager.instance().showPetFarmGuildArrow(93,-150,"farmTrainer.adoptPetArrowPos","asset.farmTrainer.clickHere","farmTrainer.adoptPetTipPos",this);
         }
      }
      
      private function setSelectUnSelect(currentPetItem:AdoptItem, select:Boolean = false) : void
      {
         var index:int = 0;
         for(index = 0; index < _petsImgVec.length; )
         {
            if(_petsImgVec[index] && _petsImgVec[index] != currentPetItem)
            {
               _petsImgVec[index].isSelect = select;
            }
            index++;
         }
      }
      
      private function initEvent() : void
      {
         _adoptBtn.addEventListener("click",__adoptPet);
         _adoptItemBtn.addEventListener("click",__adoptPet);
         _refreshBtn.addEventListener("click",__refreshPet);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,5),__updateRefreshPet);
         addEventListener("response",__responseHandler);
         _refreshTimer.addEventListener("timer",__refreshUpdatePet);
         PlayerManager.Instance.Self.getBag(1).addEventListener("update",__bagUpdate);
         KingBlessManager.instance.addEventListener("update_buff_data_event",refreshPetBtn);
      }
      
      private function refreshPetBtn(event:Event) : void
      {
         var freeCount:int = KingBlessManager.instance.getOneBuffData(2);
         if(freeCount > 0)
         {
            _refreshBtn.text = LanguageMgr.GetTranslation("ddt.farms.petFreeRefresh",freeCount);
            PositionUtils.setPos(_refreshBtn,"assets.farm.petFreeRefreshPos");
         }
         else
         {
            _refreshBtn.text = LanguageMgr.GetTranslation("ddt.farms.refresh");
            PositionUtils.setPos(_refreshBtn,"assets.farm.petRefreshPos");
         }
      }
      
      private function __bagUpdate(event:Event) : void
      {
         updateRefreshVolume();
      }
      
      private function __refreshUpdatePet(e:TimerEvent) : void
      {
         updateTimer(FarmComposeHouseController.instance().getNextUpdatePetTimes());
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __updateRefreshPet(e:PkgEvent) : void
      {
         var place:int = 0;
         var ptid:int = 0;
         var p:* = null;
         var skillCount:int = 0;
         var k:int = 0;
         var petskill:* = null;
         var skillid:int = 0;
         var i:int = 0;
         var j:int = 0;
         var item:* = null;
         var pkg:PackageIn = e.pkg;
         var isUpdate:Boolean = pkg.readBoolean();
         var count:int = pkg.readInt();
         PetsBagManager.instance().petModel.adoptPets.clear();
         for(i = 0; i < count; )
         {
            if(isUpdate)
            {
               place = pkg.readInt();
               ptid = pkg.readInt();
               p = new PetInfo();
               p.TemplateID = ptid;
               PetInfoManager.fillPetInfo(p);
               p.Name = pkg.readUTF();
               p.Attack = pkg.readInt();
               p.Defence = pkg.readInt();
               p.Luck = pkg.readInt();
               p.Agility = pkg.readInt();
               p.Blood = pkg.readInt();
               p.Damage = pkg.readInt();
               p.Guard = pkg.readInt();
               p.AttackGrow = pkg.readInt();
               p.DefenceGrow = pkg.readInt();
               p.LuckGrow = pkg.readInt();
               p.AgilityGrow = pkg.readInt();
               p.BloodGrow = pkg.readInt();
               p.DamageGrow = pkg.readInt();
               p.GuardGrow = pkg.readInt();
               p.Level = pkg.readInt();
               p.GP = pkg.readInt();
               p.MaxGP = pkg.readInt();
               p.Hunger = pkg.readInt();
               p.MP = pkg.readInt();
               skillCount = pkg.readInt();
               for(k = 0; k < skillCount; )
               {
                  skillid = pkg.readInt();
                  petskill = new PetSkill(skillid);
                  p.addSkill(petskill);
                  pkg.readInt();
                  k++;
               }
               p.MaxActiveSkillCount = pkg.readInt();
               p.MaxStaticSkillCount = pkg.readInt();
               p.MaxSkillCount = pkg.readInt();
               p.Place = place;
               if(p.Place != -1)
               {
                  PetsBagManager.instance().petModel.adoptPets.add(p.Place,p);
               }
               else
               {
                  PetsBagManager.instance().newPetInfo = p;
               }
            }
            else
            {
               place = pkg.readInt();
               ptid = pkg.readInt();
               p = new PetInfo();
               p.TemplateID = ptid;
               PetInfoManager.fillPetInfo(p);
               p.Name = pkg.readUTF();
               p.Attack = pkg.readInt();
               p.Defence = pkg.readInt();
               p.Luck = pkg.readInt();
               p.Agility = pkg.readInt();
               p.Blood = pkg.readInt();
               p.Damage = pkg.readInt();
               p.Guard = pkg.readInt();
               p.AttackGrow = pkg.readInt();
               p.DefenceGrow = pkg.readInt();
               p.LuckGrow = pkg.readInt();
               p.AgilityGrow = pkg.readInt();
               p.BloodGrow = pkg.readInt();
               p.DamageGrow = pkg.readInt();
               p.GuardGrow = pkg.readInt();
               p.Level = pkg.readInt();
               p.GP = pkg.readInt();
               p.MaxGP = pkg.readInt();
               p.Hunger = pkg.readInt();
               p.MP = pkg.readInt();
               skillCount = pkg.readInt();
               for(k = 0; k < skillCount; )
               {
                  skillid = pkg.readInt();
                  petskill = new PetSkill(skillid);
                  p.addSkill(petskill);
                  pkg.readInt();
                  k++;
               }
               p.MaxActiveSkillCount = pkg.readInt();
               p.MaxStaticSkillCount = pkg.readInt();
               p.MaxSkillCount = pkg.readInt();
               p.Place = place;
               if(p.Place != -1)
               {
                  PetsBagManager.instance().petModel.adoptPets.add(p.Place,p);
               }
               else
               {
                  PetsBagManager.instance().newPetInfo = p;
               }
            }
            i++;
         }
         PetsBagManager.instance().petModel.adoptItems.clear();
         count = pkg.readInt();
         for(j = 0; j < count; )
         {
            item = new AdoptItemInfo();
            item.place = pkg.readInt();
            item.itemTemplateId = pkg.readInt();
            item.itemAmount = pkg.readInt();
            PetsBagManager.instance().petModel.adoptItems.add(item.place,item);
            j++;
         }
         update(PetsBagManager.instance().petModel.adoptPets.list,PetsBagManager.instance().petModel.adoptItems.list);
         if(!_newPetView)
         {
            _newPetView = ComponentFactory.Instance.creatComponentByStylename("farm.newPetViewFrame");
            _newPetView.petInfo = PetsBagManager.instance().newPetInfo;
            _newPetView.addEventListener("newPetFrameClose",__onNewPetFrameClose);
            addChild(_newPetView);
            this.setChildIndex(_newPetView,0);
         }
      }
      
      private function __onNewPetFrameClose(pEvent:Event) : void
      {
         _newPetView.removeEventListener("newPetFrameClose",__onNewPetFrameClose);
         TweenMax.to(this,0.2,{"x":255});
      }
      
      private function updateItems(items:Array) : void
      {
         var item:* = null;
         if(!items || items.length < 1)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for each(var info in items)
         {
            item = ComponentFactory.Instance.creat("farm.petAdoptItem",[null]);
            item.itemAmount = info.itemAmount;
            item.place = info.place;
            item.itemTemplateId = info.itemTemplateId;
            _petsImgVec.push(item);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _adoptBtn.removeEventListener("click",__adoptPet);
         _adoptItemBtn.removeEventListener("click",__adoptPet);
         _refreshBtn.removeEventListener("click",__refreshPet);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,5),__updateRefreshPet);
         if(_refreshTimer)
         {
            _refreshTimer.stop();
            _refreshTimer.removeEventListener("timer",__refreshUpdatePet);
            _refreshTimer = null;
         }
         PlayerManager.Instance.Self.getBag(1).removeEventListener("update",__bagUpdate);
         KingBlessManager.instance.removeEventListener("update_buff_data_event",refreshPetBtn);
      }
      
      private function __adoptPet(e:MouseEvent) : void
      {
         var title:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(currentPet.isGoodItem)
         {
            title = LanguageMgr.GetTranslation("ddt.farms.adoptItemAlertTitle");
         }
         else
         {
            title = LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertTitle");
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(title," ",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"farmSimpleAlertTwo",60,false);
         alert.titleOuterRectPosString = "133,15,5";
         alert.info.customPos = PositionUtils.creatPoint("farmSimpleAlertButtonPos");
         alert.info.dispatchEvent(new InteractiveEvent("stateChange"));
         var msgText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("farmSimpleAlert.textStyle");
         if(currentPet.isGoodItem)
         {
            msgText.text = LanguageMgr.GetTranslation("ddt.farms.adoptItemsAlertContonet");
         }
         else
         {
            msgText.text = LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertContonet");
         }
         alert.addToContent(msgText);
         alert.addEventListener("response",__onAdoptResponse);
      }
      
      private function __refreshPet(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var refreshNeed:int = LanguageMgr.GetTranslation("ddt.pet.refreshNeed");
         var ff:Number = PlayerManager.Instance.Self.Money;
         refeshPet();
      }
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         event.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function refeshPet() : void
      {
         var alert:* = null;
         if(FarmComposeHouseController.instance().isFourStarPet(PetsBagManager.instance().petModel.adoptPets.list))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.farms.refreshPetsAlertTitle"),LanguageMgr.GetTranslation("ddt.farms.refreshPetsAlertContonetI"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"farmSimpleAlert",60,false);
            alert.addEventListener("response",__RefreshResponseI);
            alert.titleOuterRectPosString = "206,10,5";
            return;
         }
         refreshPetAlert();
      }
      
      private function refreshPetAlert() : void
      {
         if(KingBlessManager.instance.getOneBuffData(2) > 0 || int(FarmComposeHouseController.instance().refreshVolume()) > 0)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _refreshBtn.enable = false;
            SocketManager.Instance.out.sendRefreshPet(true);
            return;
         }
         if(SharedManager.Instance.isRefreshPet)
         {
            if(BuriedManager.Instance.checkMoney(SharedManager.Instance.isRefreshBand,PetconfigAnalyzer.PetCofnig.AdoptRefereshCost))
            {
               SharedManager.Instance.isRefreshPet = false;
               _refreshPetPnl = ComponentFactory.Instance.creatComponentByStylename("farm.refreshPetAlertFrame.confirmRefresh");
               LayerManager.Instance.addToLayer(_refreshPetPnl,3,true,1);
               _refreshPetPnl.addEventListener("response",__onRefreshResponse);
               return;
            }
            SocketManager.Instance.out.sendRefreshPet(true,SharedManager.Instance.isRefreshBand);
            return;
         }
         _refreshPetPnl = ComponentFactory.Instance.creatComponentByStylename("farm.refreshPetAlertFrame.confirmRefresh");
         LayerManager.Instance.addToLayer(_refreshPetPnl,3,true,1);
         _refreshPetPnl.addEventListener("response",__onRefreshResponse);
      }
      
      private function __RefreshResponseI(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.target as BaseAlerFrame;
         alert.removeEventListener("response",__RefreshResponseI);
         alert.dispose();
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            refreshPetAlert();
         }
      }
      
      private function __onAdoptResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.target as BaseAlerFrame;
         alert.removeEventListener("response",__onAdoptResponse);
         alert.dispose();
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(currentPet && currentPet.info as PetInfo)
            {
               SocketManager.Instance.out.sendAdoptPet((currentPet.info as PetInfo).Place);
               removeItemByPetInfo(currentPet.info);
               currentPet = null;
               if(PetsBagManager.instance().haveTaskOrderByID(367))
               {
                  PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(93);
               }
            }
            else if(currentPet && currentPet.itemInfo)
            {
               SocketManager.Instance.out.sendAdoptPet(currentPet.place);
               removeItemByPlace(currentPet.place);
               currentPet = null;
            }
         }
         updateAdoptBtnStatus();
      }
      
      private function __onRefreshResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            CheckMoneyUtils.instance.checkMoney(_refreshPetPnl.getBind(),PetconfigAnalyzer.PetCofnig.AdoptRefereshCost,onCheckComplete);
            return;
         }
         _refreshPetPnl.removeEventListener("response",__onRefreshResponse);
         _refreshPetPnl.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendRefreshPet(true,CheckMoneyUtils.instance.isBind);
         _refreshPetPnl.removeEventListener("response",__onRefreshResponse);
         _refreshPetPnl.dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeItem();
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
            _titleBg = null;
         }
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
            _bg2 = null;
         }
         if(_refreshTimerTxt)
         {
            ObjectUtils.disposeObject(_refreshTimerTxt);
            _refreshTimerTxt = null;
         }
         if(currentPet)
         {
            ObjectUtils.disposeObject(currentPet);
            currentPet = null;
         }
         if(_listView)
         {
            ObjectUtils.disposeObject(_listView);
            _listView = null;
         }
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
            _refreshBtn = null;
         }
         if(_adoptBtn)
         {
            ObjectUtils.disposeObject(_adoptBtn);
            _adoptBtn = null;
         }
         if(_adoptItemBtn)
         {
            ObjectUtils.disposeObject(_adoptItemBtn);
            _adoptItemBtn = null;
         }
         if(_refreshVolumeImg)
         {
            ObjectUtils.disposeObject(_refreshVolumeImg);
            _refreshVolumeImg = null;
         }
         if(_refreshVolumeTxt)
         {
            ObjectUtils.disposeObject(_refreshVolumeTxt);
            _refreshVolumeTxt = null;
         }
         if(_refreshVolumeTxtBG)
         {
            ObjectUtils.disposeObject(_refreshVolumeTxtBG);
            _refreshVolumeTxtBG = null;
         }
         if(_refreshVolumeTip)
         {
            ObjectUtils.disposeObject(_refreshVolumeTip);
            _refreshVolumeTip = null;
         }
         if(_newPetView)
         {
            ObjectUtils.disposeObject(_newPetView);
         }
         _newPetView = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
