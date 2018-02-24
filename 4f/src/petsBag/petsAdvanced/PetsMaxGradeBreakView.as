package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.BreakInfo;
   import petsBag.view.item.PetSmallDetailItem;
   
   public class PetsMaxGradeBreakView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _petsBasicInfoView:PetsBasicInfoView;
      
      private var _petsImgVec:Vector.<PetSmallDetailItem>;
      
      private var selectList:Array;
      
      private var itemContainer:HBox;
      
      private var _bagCellBreak:FilterFrameText;
      
      private var _bagCellBg:Bitmap;
      
      private var _bagCellProtect:PetsAdvancedCell;
      
      private var _checkBoxProtect:SelectedCheckButton;
      
      private var _btnEatPets:SimpleBitmapButton;
      
      private var _petInfo:PlayerInfo;
      
      private var _txtBreakCurGradeInfo:FilterFrameText;
      
      private var _txtDetail:FilterFrameText;
      
      private var _txtWarnning:FilterFrameText;
      
      private var _petBreakFrame:PetsBreakAnimationFrame;
      
      private var sucTip:Bitmap;
      
      private var failTip:Bitmap;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var currentPage:int = 1;
      
      private var totalPage:int;
      
      public function PetsMaxGradeBreakView(){super();}
      
      protected function update(param1:Event) : void{}
      
      protected function onPetInfoChange(param1:Event) : void{}
      
      protected function initView() : void{}
      
      protected function onPetsCellUpdated(param1:Event) : void{}
      
      private function __left(param1:MouseEvent) : void{}
      
      private function __right(param1:MouseEvent) : void{}
      
      protected function onBreakResult(param1:Event) : void{}
      
      protected function onCellClick(param1:MouseEvent) : void{}
      
      public function set btnEatPetsEnable(param1:Boolean) : void{}
      
      public function set valueOfTotalSelected(param1:int) : void{}
      
      public function get valueOfTotalSelected() : int{return 0;}
      
      public function get valueOfPetsImgVec() : Vector.<PetSmallDetailItem>{return null;}
      
      protected function useProtectHander(param1:MouseEvent) : void{}
      
      protected function onBtnEatClick(param1:MouseEvent) : void{}
      
      private function showBreakFrame() : void{}
      
      protected function __onAlertRiseStarResponse(param1:FrameEvent) : void{}
      
      protected function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function getProtectStoneNumber() : int{return 0;}
      
      private function buyProtectStone() : void{}
      
      protected function onBreakClick(param1:MouseEvent) : void{}
      
      private function getNumPetsToEatSelected() : int{return 0;}
      
      private function getPetsStarsEnough(param1:BreakInfo) : Boolean{return false;}
      
      private function petsToEatIsFighting() : Boolean{return false;}
      
      private function getBreakGradeEnough(param1:BreakInfo) : Boolean{return false;}
      
      private function riseStarEver() : Boolean{return false;}
      
      protected function onUpdatePet(param1:CEvent) : void{}
      
      private function countTotalPage() : void{}
      
      private function updateData(param1:int = 1) : void{}
      
      protected function __allComplete(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}

interface IEatState
{
    
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed2PetsClickSelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed2PetsClickSelected(param1:PetsMaxGradeBreakView){super();}
   
   public function onClicked(param1:MouseEvent) : void{}
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed2PetsClickUnelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed2PetsClickUnelected(param1:PetsMaxGradeBreakView){super();}
   
   public function onClicked(param1:MouseEvent) : void{}
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed1PetClickUnselected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed1PetClickUnselected(param1:PetsMaxGradeBreakView){super();}
   
   public function onClicked(param1:MouseEvent) : void{}
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed1PetClickSelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed1PetClickSelected(param1:PetsMaxGradeBreakView){super();}
   
   public function onClicked(param1:MouseEvent) : void{}
}
