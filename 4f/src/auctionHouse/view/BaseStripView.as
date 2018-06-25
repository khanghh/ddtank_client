package auctionHouse.view{   import auctionHouse.event.AuctionHouseEvent;   import beadSystem.beadSystemManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleLeftRightImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.auctionHouse.AuctionGoodsInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class BaseStripView extends Sprite implements Disposeable   {                   protected var _info:AuctionGoodsInfo;            protected var _state:int;            private var _isSelect:Boolean;            private var _cell:AuctionCellViewII;            protected var _name:FilterFrameText;            protected var _count:FilterFrameText;            protected var _leftTime:FilterFrameText;            private var _cleared:Boolean;            protected var stripSelect_bit:Scale9CornerImage;            protected var back_mc:Bitmap;            protected var leftBG:ScaleLeftRightImage;            public function BaseStripView() { super(); }
            protected function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            protected function get info() : AuctionGoodsInfo { return null; }
            protected function set info(value:AuctionGoodsInfo) : void { }
            protected function get isSelect() : Boolean { return false; }
            protected function set isSelect(value:Boolean) : void { }
            protected function clearSelectStrip() : void { }
            private function update() : void { }
            protected function updateInfo() : void { }
            override public function set height(value:Number) : void { }
            private function __over(event:MouseEvent) : void { }
            private function __out(event:MouseEvent) : void { }
            private function __click(event:MouseEvent) : void { }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}