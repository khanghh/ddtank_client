package store.view.embed{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.core.ITransformableTipedDisplay;      public class MultipleButton extends TextButton implements ITransformableTipedDisplay   {                   public var P_tipWidth:String = "tipWidth";            public var P_tipHeight:String = "tipHeight";            protected var _tipWidth:int;            protected var _tipHeight:int;            public function MultipleButton() { super(); }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(value:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(value:int) : void { }
            override protected function onProppertiesUpdate() : void { }
   }}