package equipretrieve.view{   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Sprite;   import store.StoreCell;      public class RetrieveResultCell extends StoreCell   {            public static const SHINE_XY:int = 5;            public static const SHINE_SIZE:int = 76;                   private var bg:Sprite;            private var bgBit:Bitmap;            private var _text:FilterFrameText;            public function RetrieveResultCell($index:int) { super(null,null); }
            override public function startShine() : void { }
            override protected function createChildren() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function dispose() : void { }
   }}