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
      
      private function update(pets:Array) : void
      {
         var petIcon:* = null;
         if(!pets || pets.length < 1)
         {
            return;
         }
         removeItem();
         var _loc5_:int = 0;
         var _loc4_:* = pets;
         for each(var petInfo in pets)
         {
            petIcon = ComponentFactory.Instance.creat("farm.petAdoptItem",[petInfo]);
            _petsImgVec.push(petIcon);
         }
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
      }
      
      private function addItem() : void
      {
         var index:int = 0;
         for(index = 0; index < _petsImgVec.length; )
         {
            if(index > 3)
            {
               return;
            }
            _petsImgVec[index].addEventListener("itemclick",__petItemClick);
            _listView.addChild(_petsImgVec[index]);
            index++;
         }
      }
      
      private function updateAdoptBtnStatus() : void
      {
         _adoptBtn.enable = _petsImgVec.length > 0 && currentPet?true:false;
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
      
      private function __petItemClick(e:PetItemEvent) : void
      {
         var index:int = 0;
         SoundManager.instance.play("008");
         currentPet = e.data as AdoptItem;
         if(currentPet)
         {
            setSelectUnSelect(currentPet);
            index = _petsImgVec.indexOf(currentPet);
            if(index > 0 && index < 4)
            {
               _refreshVolumeTxt.text = "   " + _descList[index];
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
         SocketManager.Instance.addEventListener(PkgEvent.format(68,5),__updateRefreshPet);
         addEventListener("response",__responseHandler);
      }
      
      private function __bagUpdate(event:Event) : void
      {
         updateRefreshVolume();
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
         var pkg:PackageIn = e.pkg;
         var isUpdate:Boolean = pkg.readBoolean();
         var count:int = pkg.readInt();
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
            }
            i++;
         }
         update(PetsBagManager.instance().petModel.adoptPets.list);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _adoptBtn.removeEventListener("click",__adoptPet);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,5),__updateRefreshPet);
      }
      
      private function __adoptPet(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertTitle")," ",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"farmSimpleAlertTwo",60,false);
         alert.info.customPos = PositionUtils.creatPoint("farmSimpleAlertButtonPos");
         alert.titleOuterRectPosString = "133,15,5";
         alert.info.dispatchEvent(new InteractiveEvent("stateChange"));
         var msgText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("farmSimpleAlert.textStyle");
         msgText.text = LanguageMgr.GetTranslation("ddt.farms.adoptPetsAlertContonet");
         alert.addToContent(msgText);
         alert.addEventListener("response",__onAdoptResponse);
      }
      
      private function __refreshPet(e:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         var refreshNeed:int = LanguageMgr.GetTranslation("ddt.pet.refreshNeed");
         var ff:Number = PlayerManager.Instance.Self.Money;
         if(PlayerManager.Instance.Self.Money < refreshNeed && int(_refreshVolumeTxt.text) <= 0)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert.moveEnable = false;
            alert.addEventListener("response",__poorManResponse);
            return;
         }
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
         if(SharedManager.Instance.isRefreshPet)
         {
            SocketManager.Instance.out.sendRefreshPet(true,_refreshPetPnl.isBand);
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
               PetSpriteManager.Instance.dispatchEvent(new Event("open"));
            }
            dispose();
         }
         if(_adoptBtn)
         {
            updateAdoptBtnStatus();
         }
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
