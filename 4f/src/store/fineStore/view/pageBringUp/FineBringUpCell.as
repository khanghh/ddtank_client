package store.fineStore.view.pageBringUp
{
   import bagAndInfo.cell.LockableBagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   
   public class FineBringUpCell extends LockableBagCell
   {
       
      
      private var _observer:IObserver;
      
      private var _text:FilterFrameText;
      
      private var _latentEnergyItemId:int;
      
      private var _lastLevel:int;
      
      public function FineBringUpCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      public function get lastLevel() : int{return 0;}
      
      public function set latentEnergyItemId(param1:int) : void{}
      
      override public function get tipStyle() : String{return null;}
      
      public function register(param1:IObserver) : void{}
      
      override protected function addEnchantMc() : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override protected function initEvent() : void{}
      
      private function equipMoveHandler(param1:LatentEnergyEvent) : void{}
      
      private function equipMoveHandler2(param1:LatentEnergyEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      public function clearInfo() : void{}
      
      override public function dispose() : void{}
   }
}
