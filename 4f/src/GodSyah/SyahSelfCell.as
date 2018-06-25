package GodSyah{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.Bitmap;   import flash.filters.ColorMatrixFilter;      public class SyahSelfCell extends BaseCell   {                   private var _cellShineBg:Bitmap;            private var _shineEnable:Boolean;            public function SyahSelfCell() { super(null); }
            override public function set info(value:ItemTemplateInfo) : void { }
            override protected function createChildren() : void { }
            public function get shineEnable() : Boolean { return false; }
            public function set shineEnable(value:Boolean) : void { }
            override public function dispose() : void { }
   }}