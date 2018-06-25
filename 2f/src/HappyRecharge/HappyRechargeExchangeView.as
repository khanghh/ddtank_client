package HappyRecharge{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class HappyRechargeExchangeView extends Sprite implements Disposeable   {                   private var _cell:BagCell;            private var _dirTxt:FilterFrameText;            private var _numTxt:FilterFrameText;            private var _ticket:Bitmap;            private var _exchangeBtn:SimpleBitmapButton;            private var _selfCount:int;            private var _needCount:int;            public function HappyRechargeExchangeView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __exchangeHandler(e:MouseEvent) : void { }
            private function __updateTicketHandler(e:Event) : void { }
            private function _createCell() : void { }
            private function updateBtnEnable() : void { }
            public function setInfo(info:ItemTemplateInfo, itemCount:int, selfCount:int, needCount:int) : void { }
            public function refreshView(selfCount:int) : void { }
            public function dispose() : void { }
   }}