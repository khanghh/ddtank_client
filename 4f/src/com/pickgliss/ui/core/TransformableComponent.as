package com.pickgliss.ui.core{   import com.pickgliss.ui.ShowTipManager;      public class TransformableComponent extends Component implements ITransformableTipedDisplay   {            public static const P_tipWidth:String = "tipWidth";            public static const P_tipHeight:String = "tipHeight";                   protected var _tipWidth:int;            protected var _tipHeight:int;            public function TransformableComponent() { super(); }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            override protected function onProppertiesUpdate() : void { }
   }}