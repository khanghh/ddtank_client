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
         var _loc1_:PetInfo = _currentPet;
         _petName.text = !!_loc1_?_loc1_.Name:"";
         _petExpProgress.setProgress(!!_loc1_?_loc1_.GP:0,!!_loc1_?_loc1_.MaxGP:0);
         updatePetsPropByEvolution();
         _happyBarPet.info = _loc1_;
         updateSkill();
         updateProperByPetStatus();
         updatePetSatiation();
         _showPet.update2(_loc1_);
      }
      
      override protected function __onChange(param1:Event) : void
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
         var _loc1_:PetInfo = _currentPet;
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
      
      override protected function updatePetSatiation() : void
      {
         var _loc1_:int = 0;
         if(PetsBagManager.instance().petModel && _currentPet)
         {
            _loc1_ = _currentPet.PetHappyStar;
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
      
      override protected function updateSkill() : void
      {
         var _loc2_:PetInfo = _currentPet;
         var _loc1_:Array = !!_loc2_?_loc2_.skills:[];
         if(_petSkillPnl)
         {
            _petSkillPnl.itemInfo = _loc1_;
         }
      }
      
      override protected function updateProperByPetStatus(param1:Boolean = true) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         updatePropertyTip();
         if(_currentPet)
         {
            _loc2_ = _currentPet.Hunger / 10000;
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
               _loc3_ = _currentPet.PetHappyStar > 0?LanguageMgr.GetTranslation("ddt.pets.petHappyDesc",PetHappyBar.petPercentArray[_currentPet.PetHappyStar]):LanguageMgr.GetTranslation("ddt.pets.petUnFight");
            }
            _attackPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.attactDetail") + _loc3_;
            _defencePbtn.detail = LanguageMgr.GetTranslation("ddt.pets.defenseDetail") + _loc3_;
            _agilityPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.agilityDetail") + _loc3_;
            _luckPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.luckDetail") + _loc3_;
            _HPPbtn.detail = LanguageMgr.GetTranslation("ddt.pets.hpDetail") + _loc3_;
         }
      }
      
      override public function dispose() : void
      {
         PetsBagManager.instance().isOtherPetViewOpen = false;
         super.dispose();
      }
   }
}
