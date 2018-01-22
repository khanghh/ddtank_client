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
      
      private function update(param1:Array, param2:Array) : void
      {
         var _loc3_:* = null;
         if(param1 && param1.length >= 1)
         {
            removeItem();
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for each(var _loc4_ in param1)
            {
               _loc3_ = ComponentFactory.Instance.creat("farm.petAdoptItem",[_loc4_]);
               _petsImgVec.push(_loc3_);
            }
         }
         updateItems(param2);
         currentPet = null;
         addItem();
         updateAdoptBtnStatus();
      }
      
      private function updateRefreshVolume() : void
      {
         _refreshVolumeTxt.text = FarmComposeHouseController.instance().refreshVolume();
      }
      
      public function updateTimer(param1:String) : void
      {
         _refreshTimerTxt.text = param1;
      }
      
      private function addItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _petsImgVec.length)
         {
            _petsImgVec[_loc1_].addEventListener("itemclick",__petItemClick);
            _listView.addChild(_petsImgVec[_loc1_]);
            _loc1_++;
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _petsImgVec.length)
         {
            _petsImgVec[_loc1_].removeEventListener("itemclick",__petItemClick);
            _petsImgVec[_loc1_].dispose();
            _petsImgVec[_loc1_] = null;
            _loc1_++;
         }
         _petsImgVec.splice(0,_petsImgVec.length);
      }
      
      private function removeItemByPetInfo(param1:PetInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _petsImgVec.length)
         {
            if(_petsImgVec[_loc2_].info)
            {
               if(_petsImgVec[_loc2_].info.TemplateID == param1.TemplateID && _petsImgVec[_loc2_].info.Place == param1.Place)
               {
                  _petsImgVec[_loc2_].removeEventListener("itemclick",__petItemClick);
                  _petsImgVec[_loc2_].dispose();
                  _petsImgVec[_loc2_] = null;
                  _petsImgVec.splice(_loc2_,1);
                  PetsBagManager.instance().petModel.adoptPets.remove(param1.Place);
                  break;
               }
            }
            _loc2_++;
         }
      }
      
      private function removeItemByPlace(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _petsImgVec.length)
         {
            if(_petsImgVec[_loc2_].itemInfo && param1 == _petsImgVec[_loc2_].place)
            {
               _petsImgVec[_loc2_].removeEventListener("itemclick",__petItemClick);
               _petsImgVec[_loc2_].dispose();
               _petsImgVec[_loc2_] = null;
               _petsImgVec.splice(_loc2_,1);
               PetsBagManager.instance().petModel.adoptItems.remove(param1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function __petItemClick(param1:PetItemEvent) : void
      {
         SoundManager.instance.play("008");
         currentPet = param1.data as AdoptItem;
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
      
      private function setSelectUnSelect(param1:AdoptItem, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _petsImgVec.length)
         {
            if(_petsImgVec[_loc3_] && _petsImgVec[_loc3_] != param1)
            {
               _petsImgVec[_loc3_].isSelect = param2;
            }
            _loc3_++;
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
      
      private function refreshPetBtn(param1:Event) : void
      {
         var _loc2_:int = KingBlessManager.instance.getOneBuffData(2);
         if(_loc2_ > 0)
         {
            _refreshBtn.text = LanguageMgr.GetTranslation("ddt.farms.petFreeRefresh",_loc2_);
            PositionUtils.setPos(_refreshBtn,"assets.farm.petFreeRefreshPos");
         }
         else
         {
            _refreshBtn.text = LanguageMgr.GetTranslation("ddt.farms.refresh");
            PositionUtils.setPos(_refreshBtn,"assets.farm.petRefreshPos");
         }
      }
      
      private function __bagUpdate(param1:Event) : void
      {
         updateRefreshVolume();
      }
      
      private function __refreshUpdatePet(param1:TimerEvent) : void
      {
         updateTimer(FarmComposeHouseController.instance().getNextUpdatePetTimes());
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __updateRefreshPet(param1:PkgEvent) : void
      {
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:* = null;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc14_:Boolean = _loc5_.readBoolean();
         var _loc2_:int = _loc5_.readInt();
         PetsBagManager.instance().petModel.adoptPets.clear();
         _loc8_ = 0;
         while(_loc8_ < _loc2_)
         {
            if(_loc14_)
            {
               _loc13_ = _loc5_.readInt();
               _loc9_ = _loc5_.readInt();
               _loc12_ = new PetInfo();
               _loc12_.TemplateID = _loc9_;
               PetInfoManager.fillPetInfo(_loc12_);
               _loc12_.Name = _loc5_.readUTF();
               _loc12_.Attack = _loc5_.readInt();
               _loc12_.Defence = _loc5_.readInt();
               _loc12_.Luck = _loc5_.readInt();
               _loc12_.Agility = _loc5_.readInt();
               _loc12_.Blood = _loc5_.readInt();
               _loc12_.Damage = _loc5_.readInt();
               _loc12_.Guard = _loc5_.readInt();
               _loc12_.AttackGrow = _loc5_.readInt();
               _loc12_.DefenceGrow = _loc5_.readInt();
               _loc12_.LuckGrow = _loc5_.readInt();
               _loc12_.AgilityGrow = _loc5_.readInt();
               _loc12_.BloodGrow = _loc5_.readInt();
               _loc12_.DamageGrow = _loc5_.readInt();
               _loc12_.GuardGrow = _loc5_.readInt();
               _loc12_.Level = _loc5_.readInt();
               _loc12_.GP = _loc5_.readInt();
               _loc12_.MaxGP = _loc5_.readInt();
               _loc12_.Hunger = _loc5_.readInt();
               _loc12_.MP = _loc5_.readInt();
               _loc10_ = _loc5_.readInt();
               _loc7_ = 0;
               while(_loc7_ < _loc10_)
               {
                  _loc4_ = _loc5_.readInt();
                  _loc3_ = new PetSkill(_loc4_);
                  _loc12_.addSkill(_loc3_);
                  _loc5_.readInt();
                  _loc7_++;
               }
               _loc12_.MaxActiveSkillCount = _loc5_.readInt();
               _loc12_.MaxStaticSkillCount = _loc5_.readInt();
               _loc12_.MaxSkillCount = _loc5_.readInt();
               _loc12_.Place = _loc13_;
               if(_loc12_.Place != -1)
               {
                  PetsBagManager.instance().petModel.adoptPets.add(_loc12_.Place,_loc12_);
               }
               else
               {
                  PetsBagManager.instance().newPetInfo = _loc12_;
               }
            }
            else
            {
               _loc13_ = _loc5_.readInt();
               _loc9_ = _loc5_.readInt();
               _loc12_ = new PetInfo();
               _loc12_.TemplateID = _loc9_;
               PetInfoManager.fillPetInfo(_loc12_);
               _loc12_.Name = _loc5_.readUTF();
               _loc12_.Attack = _loc5_.readInt();
               _loc12_.Defence = _loc5_.readInt();
               _loc12_.Luck = _loc5_.readInt();
               _loc12_.Agility = _loc5_.readInt();
               _loc12_.Blood = _loc5_.readInt();
               _loc12_.Damage = _loc5_.readInt();
               _loc12_.Guard = _loc5_.readInt();
               _loc12_.AttackGrow = _loc5_.readInt();
               _loc12_.DefenceGrow = _loc5_.readInt();
               _loc12_.LuckGrow = _loc5_.readInt();
               _loc12_.AgilityGrow = _loc5_.readInt();
               _loc12_.BloodGrow = _loc5_.readInt();
               _loc12_.DamageGrow = _loc5_.readInt();
               _loc12_.GuardGrow = _loc5_.readInt();
               _loc12_.Level = _loc5_.readInt();
               _loc12_.GP = _loc5_.readInt();
               _loc12_.MaxGP = _loc5_.readInt();
               _loc12_.Hunger = _loc5_.readInt();
               _loc12_.MP = _loc5_.readInt();
               _loc10_ = _loc5_.readInt();
               _loc7_ = 0;
               while(_loc7_ < _loc10_)
               {
                  _loc4_ = _loc5_.readInt();
                  _loc3_ = new PetSkill(_loc4_);
                  _loc12_.addSkill(_loc3_);
                  _loc5_.readInt();
                  _loc7_++;
               }
               _loc12_.MaxActiveSkillCount = _loc5_.readInt();
               _loc12_.MaxStaticSkillCount = _loc5_.readInt();
               _loc12_.MaxSkillCount = _loc5_.readInt();
               _loc12_.Place = _loc13_;
               if(_loc12_.Place != -1)
               {
                  PetsBagManager.instance().petModel.adoptPets.add(_loc12_.Place,_loc12_);
               }
               else
               {
                  PetsBagManager.instance().newPetInfo = _loc12_;
               }
            }
            _loc8_++;
         }
         PetsBagManager.instance().petModel.adoptItems.clear();
         _loc2_ = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc11_ = new AdoptItemInfo();
            _loc11_.place = _loc5_.readInt();
            _loc11_.itemTemplateId = _loc5_.readInt();
            _loc11_.itemAmount = _loc5_.readInt();
            PetsBagManager.instance().petModel.adoptItems.add(_loc11_.place,_loc11_);
            _loc6_++;
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
      
      private function __onNewPetFrameClose(param1:Event) : void
      {
         _newPetView.removeEventListener("newPetFrameClose",__onNewPetFrameClose);
         TweenMax.to(this,0.2,{"x":255});
      }
      
      private function updateItems(param1:Array) : void
      {
         var _loc2_:* = null;
         if(!param1 || param1.length < 1)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_ = ComponentFactory.Instance.creat("farm.petAdoptItem",[null]);
            _loc2_.itemAmount = _loc3_.itemAmount;
            _loc2_.place = _loc3_.place;
            _loc2_.itemTemplateId = _loc3_.itemTemplateId;
            _petsImgVec.push(_loc2_);
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
      
      private function __adoptPet(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(currentPet.isGoodItem)
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.farms.adoptItemAlertTitle");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertTitle");
         }
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(_loc2_," ",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"farmSimpleAlertTwo",60,false);
         _loc3_.titleOuterRectPosString = "133,15,5";
         _loc3_.info.customPos = PositionUtils.creatPoint("farmSimpleAlertButtonPos");
         _loc3_.info.dispatchEvent(new InteractiveEvent("stateChange"));
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("farmSimpleAlert.textStyle");
         if(currentPet.isGoodItem)
         {
            _loc4_.text = LanguageMgr.GetTranslation("ddt.farms.adoptItemsAlertContonet");
         }
         else
         {
            _loc4_.text = LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertContonet");
         }
         _loc3_.addToContent(_loc4_);
         _loc3_.addEventListener("response",__onAdoptResponse);
      }
      
      private function __refreshPet(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:int = LanguageMgr.GetTranslation("ddt.pet.refreshNeed");
         var _loc2_:Number = PlayerManager.Instance.Self.Money;
         refeshPet();
      }
      
      private function __poorManResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function refeshPet() : void
      {
         var _loc1_:* = null;
         if(FarmComposeHouseController.instance().isFourStarPet(PetsBagManager.instance().petModel.adoptPets.list))
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.farms.refreshPetsAlertTitle"),LanguageMgr.GetTranslation("ddt.farms.refreshPetsAlertContonetI"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"farmSimpleAlert",60,false);
            _loc1_.addEventListener("response",__RefreshResponseI);
            _loc1_.titleOuterRectPosString = "206,10,5";
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
      
      private function __RefreshResponseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__RefreshResponseI);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            refreshPetAlert();
         }
      }
      
      private function __onAdoptResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAdoptResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
      
      private function __onRefreshResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
