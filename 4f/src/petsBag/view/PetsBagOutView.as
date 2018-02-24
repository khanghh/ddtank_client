package petsBag.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpBtnEnable;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import pet.sprite.PetSpriteManager;
   import petsBag.PetsBagManager;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import petsBag.view.item.FeedItem;
   import road7th.data.DictionaryEvent;
   import road7th.utils.StringHelper;
   import store.HelpFrame;
   
   public class PetsBagOutView extends PetsBagView
   {
       
      
      private var _rePetNameBtn:TextButton;
      
      private var _revertPetBtn:TextButton;
      
      private var _feedItem:FeedItem;
      
      private var _releaseBtn:TextButton;
      
      private var _unFightBtn:TextButton;
      
      private var _petGameSkillPnl:PetGameSkillPnl;
      
      private var _fightSkillLbl:FilterFrameText;
      
      private var _bg2:Bitmap;
      
      private var _feedBtn:TextButton;
      
      private var _groomBtn:SimpleBitmapButton;
      
      public function PetsBagOutView(){super();}
      
      override protected function initView() : void{}
      
      private function petFarmGuilde() : void{}
      
      private function petCultrueGuilde() : void{}
      
      private function removeAllPetCultrueGuilde() : void{}
      
      override protected function initEvent() : void{}
      
      override protected function __onChange(param1:Event) : void{}
      
      override public function set infoPlayer(param1:PlayerInfo) : void{}
      
      override public function updatePetBagView() : void{}
      
      private function updateGameSkill() : void{}
      
      private function addInfoChangeEvent() : void{}
      
      private function removeInfoChangeEvent() : void{}
      
      private function __updateInfoChange(param1:DictionaryEvent) : void{}
      
      private function __rePetName(param1:MouseEvent) : void{}
      
      protected function __AlertRePetNameResponse(param1:FrameEvent) : void{}
      
      protected function __revertPet(param1:MouseEvent) : void{}
      
      protected function __alertRevertPet(param1:FrameEvent) : void{}
      
      protected function __revertPetCostConfirm(param1:FrameEvent) : void{}
      
      protected function onCheckComplete2() : void{}
      
      private function __releasePet(param1:MouseEvent) : void{}
      
      private function __alertReleasePet(param1:FrameEvent) : void{}
      
      private function __alertReleasePet3(param1:FrameEvent) : void{}
      
      private function __unFight(param1:MouseEvent) : void{}
      
      private function __fight(param1:MouseEvent) : void{}
      
      private function switchFightUnFight(param1:Boolean = true) : void{}
      
      private function __feedPet(param1:MouseEvent) : void{}
      
      private function isCanFeed(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function needMaxFoods(param1:int, param2:int) : int{return 0;}
      
      public function startShine() : void{}
      
      public function stopShine() : void{}
      
      public function clearInfo() : void{}
      
      private function __help(param1:MouseEvent) : void{}
      
      private function __groomPet(param1:MouseEvent) : void{}
      
      private function __closeHandler(param1:Event) : void{}
      
      private function __addPet_upGrade_evolution_eat(param1:Event) : void{}
      
      override protected function removeEvent() : void{}
      
      public function getUnLockItemIndex() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
