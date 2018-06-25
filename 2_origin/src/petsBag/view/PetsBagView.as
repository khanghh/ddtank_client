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
      
      public function set infoPlayer(value:PlayerInfo) : void
      {
         if(_infoPlayer == value)
         {
            return;
         }
         _infoPlayer = value;
         if(!_infoPlayer)
         {
            return;
         }
         _petMoveScroll.infoPlayer = _infoPlayer;
         PetsBagManager.instance().petModel.currentPetInfo = getFirstPet(_infoPlayer);
         _currentPet = PetsBagManager.instance().petModel.currentPetInfo;
         updatePetBagView();
      }
      
      public function playShined(type:int) : void
      {
         _showPet.getBagCell(type).shinePlay();
      }
      
      public function stopShined(type:int) : void
      {
         _showPet.getBagCell(type).shineStop();
      }
      
      protected function getFirstPet(player:PlayerInfo) : PetInfo
      {
         var resultPet:* = null;
         var i:int = 0;
         if(player.currentPet)
         {
            resultPet = player.currentPet;
         }
         else
         {
            i = 0;
            while(i < player.pets.length)
            {
               if(player.pets[i])
               {
                  return player.pets[i];
               }
               i++;
            }
         }
         return resultPet;
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
      
      protected function __evolutionSuccessHandler(event:Event) : void
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
      
      protected function __onChange(event:Event) : void
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
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         _petName.text = !!currentPet?currentPet.Name:"";
         _petExpProgress.setProgress(!!currentPet?currentPet.GP:0,!!currentPet?currentPet.MaxGP:0);
         updatePetsPropByEvolution();
         _happyBarPet.info = currentPet;
         updateSkill();
         updateProperByPetStatus();
         updatePetSatiation();
         ShowPet.isPetEquip = false;
         _showPet.update();
      }
      
      public function updatePetsPropByEvolution() : void
      {
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc4_:int = 0;
         var _loc3_:* = PetsAdvancedManager.Instance.evolutionDataList;
         for each(var info in PetsAdvancedManager.Instance.evolutionDataList)
         {
            if(_infoPlayer.evolutionGrade == 0)
            {
               _currentGradeInfo = new PetFightPropertyData();
               break;
            }
            if(info.ID == _infoPlayer.evolutionGrade)
            {
               _currentGradeInfo = info;
               break;
            }
         }
         if(!_currentGradeInfo)
         {
            _currentGradeInfo = new PetFightPropertyData();
         }
         if(currentPet)
         {
            _attackPbtn.propValue = currentPet.Attack + _currentGradeInfo.Attack + getValueByType("attack") + getPetsEatValueByType("attack");
            _defencePbtn.propValue = currentPet.Defence + _currentGradeInfo.Defence + getValueByType("defence") + getPetsEatValueByType("defence");
            _HPPbtn.propValue = currentPet.Blood + _currentGradeInfo.Blood + getValueByType("hp") + getPetsEatValueByType("hp");
            _agilityPbtn.propValue = currentPet.Agility + _currentGradeInfo.Agility + getValueByType("agility") + getPetsEatValueByType("agility");
            _luckPbtn.propValue = currentPet.Luck + _currentGradeInfo.Lucky + getValueByType("luck") + getPetsEatValueByType("luck");
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
      
      public function getValueByType(type:String) : int
      {
         var i:int = 0;
         var data:* = null;
         var newInfo:* = null;
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var hp:int = 0;
         var agility:int = 0;
         var attack:int = 0;
         var defence:int = 0;
         var luck:int = 0;
         for(i = 0; i < 3; )
         {
            data = currentPet.equipList[i];
            if(data)
            {
               newInfo = ItemManager.fill(data) as InventoryItemInfo;
               hp = hp + newInfo.Boold;
               agility = agility + newInfo.Agility;
               attack = attack + newInfo.Attack;
               defence = defence + newInfo.Defence;
               luck = luck + newInfo.Luck;
            }
            i++;
         }
         var _loc11_:* = type;
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
                     return luck;
                  }
                  return agility;
               }
               return defence;
            }
            return attack;
         }
         return hp;
      }
      
      public function getPetsEatValueByType(type:String) : int
      {
         var i:int = 0;
         var data:* = null;
         var newInfo:* = null;
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var hp:int = 0;
         var agility:int = 0;
         var attack:int = 0;
         var defence:int = 0;
         var luck:int = 0;
         for(i = 0; i < 3; )
         {
            data = currentPet.equipList[i];
            if(data)
            {
               newInfo = ItemManager.fill(data) as InventoryItemInfo;
               switch(int(i))
               {
                  case 0:
                     if(_infoPlayer.petsEatWeaponLevel == 0)
                     {
                        luck = 0;
                        attack = 0;
                     }
                     else
                     {
                        attack = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatWeaponLevel - 1].Attack;
                        luck = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatWeaponLevel - 1].Lucky;
                     }
                     break;
                  case 1:
                     if(_infoPlayer.petsEatHatLevel == 0)
                     {
                        defence = 0;
                     }
                     else
                     {
                        defence = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatHatLevel - 1].Defence;
                     }
                     break;
                  case 2:
                     if(_infoPlayer.petsEatClothesLevel == 0)
                     {
                        hp = 0;
                        agility = 0;
                        break;
                     }
                     agility = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatClothesLevel - 1].Agility;
                     hp = PetsAdvancedManager.Instance.petMoePropertyList[_infoPlayer.petsEatClothesLevel - 1].Blood;
                     break;
               }
            }
            i++;
         }
         var _loc11_:* = type;
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
                     return luck;
                  }
                  return agility;
               }
               return defence;
            }
            return attack;
         }
         return hp;
      }
      
      public function addPetEquip(date:InventoryItemInfo) : void
      {
         _showPet.addPetEquip(date);
         updatePropertyTip();
         updatePetsPropByEvolution();
      }
      
      public function delPetEquip(petIndex:int, type:int) : void
      {
         _showPet.delPetEquip(type);
         updatePropertyTip();
         updatePetsPropByEvolution();
      }
      
      protected function updatePetSatiation() : void
      {
         var petHappyStar:int = 0;
         if(PetsBagManager.instance().petModel && PetsBagManager.instance().petModel.currentPetInfo)
         {
            petHappyStar = PetsBagManager.instance().petModel.currentPetInfo.PetHappyStar;
            if(_currentPetHappyStar != petHappyStar)
            {
               if(_downArowText)
               {
                  ObjectUtils.disposeObject(_downArowText);
               }
               _downArowText = null;
               if(petHappyStar == 1 || petHappyStar == 2)
               {
                  _downArowText = ComponentFactory.Instance.creatBitmap("assets.petsBag.downArowText" + _downArowTextData[petHappyStar]);
                  _downArowText.x = _downArowImg.x + (_downArowImg.width - _downArowText.width) / 2;
                  _downArowText.y = _downArowImg.y + _downArowImg.height;
                  addChild(_downArowText);
                  setDownArowVisible(true);
               }
               else
               {
                  setDownArowVisible(false);
               }
               _currentPetHappyStar = petHappyStar;
            }
         }
         else
         {
            setDownArowVisible(false);
         }
      }
      
      protected function setDownArowVisible(value:Boolean) : void
      {
         if(_downArowImg)
         {
            _downArowImg.visible = value;
         }
      }
      
      protected function updateProperByPetStatus(isNomal:Boolean = true) : void
      {
         var currentPercent:Number = NaN;
         var addTipDesc:* = null;
         updatePropertyTip();
         if(PetsBagManager.instance().petModel.currentPetInfo)
         {
            currentPercent = PetsBagManager.instance().petModel.currentPetInfo.Hunger / 10000;
            addTipDesc = "";
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
            if(currentPercent < 0.8)
            {
               addTipDesc = PetsBagManager.instance().petModel.currentPetInfo.PetHappyStar > 0?LanguageMgr.GetTranslation("ddt.pets.petHappyDesc",PetHappyBar.petPercentArray[PetsBagManager.instance().petModel.currentPetInfo.PetHappyStar]):LanguageMgr.GetTranslation("ddt.pets.petUnFight");
            }
            _attackPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.attactDetail") + addTipDesc;
            _defencePbtn.detail = LanguageMgr.GetTranslation("ddt.pets.defenseDetail") + addTipDesc;
            _agilityPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.agilityDetail") + addTipDesc;
            _luckPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.luckDetail") + addTipDesc;
            _HPPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.hpDetail") + addTipDesc;
         }
      }
      
      protected function updateSkill() : void
      {
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var petSkillAll:Array = !!currentPet?currentPet.skills:[];
         if(_petSkillPnl)
         {
            _petSkillPnl.itemInfo = petSkillAll;
         }
      }
      
      protected function disableAllObj() : void
      {
         var index:int = 0;
         var childObj:* = null;
         for(index = 0; index < this.numChildren; )
         {
            childObj = getChildAt(index);
            if(childObj is InteractiveObject)
            {
               disableObj(childObj as InteractiveObject);
            }
            index++;
         }
      }
      
      protected function disableObj(obj:InteractiveObject) : void
      {
         obj.mouseEnabled = false;
      }
      
      protected function enableObj(obj:InteractiveObject) : void
      {
         obj.mouseEnabled = true;
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
