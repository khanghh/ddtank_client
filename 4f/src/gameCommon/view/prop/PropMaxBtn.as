package gameCommon.view.prop{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import ddt.view.tips.ToolPropInfo;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class PropMaxBtn extends Sprite implements Disposeable, ITipedDisplay   {                   private var _tipInfo:ToolPropInfo;            public function PropMaxBtn() { super(); }
            public function dispose() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}