package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.PetFightPropertyData;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import petsBag.view.item.PetPropButton;
   
   public class PetsBagView extends Sprite implements Disposeable
   {
       
      
      private var _bgPet:DisplayObject;
      
      protected var _bgSkillPnl:DisplayObject;
      
      protected var _petMoveScroll:PetMoveScroll;
      
      protected var _petName:FilterFrameText;
      
      private var _fightPowerImg:Bitmap;
      
      private var _fightPowrTxt:FilterFrameText;
      
      protected var _showPet:ShowPet;
      
      protected var _happyBarPet:PetHappyBar;
      
      protected var _petExpProgress:PetExpProgress;
      
      protected var _petSkillPnl:PetSkillPnl;
      
      protected var _attackPbtn:PetPropButton;
      
      protected var _defencePbtn:PetPropButton;
      
      protected var _HPPbtn:PetPropButton;
      
      protected var _agilityPbtn:PetPropButton;
      
      protected var _luckPbtn:PetPropButton;
      
      protected var _fightBtn:TextButton;
      
      private var _petSkillLbl:FilterFrameText;
      
      protected var _infoPlayer:PlayerInfo;
      
      protected var _currentPet:PetInfo;
      
      protected var _downArowImg:Bitmap;
      
      protected var _downArowText:Bitmap;
      
      protected var _currentGradeInfo:PetFightPropertyData;
      
      protected var _downArowTextData:Array;
      
      protected var _currentPetHappyStar:int = -1;
      
      public function PetsBagView()
      {
         _downArowTextData = ["100","40","20","0"];
         super();
         initView();
         initEvent();
      }
      
      public function set infoPlayer(param1:PlayerInfo) : void
      {
         if(_infoPlayer == param1)
         {
            return;
         }
         _infoPlayer = param1;
         if(!_infoPlayer)
         {
            return;
         }
         _petMoveScroll.infoPlayer = _infoPlayer;
         PetsBagManager.instance().petModel.currentPetInfo = getFirstPet(_infoPlayer);
         _currentPet = PetsBagManager.instance().petModel.currentPetInfo;
         updatePetBagView();
      }
      
      public function playShined(param1:int) : void
      {
         _showPet.getBagCell(param1).shinePlay();
      }
      
      public function stopShined(param1:int) : void
      {
         _showPet.getBagCell(param1).shineStop();
      }
      
      protected function getFirstPet(param1:PlayerInfo) : PetInfo
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1.currentPet)
         {
            _loc2_ = param1.currentPet;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < param1.pets.length)
            {
               if(param1.pets[_loc3_])
               {
                  return param1.pets[_loc3_];
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      protected function initView() : void
      {
         _bgPet = ComponentFactory.Instance.creat("assets.petsBag.BG");
         addChild(_bgPet);
         _bgSkillPnl = ComponentFactory.Instance.creat("petsBag.SkillPnl.myBG");
         addChild(_bgSkillPnl);
         _petMoveScroll = new PetMoveScroll();
         addChild(_petMoveScroll);
         _petName = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.PetName");
         addChild(_petName);
         _showPet = ComponentFactory.Instance.creat("petsBag.showPet");
         addChild(_showPet);
         _happyBarPet = ComponentFactory.Instance.creatComponentByStylename("petsBag.petHappyBar");
         addChild(_happyBarPet);
         _petExpProgress = ComponentFactory.Instance.creatComponentByStylename("petExpProgress");
         addChild(_petExpProgress);
         _attackPbtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.propbutton.attack");
         addChild(_attackPbtn);
         _defencePbtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.propbutton.defence");
         addChild(_defencePbtn);
         _HPPbtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.propbutton.HP");
         addChild(_HPPbtn);
         _agilityPbtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.propbutton.agility");
         addChild(_agilityPbtn);
         _luckPbtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.propbutton.luck");
         addChild(_luckPbtn);
         _attackPbtn.propName = LanguageMgr.GetTranslation("attack");
         _defencePbtn.propName = LanguageMgr.GetTranslation("defence");
         _HPPbtn.propName = LanguageMgr.GetTranslation("MaxHp");
         _agilityPbtn.propName = LanguageMgr.GetTranslation("agility");
         _luckPbtn.propName = LanguageMgr.GetTranslation("luck");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.fight");
         addChild(_fightBtn);
         _fightBtn.text = LanguageMgr.GetTranslation("ddt.pets.fight");
         _fightBtn.mouseChildren = false;
         _fightBtn.mouseEnabled = false;
         _fightBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _petSkillLbl = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.petSkill");
         addChild(_petSkillLbl);
         _petSkillLbl.text = LanguageMgr.GetTranslation("ddt.pets.petSkill");
         updateProperByPetStatus();
         _downArowImg = ComponentFactory.Instance.creatBitmap("assets.petsBag.downArowImg");
         addChild(_downArowImg);
      }
      
      protected function initEvent() : void
      {
         PetsBagManager.instance().petModel.addEventListener("change",__onChange);
         PetsAdvancedManager.Instance.addEventListener("advanced_complete",__evolutionSuccessHandler);
      }
      
      protected function __evolutionSuccessHandler(param1:Event) : void
      {
         if(!_currentPet.IsEquip)
         {
            return;
         }
         updatePetsPropByEvolution();
         updatePropertyTip();
      }
      
      protected function removeEvent() : void
      {
         PetsBagManager.instance().petModel.removeEventListener("change",__onChange);
         PetsAdvancedManager.Instance.removeEventListener("advanced_complete",__evolutionSuccessHandler);
      }
      
      protected function __onChange(param1:Event) : void
      {
         if(PetsBagManager.instance().isOtherPetViewOpen)
         {
            return;
         }
         _currentPet = PetsBagManager.instance().petModel.currentPetInfo;
         if(_currentPet)
         {
            updatePetBagView();
         }
         _petMoveScroll.updateSelect();
      }
      
      public function get hasPet() : Boolean
      {
         return _infoPlayer && _infoPlayer.pets.list.length > 0;
      }
      
      public function updatePetBagView() : void
      {
         if(!hasPet)
         {
            this.mouseChildren = false;
            disableAllObj();
            _petExpProgress.noPet();
         }
         var _loc1_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         _petName.text = !!_loc1_?_loc1_.Name:"";
         _petExpProgress.setProgress(!!_loc1_?_loc1_.GP:0,!!_loc1_?_loc1_.MaxGP:0);
         updatePetsPropByEvolution();
         _happyBarPet.info = _loc1_;
         updateSkill();
         updateProperByPetStatus();
         updatePetSatiation();
         ShowPet.isPetEquip = false;
         _showPet.update();
      }
      
      public function updatePetsPropByEvolution() : void
      {
         var _loc1_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc4_:int = 0;
         var _loc3_:* = PetsAdvancedManager.Instance.evolutionDataList;
         for each(var _loc2_ in PetsAdvancedManager.Instance.evolutionDataList)
         {
            if(_infoPlayer.evolutionGrade == 0)
            {
               _currentGradeInfo = new PetFightPropertyData();
               break;
            }
            if(_loc2_.ID == _infoPlayer.evolutionGrade)
            {
               _currentGradeInfo = _loc2_;
               break;
            }
         }
         if(!_currentGradeInfo)
         {
            _currentGradeInfo = new PetFightPropertyData();
         }
         if(_loc1_)
         {
            _attackPbtn.propValue = _loc1_.Attack + _currentGradeInfo.Attack + getValueByType("attack") + getPetsEatValueByType("attack");
            _defencePbtn.propValue = _loc1_.Defence + _currentGradeInfo.Defence + getValueByType("defence") + getPetsEatValueByType("defence");
            _HPPbtn.propValue = _loc1_.Blood + _currentGradeInfo.Blood + getValueByType("hp") + getPetsEatValueByType("hp");
            _agilityPbtn.propValue = _loc1_.Agility + _currentGradeInfo.Agility + getValueByType("agility") + getPetsEatValueByType("agility");
            _luckPbtn.propValue = _loc1_.Luck + _currentGradeInfo.Lucky + getValueByType("luck") + getPetsEatValueByType("luck");
         }
      }
      
      protected function updatePropertyTip() : void
      {
         if(_currentPet && _currentGradeInfo)
         {
            _attackPbtn.currentPropValue = _currentPet.Attack;
            _attackPbtn.breakAddedValue = _currentPet.breakAttack;
            _attackPbtn.addedPropValue = _currentGradeInfo.Attack;
            _attackPbtn.petsWeaponPropValue = getValueByType("attack");
            _attackPbtn.petsEatPropValue = getPetsEatValueByType("attack");
            _defencePbtn.currentPropValue = _currentPet.Defence;
            _defencePbtn.breakAddedValue = _currentPet.breakDefence;
            _defencePbtn.addedPropValue = _currentGradeInfo.Defence;
            _defencePbtn.petsWeaponPropValue = getValueByType("defence");
            _defencePbtn.petsEatPropValue = getPetsEatValueByType("defence");
            _agilityPbtn.currentPropValue = _currentPet.Agility;
            _agilityPbtn.breakAddedValue = _currentPet.breakAgility;
            _agilityPbtn.addedPropValue = _currentGradeInfo.Agility;
            _agilityPbtn.petsWeaponPropValue = getValueByType("agility");
            _agilityPbtn.petsEatPropValue = getPetsEatValueByType("agility");
            _luckPbtn.currentPropValue = _currentPet.Luck;
            _luckPbtn.breakAddedValue = _currentPet.breakLuck;
            _luckPbtn.addedPropValue = _currentGradeInfo.Lucky;
            _luckPbtn.petsWeaponPropValue = getValueByType("luck");
            _luckPbtn.petsEatPropValue = getPetsEatValueByType("luck");
            _HPPbtn.currentPropValue = _currentPet.Blood;
            _HPPbtn.breakAddedValue = _currentPet.breakBlood;
            _HPPbtn.addedPropValue = _currentGradeInfo.Blood;
            _HPPbtn.petsWeaponPropValue = getValueByType("hp");
            _HPPbtn.petsEatPropValue = getPetsEatValueByType("hp");
            _attackPbtn.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.attact");
            _defencePbtn.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.defense");
            _agilityPbtn.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.agility");
            _luckPbtn.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.luck");
            _HPPbtn.property = LanguageMgr.GetTranslation("ddt.pets.hp");
         }
      }
      
      public function getValueByType(param1:String) : int
      {
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < 3)
         {
            _loc6_ = _loc7_.equipList[_loc9_];
            if(_loc6_)
            {
               _loc2_ = ItemManager.fill(_loc6_) as InventoryItemInfo;
               _loc3_ = _loc3_ + _loc2_.Boold;
               _loc10_ = _loc10_ + _loc2_.Agility;
               _loc8_ = _loc8_ + _loc2_.Attack;
               _loc4_ = _loc4_ + _loc2_.Defence;
               _loc5_ = _loc5_ + _loc2_.Luck;
            }
            _loc9_++;
         }
         var _loc11_:* = param1;
         if("hp" !== _loc11_)
         {
            if("attack" !== _loc11_)
            {
               if("defence" !== _loc11_)
               {
                  if("agility" !== _loc11_)
                  {
                     if("luck" !== _loc11_)
                     {
                        return 0;
                     }
                     return _loc5_;
                  }
                  return _loc10_;
               }
               return _loc4_;
            }
            return _loc8_;
         }
         return _loc3_;
      }
      
      public function getPetsEatValueByType(param1:String) : int
      {
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < 3)
         {
            _loc6_ = _loc7_.equipList[_loc9_];
            if(_loc6_)
            {
               _loc2_ = ItemManager.fill(_loc6_) as InventoryItemInfo;
               switch(int(_loc9_))
               {
                  case 0:
                     if(_infoPlayer.petsEatWeaponLevel == 0)
                     {
                        _loc5_ = 0;
                        _loc8_ = 0;
                     }
                     else
                     {
                        _loc8_ = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatWeaponLevel - 1].Attack;
                        _loc5_ = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatWeaponLevel - 1].Lucky;
                     }
                     break;
                  case 1:
                     if(_infoPlayer.petsEatHatLevel == 0)
                     {
                        _loc4_ = 0;
                     }
                     else
                     {
                        _loc4_ = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatHatLevel - 1].Defence;
                     }
                     break;
                  case 2:
                     if(_infoPlayer.petsEatClothesLevel == 0)
                     {
                        _loc3_ = 0;
                        _loc10_ = 0;
                        break;
                     }
                     _loc10_ = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatClothesLevel - 1].Agility;
                     _loc3_ = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatClothesLevel - 1].Blood;
                     break;
               }
            }
            _loc9_++;
         }
         var _loc11_:* = param1;
         if("hp" !== _loc11_)
         {
            if("attack" !== _loc11_)
            {
               if("defence" !== _loc11_)
               {
                  if("agility" !== _loc11_)
                  {
                     if("luck" !== _loc11_)
                     {
                        return 0;
                     }
                     return _loc5_;
                  }
                  return _loc10_;
               }
               return _loc4_;
            }
            return _loc8_;
         }
         return _loc3_;
      }
      
      public function addPetEquip(param1:InventoryItemInfo) : void
      {
         _showPet.addPetEquip(param1);
         updatePropertyTip();
         updatePetsPropByEvolution();
      }
      
      public function delPetEquip(param1:int, param2:int) : void
      {
         _showPet.delPetEquip(param2);
         updatePropertyTip();
         updatePetsPropByEvolution();
      }
      
      protected function updatePetSatiation() : void
      {
         var _loc1_:int = 0;
         if(PetsBagManager.instance().petModel && PetsBagManager.instance().petModel.currentPetInfo)
         {
            _loc1_ = PetsBagManager.instance().petModel.currentPetInfo.PetHappyStar;
            if(_currentPetHappyStar != _loc1_)
            {
               if(_downArowText)
               {
                  ObjectUtils.disposeObject(_downArowText);
               }
               _downArowText = null;
               if(_loc1_ == 1 || _loc1_ == 2)
               {
                  _downArowText = ComponentFactory.Instance.creatBitmap("assets.petsBag.downArowText" + _downArowTextData[_loc1_]);
                  _downArowText.x = _downArowImg.x + (_downArowImg.width - _downArowText.width) / 2;
                  _downArowText.y = _downArowImg.y + _downArowImg.height;
                  addChild(_downArowText);
                  setDownArowVisible(true);
               }
               else
               {
                  setDownArowVisible(false);
               }
               _currentPetHappyStar = _loc1_;
            }
         }
         else
         {
            setDownArowVisible(false);
         }
      }
      
      protected function setDownArowVisible(param1:Boolean) : void
      {
         if(_downArowImg)
         {
            _downArowImg.visible = param1;
         }
      }
      
      protected function updateProperByPetStatus(param1:Boolean = true) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         updatePropertyTip();
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            _loc2_ = PetsBagManager.instance().petModel.currentPetInfo.Hunger / 10000;
            _loc3_ = "";
            _attackPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.attactDetail");
            _defencePbtn.detail = LanguageMgr.GetTranslation("ddt.pets.defenseDetail");
            _agilityPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.agilityDetail");
            _luckPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.luckDetail");
            _HPPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.hpDetail");
            _attackPbtn.propColor = 16774857;
            _defencePbtn.propColor = 16774857;
            _agilityPbtn.propColor = 16774857;
            _luckPbtn.propColor = 16774857;
            _HPPbtn.propColor = 16774857;
            _attackPbtn.valueFilterString = 1;
            _agilityPbtn.valueFilterString = 1;
            _luckPbtn.valueFilterString = 1;
            _HPPbtn.valueFilterString = 1;
            _defencePbtn.valueFilterString = 1;
            if(_loc2_ < 0.8)
            {
               _loc3_ = PetsBagManager.instance().petModel.currentPetInfo.PetHappyStar > 0?LanguageMgr.GetTranslation("ddt.pets.petHappyDesc",PetHappyBar.petPercentArray[PetsBagManager.instance().petModel.currentPetInfo.PetHappyStar]):LanguageMgr.GetTranslation("ddt.pets.petUnFight");
            }
            _attackPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.attactDetail") + _loc3_;
            _defencePbtn.detail = LanguageMgr.GetTranslation("ddt.pets.defenseDetail") + _loc3_;
            _agilityPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.agilityDetail") + _loc3_;
            _luckPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.luckDetail") + _loc3_;
            _HPPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.hpDetail") + _loc3_;
         }
      }
      
      protected function updateSkill() : void
      {
         var _loc2_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc1_:Array = !!_loc2_?_loc2_.skills:[];
         if(_petSkillPnl)
         {
            _petSkillPnl.itemInfo = _loc1_;
         }
      }
      
      protected function disableAllObj() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = 0;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(_loc2_ is InteractiveObject)
            {
               disableObj(_loc2_ as InteractiveObject);
            }
            _loc1_++;
         }
      }
      
      protected function disableObj(param1:InteractiveObject) : void
      {
         param1.mouseEnabled = false;
      }
      
      protected function enableObj(param1:InteractiveObject) : void
      {
         param1.mouseEnabled = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bgPet)
         {
            ObjectUtils.disposeObject(_bgPet);
            _bgPet = null;
         }
         if(_bgSkillPnl)
         {
            ObjectUtils.disposeObject(_bgSkillPnl);
            _bgSkillPnl = null;
         }
         if(_petMoveScroll)
         {
            ObjectUtils.disposeObject(_petMoveScroll);
            _petMoveScroll = null;
         }
         if(_petName)
         {
            ObjectUtils.disposeObject(_petName);
            _petName = null;
         }
         if(_showPet)
         {
            ObjectUtils.disposeObject(_showPet);
            _showPet = null;
         }
         if(_happyBarPet)
         {
            ObjectUtils.disposeObject(_happyBarPet);
            _happyBarPet = null;
         }
         if(_petExpProgress)
         {
            ObjectUtils.disposeObject(_petExpProgress);
            _petExpProgress = null;
         }
         if(_petSkillPnl)
         {
            ObjectUtils.disposeObject(_petSkillPnl);
            _petSkillPnl = null;
         }
         if(_attackPbtn)
         {
            ObjectUtils.disposeObject(_attackPbtn);
            _attackPbtn = null;
         }
         if(_defencePbtn)
         {
            ObjectUtils.disposeObject(_defencePbtn);
            _defencePbtn = null;
         }
         if(_HPPbtn)
         {
            ObjectUtils.disposeObject(_HPPbtn);
            _HPPbtn = null;
         }
         if(_agilityPbtn)
         {
            ObjectUtils.disposeObject(_agilityPbtn);
            _agilityPbtn = null;
         }
         if(_luckPbtn)
         {
            ObjectUtils.disposeObject(_luckPbtn);
            _luckPbtn = null;
         }
         if(_fightBtn)
         {
            ObjectUtils.disposeObject(_fightBtn);
            _fightBtn = null;
         }
         if(_petSkillLbl)
         {
            ObjectUtils.disposeObject(_petSkillLbl);
            _petSkillLbl = null;
         }
         if(_downArowText)
         {
            ObjectUtils.disposeObject(_downArowText);
            _downArowText = null;
         }
         if(_downArowImg)
         {
            ObjectUtils.disposeObject(_downArowImg);
            _downArowImg = null;
         }
         _infoPlayer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
