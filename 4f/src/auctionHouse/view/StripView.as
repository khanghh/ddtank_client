package auctionHouse.view{   import auctionHouse.AuctionState;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.StripTip;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;      [Event(name="selectStrip",type="auctionHouse.event.AuctionHouseEvent")]   public class StripView extends BaseStripView implements IListCell   {                   private var _seller:FilterFrameText;            private var _lef:Sprite;            private var _curPrice:StripCurPriceView;            private var _vieTip:StripTip;            private var _lefTip:StripTip;            public function StripView() { super(); }
            override protected function initView() : void { }
            private function drawRect(w:Number, h:Number) : Sprite { return null; }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            override protected function updateInfo() : void { }
            override protected function clearSelectStrip() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            override public function dispose() : void { }
   }}