package petsBag.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.alert.SimpleAlert;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.PetconfigAnalyzer;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.HelpBtnEnable;   import ddtBuried.BuriedManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import pet.data.PetInfo;   import pet.sprite.PetSpriteManager;   import petsBag.PetsBagManager;   import petsBag.petsAdvanced.PetsAdvancedManager;   import petsBag.view.item.FeedItem;   import petsBag.view.item.StarBar;   import road7th.data.DictionaryEvent;   import road7th.utils.StringHelper;   import store.HelpFrame;      public class PetsBagOutView extends PetsBagView   {                   private var _rePetNameBtn:TextButton;            private var _revertPetBtn:TextButton;            private var _washBoneBtn:TextButton;            private var _feedItem:FeedItem;            private var _releaseBtn:TextButton;            private var _unFightBtn:TextButton;            private var _petGameSkillPnl:PetGameSkillPnl;            private var _fightSkillLbl:FilterFrameText;            private var _bg2:Bitmap;            private var _feedBtn:TextButton;            private var _groomBtn:SimpleBitmapButton;            public function PetsBagOutView() { super(); }
            override protected function initView() : void { }
            private function petFarmGuilde() : void { }
            private function petCultrueGuilde() : void { }
            private function removeAllPetCultrueGuilde() : void { }
            override protected function initEvent() : void { }
            private function __washBonePet(evt:MouseEvent) : void { }
            override protected function __onChange(event:Event) : void { }
            override public function set infoPlayer(value:PlayerInfo) : void { }
            override public function updatePetBagView() : void { }
            private function updateGameSkill() : void { }
            private function addInfoChangeEvent() : void { }
            private function removeInfoChangeEvent() : void { }
            private function __updateInfoChange(e:DictionaryEvent) : void { }
            private function __rePetName(e:MouseEvent) : void { }
            protected function __AlertRePetNameResponse(evt:FrameEvent) : void { }
            protected function __revertPet(event:MouseEvent) : void { }
            protected function __alertRevertPet(event:FrameEvent) : void { }
            protected function __revertPetCostConfirm(event:FrameEvent) : void { }
            protected function onCheckComplete2() : void { }
            private function __releasePet(e:MouseEvent) : void { }
            private function __alertReleasePet(event:FrameEvent) : void { }
            private function __alertReleasePet3(event:FrameEvent) : void { }
            private function __unFight(e:MouseEvent) : void { }
            private function __fight(e:MouseEvent) : void { }
            private function switchFightUnFight(bool:Boolean = true) : void { }
            private function __feedPet(e:MouseEvent) : void { }
            private function isCanFeed(_info:InventoryItemInfo) : Boolean { return false; }
            private function needMaxFoods(hunger:int, addHunger:int) : int { return 0; }
            public function startShine() : void { }
            public function stopShine() : void { }
            public function clearInfo() : void { }
            private function __help(e:MouseEvent) : void { }
            private function __groomPet(event:MouseEvent) : void { }
            private function __closeHandler(evt:Event) : void { }
            private function __addPet_upGrade_evolution_eat(e:Event) : void { }
            override protected function removeEvent() : void { }
            public function getUnLockItemIndex() : int { return 0; }
            override public function dispose() : void { }
   }}