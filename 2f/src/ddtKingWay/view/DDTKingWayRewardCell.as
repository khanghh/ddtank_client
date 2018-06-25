package ddtKingWay.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.Sprite;      public class DDTKingWayRewardCell extends Sprite implements Disposeable   {                   private var _item:Image;            private var _cell:BagCell;            public function DDTKingWayRewardCell() { super(); }
            public function set showitem(value:Boolean) : void { }
            public function set info(value:ItemTemplateInfo) : void { }
            public function setCount(num:*) : void { }
            public function dispose() : void { }
   }}