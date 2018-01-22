package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.event.PetItemEvent;
   
   public class PetsEatView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _eatPetsBtn:SimpleBitmapButton;
      
      private var _eatStoneBtn:SimpleBitmapButton;
      
      private var _weaponBtn:SimpleBitmapButton;
      
      private var _clothesBtn:SimpleBitmapButton;
      
      private var _hatBtn:SimpleBitmapButton;
      
      private var _btnLight:Bitmap;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defenceAddTxt:FilterFrameText;
      
      private var _attackAddTxt:FilterFrameText;
      
      private var _defenceTitleTxt:FilterFrameText;
      
      private var _attackTitleTxt:FilterFrameText;
      
      private var _autoUseBtn:SelectedCheckButton;
      
      private var _bagCell:PetsAdvancedCell;
      
      private var _progress:PetsAdvancedProgressBar;
      
      private var _chooseMc:MovieClip;
      
      private var _expTitle:Bitmap;
      
      private var _lv:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _listPanel:ScrollPanel;
      
      private var _listContainer:Sprite;
      
      private var _petsImgVec:Vector.<PetsEatSmallItem>;
      
      private var _selectedArr:Array;
      
      private var _eatPetsMc:MovieClip;
      
      private var _eatStoneMc:MovieClip;
      
      private var _eatEnd:MovieClip;
      
      private var _petAddExpTxt:FilterFrameText;
      
      private var _petdesTxt:FilterFrameText;
      
      protected var _tip:OneLineTip;
      
      private var _clickDate:Number = 0;
      
      private var clickType:int;
      
      public function PetsEatView()
      {
         _selectedArr = [];
         super();
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("petsBag.eat.bg");
         addChild(_bg);
         _eatPetsBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.eatPetsBtn");
         _eatPetsBtn.tipData = LanguageMgr.GetTranslation("pet.eatPet.tips");
         addChild(_eatPetsBtn);
         _eatStoneBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.eatStoneBtn");
         addChild(_eatStoneBtn);
         _weaponBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.weaponBtn");
         addChild(_weaponBtn);
         _clothesBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.clothesBtn");
         addChild(_clothesBtn);
         _hatBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.hatBtn");
         addChild(_hatBtn);
         _btnLight = ComponentFactory.Instance.creat("assets.PetsBag.eatPets.btnLight");
         addChild(_btnLight);
         _btnLight.x = _weaponBtn.x;
         _btnLight.y = _weaponBtn.y;
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.attributeTxt");
         addChild(_defenceTxt);
         PositionUtils.setPos(_defenceTxt,"petsBag.eatPets.attributePos2");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.attributeTxt");
         addChild(_attackTxt);
         PositionUtils.setPos(_attackTxt,"petsBag.eatPets.attributePos1");
         _defenceAddTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.attributeAddTxt");
         addChild(_defenceAddTxt);
         PositionUtils.setPos(_defenceAddTxt,"petsBag.eatPets.attributeAddPos2");
         _attackAddTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.attributeAddTxt");
         addChild(_attackAddTxt);
         PositionUtils.setPos(_attackAddTxt,"petsBag.eatPets.attributeAddPos1");
         _autoUseBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.autoUseBtn");
         addChild(_autoUseBtn);
         _autoUseBtn.text = LanguageMgr.GetTranslation("ddt.petsBag.eatPets.autoUse");
         _bagCell = new PetsAdvancedCell();
         PositionUtils.setPos(_bagCell,"petsBag.eatPets.petAdvancedCellPos");
         addChild(_bagCell);
         _progress = new PetsAdvancedProgressBar();
         addChild(_progress);
         PositionUtils.setPos(_progress,"petsBag.eatPets.expBarPos");
         _expTitle = ComponentFactory.Instance.creat("assets.PetsBag.eatPets.expTitle");
         addChild(_expTitle);
         _chooseMc = ComponentFactory.Instance.creat("assets.PetsBag.eatPets.chooseMc");
         addChild(_chooseMc);
         _chooseMc.gotoAndStop(1);
         PositionUtils.setPos(_chooseMc,"PetsBag.eatPets.chooseMcPos");
         _lv = ComponentFactory.Instance.creatBitmap("assets.petsBag.Lv");
         addChild(_lv);
         PositionUtils.setPos(_lv,"petsBag.eatPets.lvBitmapPos");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.Lv");
         addChild(_lvTxt);
         PositionUtils.setPos(_lvTxt,"petsBag.eatPets.lvTxtPos");
         _defenceTitleTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.attributeTitleTxt");
         addChild(_defenceTitleTxt);
         PositionUtils.setPos(_defenceTitleTxt,"petsBag.eatPets.defenceTitlePos");
         _defenceTitleTxt.text = LanguageMgr.GetTranslation("defence");
         _attackTitleTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.attributeTitleTxt");
         addChild(_attackTitleTxt);
         PositionUtils.setPos(_attackTitleTxt,"petsBag.eatPets.attackTitlePos");
         _attackTitleTxt.text = LanguageMgr.GetTranslation("attack");
         _tip = new OneLineTip();
         _tip.visible = false;
         addChild(_tip);
         PositionUtils.setPos(_tip,"petsBag.eatPets.expBarTipPos");
         _listContainer = new Sprite();
         updataPets();
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.petsScrollPanel");
         _listPanel.setView(_listContainer);
         _listPanel.invalidateViewport();
         addChild(_listPanel);
         _petAddExpTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.petAddExpTxt");
         addChild(_petAddExpTxt);
         _petAddExpTxt.text = "0";
         _petdesTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.eatPets.petDesTxt");
         addChild(_petdesTxt);
         _petdesTxt.text = LanguageMgr.GetTranslation("ddt.petsBag.eatpets.petDesTitle");
         _eatEnd = ComponentFactory.Instance.creat("asset.PetsBag.eatPets.end");
         addChild(_eatEnd);
         PositionUtils.setPos(_eatEnd,"petsBag.eatPets.endPos");
         _eatPetsMc = ComponentFactory.Instance.creat("asset.PetsBag.eatPetsMc");
         addChild(_eatPetsMc);
         _eatPetsMc.rotation = -80;
         var _loc1_:* = 0.95;
         _eatPetsMc.scaleY = _loc1_;
         _eatPetsMc.scaleX = _loc1_;
         PositionUtils.setPos(_eatPetsMc,"petsBag.eatPets.eatPetsMcPos");
         _eatStoneMc = ComponentFactory.Instance.creat("asset.PetsBag.eatStoneMc");
         addChild(_eatStoneMc);
         _eatStoneMc.rotation = -75;
         PositionUtils.setPos(_eatStoneMc,"petsBag.eatPets.eatStoneMcPos");
         update();
         progressSet();
      }
      
      private function initEvent() : void
      {
         _eatPetsBtn.addEventListener("click",_eatBtnHandler);
         _eatStoneBtn.addEventListener("click",_eatBtnHandler);
         _weaponBtn.addEventListener("click",_selectHandler);
         _clothesBtn.addEventListener("click",_selectHandler);
         _hatBtn.addEventListener("click",_selectHandler);
         _weaponBtn.dispatchEvent(new MouseEvent("click"));
         _progress.addEventListener("rollOver",__showTip);
         _progress.addEventListener("rollOut",__hideTip);
         _eatEnd.addEventListener("mcEnd",_mcEndHandler);
         _eatPetsMc.addEventListener("mcExpChange",_mcExpChangeHandler);
         _eatStoneMc.addEventListener("mcExpChange",_mcExpChangeHandler);
         PetsBagManager.instance().petModel.addEventListener("eat_pets_complete",_infoChangeHandler);
      }
      
      protected function __hideTip(param1:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      protected function __showTip(param1:MouseEvent) : void
      {
         _tip.tipData = _progress.currentExp + "/" + _progress.max;
         _tip.visible = true;
      }
      
      private function _infoChangeHandler(param1:PetItemEvent) : void
      {
         updataPets();
         stopAllMc();
         selectedHandler(null);
         _bagCell.updateCount();
         if(clickType == 1 && _eatPetsMc)
         {
            _eatPetsMc.gotoAndPlay(2);
         }
         else if(clickType == 2 && _eatStoneMc)
         {
            _eatStoneMc.gotoAndPlay(2);
         }
         if(PlayerManager.Instance.Self.pets.length == 0)
         {
            PetsAdvancedControl.Instance.frame.setBtnEnableFalse();
         }
      }
      
      private function _mcExpChangeHandler(param1:Event) : void
      {
         progressSet();
         var _loc2_:* = param1.target;
         if(_eatPetsMc !== _loc2_)
         {
            if(_eatStoneMc !== _loc2_)
            {
            }
            addr35:
            return;
         }
         if(_eatEnd && PetsBagManager.instance().petModel.eatPetsLevelUp)
         {
            PetsBagManager.instance().petModel.eatPetsLevelUp = false;
            _eatEnd.gotoAndPlay(2);
         }
         §§goto(addr35);
      }
      
      private function _mcEndHandler(param1:Event) : void
      {
         var _loc2_:* = param1.target;
         if(_eatEnd === _loc2_)
         {
            update();
         }
      }
      
      private function progressSet() : void
      {
         if(_chooseMc)
         {
            switch(int(_chooseMc.currentFrame) - 1)
            {
               case 0:
                  _lvTxt.text = PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel;
                  if(PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel == PetsAdvancedManager.Instance.petMoePropertyList.length)
                  {
                     _tip.tipData = "0/0";
                     _progress.currentExp = 0;
                     _progress.maxAdvancedGrade();
                     break;
                  }
                  _progress.max = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel].Exp;
                  _progress.setProgress(PetsBagManager.instance().petModel.eatPetsInfo.weaponExp);
                  break;
               case 1:
                  _lvTxt.text = PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel;
                  if(PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel == PetsAdvancedManager.Instance.petMoePropertyList.length)
                  {
                     _tip.tipData = "0/0";
                     _progress.currentExp = 0;
                     _progress.maxAdvancedGrade();
                     break;
                  }
                  _progress.max = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel].Exp;
                  _progress.setProgress(PetsBagManager.instance().petModel.eatPetsInfo.clothesExp);
                  break;
               case 2:
                  _lvTxt.text = PetsBagManager.instance().petModel.eatPetsInfo.hatLevel;
                  if(PetsBagManager.instance().petModel.eatPetsInfo.hatLevel == PetsAdvancedManager.Instance.petMoePropertyList.length)
                  {
                     _tip.tipData = "0/0";
                     _progress.currentExp = 0;
                     _progress.maxAdvancedGrade();
                     break;
                  }
                  _progress.max = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel].Exp;
                  _progress.setProgress(PetsBagManager.instance().petModel.eatPetsInfo.hatExp);
                  break;
            }
         }
      }
      
      private function clearPets() : void
      {
         _petsImgVec = new Vector.<PetsEatSmallItem>();
         while(_listContainer.numChildren > 0)
         {
            _listContainer.removeChildAt(0);
         }
      }
      
      private function updataPets() : void
      {
         var _loc2_:* = null;
         clearPets();
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = PlayerManager.Instance.Self.pets;
         for(var _loc1_ in PlayerManager.Instance.Self.pets)
         {
            if(!PlayerManager.Instance.Self.pets[_loc1_].IsEquip && PlayerManager.Instance.Self.pets[_loc1_].StarLevel >= 3)
            {
               _loc2_ = new PetsEatSmallItem();
               _loc2_.info = PlayerManager.Instance.Self.pets[_loc1_];
               _loc2_.initTips();
               _loc2_.x = 17 + _loc3_ % 2 * 85;
               _loc2_.y = Math.floor(_loc3_ / 2) * 82;
               _loc2_.addEventListener("selected",selectedHandler);
               _loc3_++;
               _listContainer.addChild(_loc2_);
               _petsImgVec.push(_loc2_);
            }
         }
      }
      
      private function selectedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         checkItem();
         _loc4_ = 0;
         while(_loc4_ < _selectedArr.length)
         {
            _loc3_ = _selectedArr[_loc4_][1];
            _loc2_ = _loc2_ + (Math.pow(10,_loc3_.StarLevel - 2) + 5 * Math.max(_loc3_.Level - 8,_loc3_.Level * 0.2));
            _loc4_++;
         }
         _petAddExpTxt.text = String(_loc2_);
      }
      
      private function stopAllMc() : void
      {
         _eatPetsMc.gotoAndStop(1);
         _eatStoneMc.gotoAndStop(1);
         _eatEnd.gotoAndStop(1);
      }
      
      public function update() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         switch(int(_chooseMc.currentFrame) - 1)
         {
            case 0:
               if(PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel > 0 && PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel < PetsAdvancedManager.Instance.petMoePropertyList.length)
               {
                  _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel - 1].Attack;
                  _loc1_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel - 1].Lucky;
                  _loc2_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel].Attack;
                  _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel].Lucky;
               }
               else if(PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel == 0)
               {
                  _loc4_ = 0;
                  _loc1_ = 0;
                  _loc2_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel].Attack;
                  _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel].Lucky;
               }
               else if(PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel == PetsAdvancedManager.Instance.petMoePropertyList.length)
               {
                  _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel - 1].Attack;
                  _loc1_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.weaponLevel - 1].Lucky;
                  _loc2_ = 0;
                  _loc3_ = 0;
               }
               break;
            case 1:
               if(PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel > 0 && PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel < PetsAdvancedManager.Instance.petMoePropertyList.length)
               {
                  _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel - 1].Agility;
                  _loc1_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel - 1].Blood;
                  _loc2_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel].Agility;
                  _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel].Blood;
               }
               else if(PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel == 0)
               {
                  _loc4_ = 0;
                  _loc1_ = 0;
                  _loc2_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel].Agility;
                  _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel].Blood;
               }
               else if(PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel == PetsAdvancedManager.Instance.petMoePropertyList.length)
               {
                  _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel - 1].Agility;
                  _loc1_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.clothesLevel - 1].Blood;
                  _loc2_ = 0;
                  _loc3_ = 0;
               }
               break;
            case 2:
               if(PetsBagManager.instance().petModel.eatPetsInfo.hatLevel > 0 && PetsBagManager.instance().petModel.eatPetsInfo.hatLevel < PetsAdvancedManager.Instance.petMoePropertyList.length)
               {
                  _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel - 1].Defence;
                  _loc1_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel - 1].Guard;
                  _loc2_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel].Defence;
                  _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel].Guard;
                  break;
               }
               if(PetsBagManager.instance().petModel.eatPetsInfo.hatLevel == 0)
               {
                  _loc4_ = 0;
                  _loc1_ = 0;
                  _loc2_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel].Defence;
                  _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel].Guard;
                  break;
               }
               if(PetsBagManager.instance().petModel.eatPetsInfo.hatLevel == PetsAdvancedManager.Instance.petMoePropertyList.length)
               {
                  _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel - 1].Defence;
                  _loc1_ = PetsAdvancedManager.Instance.petMoePropertyList[PetsBagManager.instance().petModel.eatPetsInfo.hatLevel - 1].Guard;
                  _loc2_ = 0;
                  _loc3_ = 0;
                  break;
               }
               break;
         }
         _attackTxt.text = String(_loc4_);
         _defenceTxt.text = String(_loc1_);
         _attackAddTxt.text = String(_loc2_);
         _defenceAddTxt.text = String(_loc3_);
      }
      
      private function checkItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _selectedArr = [];
         _loc2_ = 0;
         while(_loc2_ < _petsImgVec.length)
         {
            _loc1_ = _petsImgVec[_loc2_] as PetsEatSmallItem;
            if(_loc1_.selected)
            {
               _selectedArr.push([_loc1_.info.Place,_loc1_.info]);
            }
            _loc2_++;
         }
      }
      
      private function _eatBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:* = param1.target;
         if(_eatPetsBtn !== _loc4_)
         {
            if(_eatStoneBtn === _loc4_)
            {
               clickType = 2;
               if(new Date().time - _clickDate <= 2000)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
                  return;
               }
               _clickDate = new Date().time;
               if(_lvTxt.text == String(PetsAdvancedManager.Instance.petMoePropertyList.length))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.eatPets.maxLevel"));
                  return;
               }
               if(_autoUseBtn.selected)
               {
                  SocketManager.Instance.out.eatPetsHandler(_chooseMc.currentFrame - 1,2,_bagCell.getCount(),[]);
               }
               else
               {
                  SocketManager.Instance.out.eatPetsHandler(_chooseMc.currentFrame - 1,2,1,[]);
               }
            }
         }
         else
         {
            checkItem();
            clickType = 1;
            if(_selectedArr.length < 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.eatPets.pleaseChoosePets"));
               return;
            }
            if(_lvTxt.text == String(PetsAdvancedManager.Instance.petMoePropertyList.length))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petsBag.eatPets.maxLevel"));
               return;
            }
            if(checkEatGreatPets())
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.petsBag.eatpets.eatGreatPets"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc3_.addEventListener("response",__alertEatGreatPet);
               return;
            }
            if(_listContainer.numChildren == _selectedArr.length)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.petsBag.eatpets.eatAllPets"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc2_.addEventListener("response",__alertEatAllPet);
               return;
            }
            SocketManager.Instance.out.eatPetsHandler(_chooseMc.currentFrame - 1,1,0,_selectedArr);
         }
      }
      
      private function __alertEatGreatPet(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_listContainer.numChildren == _selectedArr.length)
               {
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.petsBag.eatpets.eatAllPets"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
                  _loc2_.addEventListener("response",__alertEatAllPet);
                  param1.currentTarget.removeEventListener("response",__alertEatGreatPet);
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               SocketManager.Instance.out.eatPetsHandler(_chooseMc.currentFrame - 1,1,0,_selectedArr);
               break;
         }
         param1.currentTarget.removeEventListener("response",__alertEatGreatPet);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function checkEatGreatPets() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _selectedArr.length)
         {
            if(_selectedArr[_loc1_][1].StarLevel >= 3)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function __alertEatAllPet(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.eatPetsHandler(_chooseMc.currentFrame - 1,1,0,_selectedArr);
         }
         param1.currentTarget.removeEventListener("response",__alertEatAllPet);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _selectHandler(param1:MouseEvent) : void
      {
         stopAllMc();
         var _loc2_:* = param1.target;
         if(_weaponBtn !== _loc2_)
         {
            if(_clothesBtn !== _loc2_)
            {
               if(_hatBtn === _loc2_)
               {
                  _chooseMc.gotoAndStop(3);
                  _attackTitleTxt.text = LanguageMgr.GetTranslation("defence");
                  _defenceTitleTxt.text = LanguageMgr.GetTranslation("recovery");
               }
            }
            else
            {
               _chooseMc.gotoAndStop(2);
               _attackTitleTxt.text = LanguageMgr.GetTranslation("agility");
               _defenceTitleTxt.text = LanguageMgr.GetTranslation("MaxHp");
            }
         }
         else
         {
            _chooseMc.gotoAndStop(1);
            _attackTitleTxt.text = LanguageMgr.GetTranslation("attack");
            _defenceTitleTxt.text = LanguageMgr.GetTranslation("luck");
         }
         update();
         progressSet();
         _btnLight.x = param1.target.x;
         _btnLight.y = param1.target.y;
      }
      
      private function removeEvent() : void
      {
         _eatPetsBtn.removeEventListener("click",_eatBtnHandler);
         _eatStoneBtn.removeEventListener("click",_eatBtnHandler);
         _weaponBtn.removeEventListener("click",_selectHandler);
         _clothesBtn.removeEventListener("click",_selectHandler);
         _hatBtn.removeEventListener("click",_selectHandler);
         _progress.removeEventListener("rollOver",__showTip);
         _progress.removeEventListener("rollOut",__hideTip);
         _eatEnd.removeEventListener("mcEnd",_mcEndHandler);
         _eatPetsMc.removeEventListener("mcExpChange",_mcExpChangeHandler);
         _eatStoneMc.removeEventListener("mcExpChange",_mcExpChangeHandler);
         PetsBagManager.instance().petModel.removeEventListener("eat_pets_complete",_infoChangeHandler);
      }
      
      public function dispose() : void
      {
         stopAllMc();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_eatPetsBtn)
         {
            ObjectUtils.disposeObject(_eatPetsBtn);
            _eatPetsBtn = null;
         }
         if(_eatStoneBtn)
         {
            ObjectUtils.disposeObject(_eatStoneBtn);
            _eatStoneBtn = null;
         }
         if(_weaponBtn)
         {
            ObjectUtils.disposeObject(_weaponBtn);
            _weaponBtn = null;
         }
         if(_clothesBtn)
         {
            ObjectUtils.disposeObject(_clothesBtn);
            _clothesBtn = null;
         }
         if(_hatBtn)
         {
            ObjectUtils.disposeObject(_hatBtn);
            _hatBtn = null;
         }
         if(_attackTxt)
         {
            ObjectUtils.disposeObject(_attackTxt);
            _attackTxt = null;
         }
         if(_defenceTxt)
         {
            ObjectUtils.disposeObject(_defenceTxt);
            _defenceTxt = null;
         }
         if(_defenceAddTxt)
         {
            ObjectUtils.disposeObject(_defenceAddTxt);
            _defenceAddTxt = null;
         }
         if(_attackAddTxt)
         {
            ObjectUtils.disposeObject(_attackAddTxt);
            _attackAddTxt = null;
         }
         if(_autoUseBtn)
         {
            ObjectUtils.disposeObject(_autoUseBtn);
            _autoUseBtn = null;
         }
         if(_bagCell)
         {
            ObjectUtils.disposeObject(_bagCell);
            _bagCell = null;
         }
         if(_progress)
         {
            ObjectUtils.disposeObject(_progress);
            _progress = null;
         }
         if(_tip)
         {
            ObjectUtils.disposeObject(_tip);
            _tip = null;
         }
         if(_chooseMc)
         {
            ObjectUtils.disposeObject(_chooseMc);
            _chooseMc = null;
         }
         if(_expTitle)
         {
            ObjectUtils.disposeObject(_expTitle);
            _expTitle = null;
         }
         if(_defenceTitleTxt)
         {
            ObjectUtils.disposeObject(_defenceTitleTxt);
            _defenceTitleTxt = null;
         }
         if(_attackTitleTxt)
         {
            ObjectUtils.disposeObject(_attackTitleTxt);
            _attackTitleTxt = null;
         }
         if(_listContainer)
         {
            ObjectUtils.disposeObject(_listContainer);
            _listContainer = null;
         }
         if(_eatPetsMc)
         {
            ObjectUtils.disposeObject(_eatPetsMc);
            _eatPetsMc = null;
         }
         if(_eatStoneMc)
         {
            ObjectUtils.disposeObject(_eatStoneMc);
            _eatStoneMc = null;
         }
         if(_eatEnd)
         {
            ObjectUtils.disposeObject(_eatEnd);
            _eatEnd = null;
         }
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_lv);
         _lv = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_petAddExpTxt);
         _petAddExpTxt = null;
         ObjectUtils.disposeObject(_petdesTxt);
         _petdesTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
