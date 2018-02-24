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
      
      public function PetsBagView(){super();}
      
      public function set infoPlayer(param1:PlayerInfo) : void{}
      
      public function playShined(param1:int) : void{}
      
      public function stopShined(param1:int) : void{}
      
      protected function getFirstPet(param1:PlayerInfo) : PetInfo{return null;}
      
      protected function initView() : void{}
      
      protected function initEvent() : void{}
      
      protected function __evolutionSuccessHandler(param1:Event) : void{}
      
      protected function removeEvent() : void{}
      
      protected function __onChange(param1:Event) : void{}
      
      public function get hasPet() : Boolean{return false;}
      
      public function updatePetBagView() : void{}
      
      public function updatePetsPropByEvolution() : void{}
      
      protected function updatePropertyTip() : void{}
      
      public function getValueByType(param1:String) : int{return 0;}
      
      public function getPetsEatValueByType(param1:String) : int{return 0;}
      
      public function addPetEquip(param1:InventoryItemInfo) : void{}
      
      public function delPetEquip(param1:int, param2:int) : void{}
      
      protected function updatePetSatiation() : void{}
      
      protected function setDownArowVisible(param1:Boolean) : void{}
      
      protected function updateProperByPetStatus(param1:Boolean = true) : void{}
      
      protected function updateSkill() : void{}
      
      protected function disableAllObj() : void{}
      
      protected function disableObj(param1:InteractiveObject) : void{}
      
      protected function enableObj(param1:InteractiveObject) : void{}
      
      public function dispose() : void{}
   }
}
