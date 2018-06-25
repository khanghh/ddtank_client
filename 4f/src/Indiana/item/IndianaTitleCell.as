package Indiana.item{   import Indiana.IndianaDataManager;   import Indiana.analyzer.IndianaShopItemInfo;   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.CellContentCreator;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.events.MouseEvent;   import flash.geom.Point;      public class IndianaTitleCell extends BaseCell   {                   private var _bg:ScaleBitmapImage;            private var _info:IndianaShopItemInfo;            private var _pic:CellContentCreator;            private var _loadingasset:MovieClip;            private var _contentWidth:Number;            private var _contentHeight:Number;            private var _picPos:Point;            private var _selectImage:DisplayObject;            public function IndianaTitleCell() { super(null); }
            override protected function init() : void { }
            public function set Info(value:IndianaShopItemInfo) : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function get Info() : IndianaShopItemInfo { return null; }
            override public function dispose() : void { }
   }}