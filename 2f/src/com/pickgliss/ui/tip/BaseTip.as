package com.pickgliss.ui.tip{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;      public class BaseTip extends Component implements ITip   {            public static const P_tipbackgound:String = "tipbackgound";                   protected var _tipbackgound:Image;            protected var _tipbackgoundstyle:String;            public function BaseTip() { super(); }
            override public function dispose() : void { }
            public function set tipbackgound(back:Image) : void { }
            public function set tipbackgoundstyle(stylename:String) : void { }
            override protected function addChildren() : void { }
   }}