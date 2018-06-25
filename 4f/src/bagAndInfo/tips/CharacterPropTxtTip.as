package bagAndInfo.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.view.tips.PropTxtTip;      public class CharacterPropTxtTip extends PropTxtTip   {                   protected var _propertySourceTxt:FilterFrameText;            private var _vbox:VBox;            public function CharacterPropTxtTip() { super(); }
            override protected function addChildren() : void { }
            override protected function init() : void { }
            override public function set tipData(data:Object) : void { }
            override protected function updateWH(bool:Boolean = false) : void { }
            override public function dispose() : void { }
            protected function propertySourceText(value:String) : void { }
   }}