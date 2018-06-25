package petsBag.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.events.Event;   import pet.data.PetInfo;   import petsBag.PetsBagManager;   import petsBag.data.PetFightPropertyData;   import petsBag.petsAdvanced.PetsAdvancedManager;      public class PetsBagOtherView extends PetsBagView   {                   public function PetsBagOtherView() { super(); }
            override protected function initView() : void { }
            override public function updatePetBagView() : void { }
            override protected function __onChange(event:Event) : void { }
            override public function updatePetsPropByEvolution() : void { }
            override protected function updatePetSatiation() : void { }
            override protected function updateSkill() : void { }
            override protected function updateProperByPetStatus(isNomal:Boolean = true) : void { }
            override public function dispose() : void { }
   }}