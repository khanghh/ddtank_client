package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import beadSystem.beadSystemManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BaseStripView extends Sprite implements Disposeable
   {
       
      
      protected var _info:AuctionGoodsInfo;
      
      protected var _state:int;
      
      private var _isSelect:Boolean;
      
      private var _cell:AuctionCellViewII;
      
      protected var _name:FilterFrameText;
      
      protected var _count:FilterFrameText;
      
      protected var _leftTime:FilterFrameText;
      
      private var _cleared:Boolean;
      
      protected var stripSelect_bit:Scale9CornerImage;
      
      protected var back_mc:Bitmap;
      
      protected var leftBG:ScaleLeftRightImage;
      
      public function BaseStripView(){super();}
      
      protected function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      function get info() : AuctionGoodsInfo{return null;}
      
      function set info(param1:AuctionGoodsInfo) : void{}
      
      function get isSelect() : Boolean{return false;}
      
      function set isSelect(param1:Boolean) : void{}
      
      function clearSelectStrip() : void{}
      
      private function update() : void{}
      
      protected function updateInfo() : void{}
      
      override public function set height(param1:Number) : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
