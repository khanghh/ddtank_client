package petsBag.petsAdvanced{   import baglocked.BaglockedManager;   import com.greensock.TweenMax;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyAlertBase;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.CEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import pet.data.PetInfo;   import petsBag.PetsBagManager;   import petsBag.data.BreakInfo;   import petsBag.view.item.PetSmallDetailItem;      public class PetsMaxGradeBreakView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _petsBasicInfoView:PetsBasicInfoView;            private var _petsImgVec:Vector.<PetSmallDetailItem>;            private var selectList:Array;            private var itemContainer:HBox;            private var _bagCellBreak:FilterFrameText;            private var _bagCellBg:Bitmap;            private var _bagCellProtect:PetsAdvancedCell;            private var _checkBoxProtect:SelectedCheckButton;            private var _btnEatPets:SimpleBitmapButton;            private var _petInfo:PlayerInfo;            private var _txtBreakCurGradeInfo:FilterFrameText;            private var _txtDetail:FilterFrameText;            private var _txtWarnning:FilterFrameText;            private var _petBreakFrame:PetsBreakAnimationFrame;            private var sucTip:Bitmap;            private var failTip:Bitmap;            private var _leftBtn:SimpleBitmapButton;            private var _rightBtn:SimpleBitmapButton;            private var currentPage:int = 1;            private var totalPage:int;            public function PetsMaxGradeBreakView() { super(); }
            protected function update(e:Event) : void { }
            protected function onPetInfoChange(e:Event) : void { }
            protected function initView() : void { }
            protected function onPetsCellUpdated(e:Event) : void { }
            private function __left(e:MouseEvent) : void { }
            private function __right(e:MouseEvent) : void { }
            protected function onBreakResult(e:Event) : void { }
            protected function onCellClick(me:MouseEvent) : void { }
            public function set btnEatPetsEnable(value:Boolean) : void { }
            public function set valueOfTotalSelected(value:int) : void { }
            public function get valueOfTotalSelected() : int { return 0; }
            public function get valueOfPetsImgVec() : Vector.<PetSmallDetailItem> { return null; }
            protected function useProtectHander(e:MouseEvent) : void { }
            protected function onBtnEatClick(e:MouseEvent) : void { }
            private function showBreakFrame() : void { }
            protected function __onAlertRiseStarResponse(event:FrameEvent) : void { }
            protected function __onAlertResponse(evt:FrameEvent) : void { }
            private function getProtectStoneNumber() : int { return 0; }
            private function buyProtectStone() : void { }
            protected function onBreakClick(e:MouseEvent) : void { }
            private function getNumPetsToEatSelected() : int { return 0; }
            private function getPetsStarsEnough(breakInfo:BreakInfo) : Boolean { return false; }
            private function petsToEatIsFighting() : Boolean { return false; }
            private function getBreakGradeEnough(breakInfo:BreakInfo) : Boolean { return false; }
            private function riseStarEver() : Boolean { return false; }
            protected function onUpdatePet(e:CEvent) : void { }
            private function countTotalPage() : void { }
            private function updateData(page:int = 1) : void { }
            protected function __allComplete(event:Event) : void { }
            public function dispose() : void { }
   }}interface IEatState{    }import flash.events.MouseEvent;import petsBag.petsAdvanced.PetsMaxGradeBreakView;import petsBag.view.item.PetSmallDetailItem;class StateNeed2PetsClickSelected implements IEatState{          private var view:PetsMaxGradeBreakView;      function StateNeed2PetsClickSelected($view:PetsMaxGradeBreakView) { super(); }
      public function onClicked(me:MouseEvent) : void { }
}import flash.events.MouseEvent;import petsBag.petsAdvanced.PetsMaxGradeBreakView;import petsBag.view.item.PetSmallDetailItem;class StateNeed2PetsClickUnelected implements IEatState{          private var view:PetsMaxGradeBreakView;      function StateNeed2PetsClickUnelected($view:PetsMaxGradeBreakView) { super(); }
      public function onClicked(me:MouseEvent) : void { }
}import flash.events.MouseEvent;import petsBag.petsAdvanced.PetsMaxGradeBreakView;import petsBag.view.item.PetSmallDetailItem;class StateNeed1PetClickUnselected implements IEatState{          private var view:PetsMaxGradeBreakView;      function StateNeed1PetClickUnselected($view:PetsMaxGradeBreakView) { super(); }
      public function onClicked(me:MouseEvent) : void { }
}import flash.events.MouseEvent;import petsBag.petsAdvanced.PetsMaxGradeBreakView;import petsBag.view.item.PetSmallDetailItem;class StateNeed1PetClickSelected implements IEatState{          private var view:PetsMaxGradeBreakView;      function StateNeed1PetClickSelected($view:PetsMaxGradeBreakView) { super(); }
      public function onClicked(me:MouseEvent) : void { }
}