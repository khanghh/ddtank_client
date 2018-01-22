package ddt.view.caddyII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class CaddyBagView extends Sprite implements Disposeable
   {
      
      public static const NUMBER:int = 5;
      
      public static const SUM_NUMBER:int = 25;
      
      public static const NULL_CELL_POINT:String = "send_nullCell_poing";
      
      public static const GET_GOODSINFO:String = "caddy_get_goodsinfo";
       
      
      private var _bg:MutipleImage;
      
      private var _list:SimpleTileList;
      
      protected var _sellAllBtn:BaseButton;
      
      protected var _getAllBtn:BaseButton;
      
      private var _openAll:SimpleBitmapButton;
      
      protected var _node:FilterFrameText;
      
      private var _convertedBtn:BaseButton;
      
      private var _node1:FilterFrameText;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _exchangeTxt:FilterFrameText;
      
      private var _numBg:Image;
      
      private var _exchengBg:Bitmap;
      
      private var _haveExchange:FilterFrameText;
      
      private var _CaddyInfo:CaddyInfo;
      
      private var isConver:Boolean = false;
      
      private var isAlert:Boolean = false;
      
      private var _selectPlace:int = 0;
      
      private var _bg2:MovieImage;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _items:Vector.<CaddyCell>;
      
      public function CaddyBagView(){super();}
      
      protected function initView() : void{}
      
      protected function initEvents() : void{}
      
      private function _getConverteds(param1:PkgEvent) : void{}
      
      private function _getexchange(param1:PkgEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      private function _exchangeHandler(param1:MouseEvent) : void{}
      
      private function _convertedHandler(param1:MouseEvent) : void{}
      
      private function _responseIII(param1:FrameEvent) : void{}
      
      protected function __openAllHandler(param1:MouseEvent) : void{}
      
      private function _responseIV(param1:FrameEvent) : void{}
      
      protected function removeEvents() : void{}
      
      private function __changeBadLuckNumber(param1:PlayerPropertyEvent) : void{}
      
      private function _getAll(param1:MouseEvent) : void{}
      
      private function _sellAll(param1:MouseEvent) : void{}
      
      public function getSellAllPriceString() : String{return null;}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      public function _update(param1:BagEvent) : void{}
      
      public function __itemClick(param1:CellEvent) : void{}
      
      private function _getBagType(param1:InventoryItemInfo) : int{return 0;}
      
      public function findCell() : void{}
      
      public function addCell() : void{}
      
      public function checkCell() : Boolean{return false;}
      
      public function get sellBtn() : BaseButton{return null;}
      
      public function get exchangeBtn() : BaseButton{return null;}
      
      public function get getAllBtn() : BaseButton{return null;}
      
      public function dispose() : void{}
   }
}
