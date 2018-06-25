package ddt.view.caddyII{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class LookTrophy extends Frame   {            public static const SUM_NUMBER:int = 20;                   private var _list:SimpleTileList;            private var _items:Vector.<BagCell>;            private var _prevBtn:BaseButton;            private var _nextBtn:BaseButton;            private var _pageTxt:FilterFrameText;            private var _boxTempIDList:Vector.<InventoryItemInfo>;            private var _page:int = 1;            public function LookTrophy() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function _response(e:FrameEvent) : void { }
            private function _nextClick(e:MouseEvent) : void { }
            private function _prevClick(e:MouseEvent) : void { }
            private function fillPage() : void { }
            private function getTemplateInfo(id:int) : InventoryItemInfo { return null; }
            public function set page(value:int) : void { }
            public function get page() : int { return 0; }
            public function pageSum() : int { return 0; }
            public function show(list:Vector.<InventoryItemInfo>) : void { }
            public function hide() : void { }
            override public function dispose() : void { }
   }}