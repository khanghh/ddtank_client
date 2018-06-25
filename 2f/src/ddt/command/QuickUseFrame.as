package ddt.command{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class QuickUseFrame extends BaseAlerFrame   {                   private var _itemId:int;            private var _cellNum:int;            private var _cell:BagCell;            private var _textInfo:FilterFrameText;            private var _numBg:Scale9CornerImage;            private var _num:FilterFrameText;            private var _maxBtn:SimpleBitmapButton;            public function QuickUseFrame() { super(); }
            private function initView() : void { }
            public function setItemInfo(itemId:int, cost:int, bagType:int, needNum:int) : void { }
            private function updateItemCellCount(needNum:int) : void { }
            private function initEvent() : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            protected function __onTextInput(event:Event) : void { }
            private function _response(e:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}