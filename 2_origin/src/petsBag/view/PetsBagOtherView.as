package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.PetFightPropertyData;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   
   public class PetsBagOtherView extends PetsBagView
   {
       
      
      public function PetsBagOtherView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _petSkillPnl = ComponentFactory.Instance.creat("petsBag.petSkillPnl",[true]);
         addChild(_petSkillPnl);
         _bgSkillPnl.width = 408;
         _fightBtn.visible = false;
         PetsBagManager.instance().isOtherPetViewOpen = true;
      }
      
      override public function updatePetBagView() : void
      {
         if(!hasPet)
         {
            this.mouseChildren = false;
            disableAllObj();
            _petExpProgress.noPet();
         }
         var currentPet:PetInfo = _currentPet;
         _petName.text = !!currentPet?currentPet.Name:"";
         _petExpProgress.setProgress(!!currentPet?currentPet.GP:0,!!currentPet?currentPet.MaxGP:0);
         updatePetsPropByEvolution();
         _happyBarPet.info = currentPet;
         updateSkill();
         updateProperByPetStatus();
         updatePetSatiation();
         _showPet.update2(currentPet);
      }
      
      override protected function __onChange(event:Event) : void
      {
         _currentPet = PetsBagManager.instance().petModel.currentPetInfo;
         if(_currentPet)
         {
            updatePetBagView();
         }
         _petMoveScroll.updateSelect();
      }
      
      override public function updatePetsPropByEvolution() : void
      {
         var currentPet:PetInfo = _currentPet;
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
      
      override protected function updatePetSatiation() : void
      {
         var petHappyStar:int = 0;
         if(PetsBagManager.instance().petModel && _currentPet)
         {
            petHappyStar = _currentPet.PetHappyStar;
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
      
      override protected function updateSkill() : void
      {
         var currentPet:PetInfo = _currentPet;
         var petSkillAll:Array = !!currentPet?currentPet.skills:[];
         if(_petSkillPnl)
         {
            _petSkillPnl.itemInfo = petSkillAll;
         }
      }
      
      override protected function updateProperByPetStatus(isNomal:Boolean = true) : void
      {
         var currentPercent:Number = NaN;
         var addTipDesc:* = null;
         updatePropertyTip();
         if(_currentPet)
         {
            currentPercent = _currentPet.Hunger / 10000;
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
               addTipDesc = _currentPet.PetHappyStar > 0?LanguageMgr.GetTranslation("ddt.pets.petHappyDesc",PetHappyBar.petPercentArray[_currentPet.PetHappyStar]):LanguageMgr.GetTranslation("ddt.pets.petUnFight");
            }
            _attackPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.attactDetail") + addTipDesc;
            _defencePbtn.detail = LanguageMgr.GetTranslation("ddt.pets.defenseDetail") + addTipDesc;
            _agilityPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.agilityDetail") + addTipDesc;
            _luckPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.luckDetail") + addTipDesc;
            _HPPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.hpDetail") + addTipDesc;
         }
      }
      
      override public function dispose() : void
      {
         PetsBagManager.instance().isOtherPetViewOpen = false;
         super.dispose();
      }
   }
}
