package cardSystem.view.cardCollect{   import cardSystem.CardSocketEvent;   import cardSystem.data.SetsInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CardSelectItem extends Sprite implements Disposeable   {                   private var _nameTxt:FilterFrameText;            private var _bgImg:Bitmap;            private var _id:String;            public function CardSelectItem() { super(); }
            private function init() : void { }
            private function initEvents() : void { }
            private function __mouseOver(event:MouseEvent) : void { }
            private function __mouseOut(event:MouseEvent) : void { }
            private function __click(e:MouseEvent) : void { }
            public function set info(goods:SetsInfo) : void { }
            public function dispose() : void { }
   }}