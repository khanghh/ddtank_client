package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.AwakenEquipInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import road7th.comm.PackageIn;
   
   public class PetsAwakenView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _petsBasicInfoView:PetsBasicInfoView;
      
      private var _prbabilityTxt:FilterFrameText;
      
      private var _awakenBtn:BaseButton;
      
      private var _stoneCell:PetsAwakenEquipCell;
      
      private var _equipCell:PetsAwakenEquipCell;
      
      private var _equipInfoCell:PetsAwakenInfoCell;
      
      private var _equipCellList:PetsAwakenEquipList;
      
      private var _clickDate:Number = 0;
      
      public function PetsAwakenView(){super();}
      
      protected function initView() : void{}
      
      private function updateCount() : void{}
      
      private function checkAwakenBtnEnable() : void{}
      
      private function getItemCount(param1:int) : int{return 0;}
      
      protected function initEvent() : void{}
      
      protected function removeEvent() : void{}
      
      private function __removeEquipHandler(param1:InteractiveEvent) : void{}
      
      private function __equipClickDragHandler(param1:InteractiveEvent) : void{}
      
      private function __equipDataChangeHandler(param1:Event) : void{}
      
      private function _updateEquipHandler(param1:BagEvent) : void{}
      
      private function updateAwakenSuccessItemInfo() : void{}
      
      private function __petAwakenResultHandler(param1:PkgEvent) : void{}
      
      private function updateAwakenEquipList(param1:AwakenEquipInfo) : void{}
      
      private function __sendPetsAwakentHandler(param1:MouseEvent) : void{}
      
      protected function __cellClickHandler(param1:CellEvent) : void{}
      
      protected function __cellDoubleClickHandler(param1:CellEvent) : void{}
      
      protected function __allComplete(param1:Event) : void{}
      
      protected function updateData() : void{}
      
      protected function updateEquipList() : void{}
      
      private function createTempleteInfo(param1:int) : InventoryItemInfo{return null;}
      
      private function clearHideBagItem() : void{}
      
      public function dispose() : void{}
   }
}
