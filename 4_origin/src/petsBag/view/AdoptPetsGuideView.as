package petsBag.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import farm.control.FarmComposeHouseController;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import pet.data.PetSkill;
   import pet.data.PetTemplateInfo;
   import pet.sprite.PetSpriteManager;
   import petsBag.PetsBagManager;
   import petsBag.event.PetItemEvent;
   import petsBag.view.item.AdoptItem;
   import road7th.comm.PackageIn;
   
   public class AdoptPetsGuideView extends Frame
   {
       
      
      private var _adoptBtn:SimpleBitmapButton;
      
      private var _listView:SimpleTileList;
      
      private var _petsImgVec:Vector.<AdoptItem>;
      
      public var currentPet:AdoptItem;
      
      private var _refreshTimerTxt:FilterFrameText;
      
      private var _titleBg:DisplayObject;
      
      private var _bg2:DisplayObject;
      
      private var _refreshVolumeImg:Bitmap;
      
      private var _refreshVolumeTxt:FilterFrameText;
      
      private var _desBg:ScaleBitmapImage;
      
      private var _descList:Array;
      
      private var _refreshPetPnl:RefreshPetAlertFrame;
      
      public function AdoptPetsGuideView()
      {
         _descList = new Array(LanguageMgr.GetTranslation("ddt.farm.petguide1"),LanguageMgr.GetTranslation("ddt.farm.petguide2"),LanguageMgr.GetTranslation("ddt.farm.petguide3"),LanguageMgr.GetTranslation("ddt.farm.petguide4"));
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
         _desBg = ComponentFactory.Instance.creatComponentByStylename("farm.adoptPetsView.descBg2");
         addToContent(_desBg);
         _adoptBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.adopt");
         addToContent(_adoptBtn);
         _refreshTimerTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.adoptdescTitle");
         _refreshTimerTxt.text = LanguageMgr.GetTranslation("ddt.farms.desc");
         addToContent(_refreshTimerTxt);
         _listView = ComponentFactory.Instance.creatCustomObject("farm.simpleTileList.petAdop",[4]);
         addToContent(_listView);
         _refreshVolumeImg = ComponentFactory.Instance.creatBitmap("assets.farm.petRecommendImg");
         addToContent(_refreshVolumeImg);
         _refreshVolumeTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.adoptdesctxt");
         addToContent(_refreshVolumeTxt);
         updateAdoptBtnStatus();
      }
      
      private function update(param1:Array) : void
      {
         var _loc2_:* = null;
         if(!param1 || param1.length < 1)
         {
            return;
         }
         removeItem();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_ = ComponentFactory.Instance.creat("farm.petAdoptItem",[_loc3_]);
            _petsImgVec.push(_loc2_);
         }
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
      }
      
      private function addItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _petsImgVec.length)
         {
            if(_loc1_ > 3)
            {
               return;
            }
            _petsImgVec[_loc1_].addEventListener("itemclick",__petItemClick);
            _listView.addChild(_petsImgVec[_loc1_]);
            _loc1_++;
         }
      }
      
      private function updateAdoptBtnStatus() : void
      {
         _adoptBtn.enable = _petsImgVec.length > 0 && currentPet?true:false;
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
      
      private function __petItemClick(param1:PetItemEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         currentPet = param1.data as AdoptItem;
         if(currentPet)
         {
            setSelectUnSelect(currentPet);
            _loc2_ = _petsImgVec.indexOf(currentPet);
            if(_loc2_ > 0 && _loc2_ < 4)
            {
               _refreshVolumeTxt.text = "   " + _descList[_loc2_];
            }
            else
            {
               _refreshVolumeTxt.text = currentPet.info.Description;
            }
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
         SocketManager.Instance.addEventListener(PkgEvent.format(68,5),__updateRefreshPet);
         addEventListener("response",__responseHandler);
      }
      
      private function __bagUpdate(param1:Event) : void
      {
         updateRefreshVolume();
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
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:PackageIn = param1.pkg;
         var _loc12_:Boolean = _loc8_.readBoolean();
         var _loc4_:int = _loc8_.readInt();
         _loc11_ = 0;
         while(_loc11_ < _loc4_)
         {
            if(_loc12_)
            {
               _loc9_ = _loc8_.readInt();
               _loc2_ = _loc8_.readInt();
               _loc7_ = new PetInfo();
               _loc7_.TemplateID = _loc2_;
               PetInfoManager.fillPetInfo(_loc7_);
               _loc7_.Name = _loc8_.readUTF();
               _loc7_.Attack = _loc8_.readInt();
               _loc7_.Defence = _loc8_.readInt();
               _loc7_.Luck = _loc8_.readInt();
               _loc7_.Agility = _loc8_.readInt();
               _loc7_.Blood = _loc8_.readInt();
               _loc7_.Damage = _loc8_.readInt();
               _loc7_.Guard = _loc8_.readInt();
               _loc7_.AttackGrow = _loc8_.readInt();
               _loc7_.DefenceGrow = _loc8_.readInt();
               _loc7_.LuckGrow = _loc8_.readInt();
               _loc7_.AgilityGrow = _loc8_.readInt();
               _loc7_.BloodGrow = _loc8_.readInt();
               _loc7_.DamageGrow = _loc8_.readInt();
               _loc7_.GuardGrow = _loc8_.readInt();
               _loc7_.Level = _loc8_.readInt();
               _loc7_.GP = _loc8_.readInt();
               _loc7_.MaxGP = _loc8_.readInt();
               _loc7_.Hunger = _loc8_.readInt();
               _loc7_.MP = _loc8_.readInt();
               _loc3_ = _loc8_.readInt();
               _loc10_ = 0;
               while(_loc10_ < _loc3_)
               {
                  _loc5_ = _loc8_.readInt();
                  _loc6_ = new PetSkill(_loc5_);
                  _loc7_.addSkill(_loc6_);
                  _loc8_.readInt();
                  _loc10_++;
               }
               _loc7_.MaxActiveSkillCount = _loc8_.readInt();
               _loc7_.MaxStaticSkillCount = _loc8_.readInt();
               _loc7_.MaxSkillCount = _loc8_.readInt();
               _loc7_.Place = _loc9_;
               if(_loc7_.Place != -1)
               {
                  PetsBagManager.instance().petModel.adoptPets.add(_loc7_.Place,_loc7_);
               }
            }
            else
            {
               _loc9_ = _loc8_.readInt();
               _loc2_ = _loc8_.readInt();
               _loc7_ = new PetInfo();
               _loc7_.TemplateID = _loc2_;
               PetInfoManager.fillPetInfo(_loc7_);
               _loc7_.Name = _loc8_.readUTF();
               _loc7_.Attack = _loc8_.readInt();
               _loc7_.Defence = _loc8_.readInt();
               _loc7_.Luck = _loc8_.readInt();
               _loc7_.Agility = _loc8_.readInt();
               _loc7_.Blood = _loc8_.readInt();
               _loc7_.Damage = _loc8_.readInt();
               _loc7_.Guard = _loc8_.readInt();
               _loc7_.AttackGrow = _loc8_.readInt();
               _loc7_.DefenceGrow = _loc8_.readInt();
               _loc7_.LuckGrow = _loc8_.readInt();
               _loc7_.AgilityGrow = _loc8_.readInt();
               _loc7_.BloodGrow = _loc8_.readInt();
               _loc7_.DamageGrow = _loc8_.readInt();
               _loc7_.GuardGrow = _loc8_.readInt();
               _loc7_.Level = _loc8_.readInt();
               _loc7_.GP = _loc8_.readInt();
               _loc7_.MaxGP = _loc8_.readInt();
               _loc7_.Hunger = _loc8_.readInt();
               _loc7_.MP = _loc8_.readInt();
               _loc3_ = _loc8_.readInt();
               _loc10_ = 0;
               while(_loc10_ < _loc3_)
               {
                  _loc5_ = _loc8_.readInt();
                  _loc6_ = new PetSkill(_loc5_);
                  _loc7_.addSkill(_loc6_);
                  _loc8_.readInt();
                  _loc10_++;
               }
               _loc7_.MaxActiveSkillCount = _loc8_.readInt();
               _loc7_.MaxStaticSkillCount = _loc8_.readInt();
               _loc7_.MaxSkillCount = _loc8_.readInt();
               _loc7_.Place = _loc9_;
               if(_loc7_.Place != -1)
               {
                  PetsBagManager.instance().petModel.adoptPets.add(_loc7_.Place,_loc7_);
               }
            }
            _loc11_++;
         }
         update(PetsBagManager.instance().petModel.adoptPets.list);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _adoptBtn.removeEventListener("click",__adoptPet);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,5),__updateRefreshPet);
      }
      
      private function __adoptPet(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertTitle")," ",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"farmSimpleAlertTwo",60,false);
         _loc2_.info.customPos = PositionUtils.creatPoint("farmSimpleAlertButtonPos");
         _loc2_.titleOuterRectPosString = "133,15,5";
         _loc2_.info.dispatchEvent(new InteractiveEvent("stateChange"));
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("farmSimpleAlert.textStyle");
         _loc3_.text = LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertContonet");
         _loc2_.addToContent(_loc3_);
         _loc2_.addEventListener("response",__onAdoptResponse);
      }
      
      private function __refreshPet(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:int = LanguageMgr.GetTranslation("ddt.pet.refreshNeed");
         var _loc2_:Number = PlayerManager.Instance.Self.Money;
         if(PlayerManager.Instance.Self.Money < _loc4_ && int(_refreshVolumeTxt.text) <= 0)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",__poorManResponse);
            return;
         }
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
         if(SharedManager.Instance.isRefreshPet)
         {
            SocketManager.Instance.out.sendRefreshPet(true,_refreshPetPnl.isBand);
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
               PetSpriteManager.Instance.dispatchEvent(new Event("open"));
            }
            dispose();
         }
         if(_adoptBtn)
         {
            updateAdoptBtnStatus();
         }
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
            if(BuriedManager.Instance.checkMoney(_refreshPetPnl.getBind(),PetconfigAnalyzer.PetCofnig.AdoptRefereshCost))
            {
               return;
            }
            SocketManager.Instance.out.sendRefreshPet(true,_refreshPetPnl.isBand);
         }
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
         if(_adoptBtn)
         {
            ObjectUtils.disposeObject(_adoptBtn);
            _adoptBtn = null;
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
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
