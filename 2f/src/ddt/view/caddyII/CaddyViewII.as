package ddt.view.caddyII
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.EquipType;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.view.SetsShopView;
   
   public class CaddyViewII extends RightView
   {
      
      public static const NEED_KEY:int = 4;
      
      public static const START_TURN:String = "caddy_start_turn";
      
      public static const START_MOVE_AFTER_TURN:String = "start_move_after_turn";
      
      public static const GOODSNUMBER:int = 25;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGI:MovieImage;
      
      private var _lookBtn:TextButton;
      
      private var _openBtn:BaseButton;
      
      private var _keyBtn:BaseButton;
      
      private var _boxBtn:BaseButton;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _keyNumberTxt:FilterFrameText;
      
      private var _boxNumberTxt:FilterFrameText;
      
      private var _lookTrophy:LookTrophy;
      
      private var _keyNumber:int;
      
      private var _boxNumber:int;
      
      private var _selectedCount:int;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _templateIDList:Vector.<int>;
      
      private var _turn:CaddyTurn;
      
      private var _vipDescTxt:FilterFrameText;
      
      private var _vipIcon:Image;
      
      private var isActive:Boolean = false;
      
      private var hasKey:Boolean = false;
      
      public function CaddyViewII(){super();}
      
      override public function set item(param1:ItemTemplateInfo) : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function __selectedChanged(param1:Event) : void{}
      
      private function __quickBuyMouseOut(param1:MouseEvent) : void{}
      
      private function __quickBuyMouseOver(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function __buyBuff(param1:MouseEvent) : void{}
      
      private function creatShape(param1:Number = 100, param2:Number = 25) : Shape{return null;}
      
      private function _bagUpdate(param1:BagEvent) : void{}
      
      private function _look(param1:MouseEvent) : void{}
      
      private function __openClick(param1:MouseEvent) : void{}
      
      private function hasKeys() : void{}
      
      private function openBoxImp() : void{}
      
      private function _quickBuy() : void{}
      
      private function _buyKey(param1:MouseEvent) : void{}
      
      private function _buyBox(param1:MouseEvent) : void{}
      
      private function _showQuickBuy(param1:int) : void{}
      
      private function _turnComplete(param1:Event) : void{}
      
      private function againImp() : void{}
      
      override public function again() : void{}
      
      public function set keyNumber(param1:int) : void{}
      
      public function get keyNumber() : int{return 0;}
      
      public function set boxNumber(param1:int) : void{}
      
      public function get boxNumber() : int{return 0;}
      
      override public function setSelectGoodsInfo(param1:InventoryItemInfo) : void{}
      
      private function _startTurn() : void{}
      
      private function getRandomTempId() : void{}
      
      override public function get openBtnEnable() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
