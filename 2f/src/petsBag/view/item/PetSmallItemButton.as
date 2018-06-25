package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import pet.data.PetInfo;      public class PetSmallItemButton extends PetSmallItem implements ITipedDisplay   {                   private var _place:int;            private var _bmpBtn:Bitmap;            private var _btnStyleName:String;            protected var _star:StarBar;            private var _tipStyle:String;            private var _tipData:Object;            private var _tipDirctions:String;            private var _tipGapV:int;            private var _tipGapH:int;            public function PetSmallItemButton(info:PetInfo = null) { super(null); }
            public function setButtonStyleName(stylename:String) : void { }
            override protected function initView() : void { }
            protected function onOver(e:MouseEvent) : void { }
            protected function onOut(e:MouseEvent) : void { }
            override public function set info(value:PetInfo) : void { }
            public function set superInfo(value:PetInfo) : void { }
            override public function dispose() : void { }
            public function get place() : int { return 0; }
            public function set place(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function get tipData() : Object { return null; }
            public function get tipDirctions() : String { return null; }
            public function get tipGapV() : int { return 0; }
            public function get tipGapH() : int { return 0; }
            public function set tipStyle(value:String) : void { }
            public function set tipData(value:Object) : void { }
            public function set tipDirctions(value:String) : void { }
            public function set tipGapV(value:int) : void { }
            public function set tipGapH(value:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}