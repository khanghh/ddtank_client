package ddt.view.caddyII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.badLuck.BadLuckView;
   import ddt.view.caddyII.badLuck.BlessLuckView;
   import ddt.view.caddyII.card.CardViewII;
   import ddt.view.caddyII.reader.CaddyUpdate;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class CaddyFrame extends Frame
   {
      
      public static const VerticalOffset:int = -50;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _view:RightView;
      
      private var _bag:CaddyBagView;
      
      private var _reader:CaddyUpdate;
      
      private var _moveSprite:MoveSprite;
      
      private var _closeAble:Boolean = true;
      
      private var _itemInfo:ItemTemplateInfo;
      
      private var _type:int;
      
      private var _caddyAwardCount:int = 0;
      
      private var _closed:Boolean = false;
      
      private var _selectInfo:InventoryItemInfo;
      
      public function CaddyFrame(param1:int, param2:ItemTemplateInfo = null){super();}
      
      public function setCaddyType(param1:int) : void{}
      
      public function setBeadType(param1:int) : void{}
      
      public function setOfferType(param1:int) : void{}
      
      public function setCardType(param1:int, param2:int) : void{}
      
      private function initView(param1:int) : void{}
      
      private function initEvents() : void{}
      
      private function __updateInfo(param1:PkgEvent) : void{}
      
      private function __lotteryOpen(param1:PkgEvent) : void{}
      
      private function __buyBeads(param1:Event) : void{}
      
      private function getOpenBeadType(param1:int) : int{return 0;}
      
      private function removeEvents() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function _showCloseAlert() : void{}
      
      private function _questCellPoint(param1:Event) : void{}
      
      private function _turnComplete(param1:Event) : void{}
      
      private function _moveComplete(param1:Event) : void{}
      
      private function _startTurn(param1:CaddyEvent) : void{}
      
      public function turnComplete(param1:Event) : void{}
      
      private function _startMove(param1:Event) : void{}
      
      private function _getCellPoint(param1:CaddyEvent) : void{}
      
      private function _getGoodsInfo(param1:CaddyEvent) : void{}
      
      public function show() : void{}
      
      public function set closeAble(param1:Boolean) : void{}
      
      public function get closeAble() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
