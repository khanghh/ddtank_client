package store.view.shortcutBuy{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.ShineObject;   import ddt.data.EquipType;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class ShortcutBuyCell extends BaseCell   {                   private var _selected:Boolean = false;            private var _mcBg:ScaleFrameImage;            private var _lightEffect:Scale9CornerImage;            private var _nameArr:Array;            private var _shiner:ShineObject;            private var _itemInfo:ItemTemplateInfo;            private var _shortcutText:FilterFrameText;            private var _shortcutTextBg:ScaleBitmapImage;            public function ShortcutBuyCell(info:ItemTemplateInfo) { super(null); }
            private function initII() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function startShine() : void { }
            public function stopShine() : void { }
            public function showBg() : void { }
            public function hideBg() : void { }
            override public function dispose() : void { }
   }}