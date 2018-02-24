package store.fineStore.view.pageBringUp.evolution
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.IconLayer;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   import store.FineEvolutionManager;
   import store.StoreController;
   import store.data.EvolutionData;
   import store.data.StoreModel;
   import store.events.StoreDargEvent;
   import store.fineStore.view.pageBringUp.IObserver;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagController;
   
   public class FineEvolutionView extends Sprite implements Disposeable, IObserver
   {
       
      
      private var _leftBg:MovieClip;
      
      private var _bgCell:Bitmap;
      
      private var _progressBar:MovieClip;
      
      private var _evolutionUpCell:EvolutionUpCell;
      
      private var _lvImage:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _disBg:ScaleBitmapImage;
      
      private var _disI:FilterFrameText;
      
      private var _disII:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _lockSelectBtn:BaseButton;
      
      private var _one_button_evolution:BaseButton;
      
      private var _evolutionBtn:BaseButton;
      
      private var _controller:StoreBagController;
      
      private var _mouseLockImg:Sprite;
      
      private var _view:DisplayObject;
      
      private var _leftDrapSprite:FineEvolutionUpLeftDragPanel;
      
      private var _rightDrapSprite:FineEvolutionUpRightFragPanel;
      
      private var _progressTxt:FilterFrameText;
      
      private var _isEatStatus:Boolean;
      
      private var _usingEatMouse:Boolean = false;
      
      private var _mouseEatImg:Sprite;
      
      private var _upgrade:MovieClip;
      
      private var _helpBtn:BaseButton;
      
      private var lastinfo:InventoryItemInfo;
      
      public function FineEvolutionView(param1:StoreController){super();}
      
      public function get isEatStatus() : Boolean{return false;}
      
      public function set isEatStatus(param1:Boolean) : void{}
      
      private function changeEatState(param1:Boolean) : void{}
      
      private function createAcceptDragSprite() : void{}
      
      public function initEvent() : void{}
      
      private function __socketEvolutionHander(param1:PkgEvent) : void{}
      
      private function __lockClickHandler(param1:MouseEvent) : void{}
      
      private function lockStatusChange() : void{}
      
      protected function onLockMouseClick(param1:MouseEvent) : void{}
      
      private function __evolutionAllHandler(param1:MouseEvent) : void{}
      
      private function __evolutionHandler(param1:MouseEvent) : void{}
      
      private function eatStatusChange() : void{}
      
      protected function onEatMouseClick(param1:MouseEvent) : void{}
      
      private function onEatClick(param1:InventoryItemInfo) : void{}
      
      public function removeEvent() : void{}
      
      private function playerGradeMc() : void{}
      
      private function __enterFrameHandler(param1:Event) : void{}
      
      private function __updateInventorySlot(param1:BagEvent) : void{}
      
      private function upDataDisTxt(param1:InventoryItemInfo) : void{}
      
      private function __cellDoubleClick(param1:CellEvent) : void{}
      
      public function dragDrop(param1:BagCell) : void{}
      
      private function cellClickHandler(param1:CellEvent) : void{}
      
      private function startShine(param1:StoreDargEvent) : void{}
      
      private function stopShine(param1:StoreDargEvent) : void{}
      
      public function update(param1:Object) : void{}
      
      public function dispose() : void{}
   }
}
