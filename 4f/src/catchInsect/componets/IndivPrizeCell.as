package catchInsect.componets{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class IndivPrizeCell extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _requestTxt:FilterFrameText;            private var _cellBg:Bitmap;            private var _cell:BagCell;            private var _getPrizeBtn:SimpleBitmapButton;            private var _templateId:int;            public function IndivPrizeCell() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __getPrizeBtnClick(event:MouseEvent) : void { }
            public function setData(templateId:int, need:int) : void { }
            public function setStatus(value:int) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}