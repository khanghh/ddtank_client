package explorerManual.view.page{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.utils.PositionUtils;   import explorerManual.ExplorerManualManager;   import explorerManual.data.ExplorerManualInfo;   import explorerManual.data.model.ManualPageItemInfo;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TextEvent;      public class ExplorerPageDirectorItemView extends Sprite implements Disposeable   {            public static const ITEM_CLICK:String = "directorItemClick";            private static const OMIT_STR:String = "....................................................................";                   private var _totalLen:int = 90;            private var _itemTxt:FilterFrameText;            private var _processText:FilterFrameText;            private var _index:int;            private var _info:ManualPageItemInfo;            private var _model:ExplorerManualInfo;            private var _icon:MovieClip;            private var _selectedBg:Bitmap;            public function ExplorerPageDirectorItemView(index:int, model:ExplorerManualInfo) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __mouseOverHandler(evt:MouseEvent) : void { }
            private function __mouseOutHandler(evt:MouseEvent) : void { }
            private function itemLinkClick_Handler(evt:TextEvent) : void { }
            public function set info(value:ManualPageItemInfo) : void { }
            private function showSighIcon() : void { }
            private function createItem() : void { }
            public function dispose() : void { }
   }}