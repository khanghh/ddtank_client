package morn.core.components{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.utils.ObjectUtils;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.text.TextField;   import morn.core.ex.ButtonEx;   import morn.core.ex.LevelIconEx;   import morn.core.ex.NameTextEx;   import morn.core.ex.NumberImageEx;   import morn.core.ex.NumericStepper;   import morn.core.ex.PageNavigaterEx;   import morn.core.ex.ScaleLeftRightImageEx;   import morn.core.ex.TabButtonEx;   import morn.core.ex.TabEx;   import morn.core.ex.TabListEx;   import morn.core.handlers.Handler;   import morn.editor.core.IRender;      public class View extends Box   {            public static var uiMap:Object = {};            protected static var uiClassMap:Object = {         "Box":Box,         "Button":Button,         "CheckBox":CheckBox,         "Clip":Clip,         "ComboBox":ComboBox,         "Component":Component,         "Container":Container,         "FrameClip":FrameClip,         "HScrollBar":HScrollBar,         "HSlider":HSlider,         "Image":Image,         "Label":Label,         "LinkButton":LinkButton,         "List":List,         "Panel":Panel,         "ProgressBar":ProgressBar,         "RadioButton":RadioButton,         "RadioGroup":RadioGroup,         "ScrollBar":ScrollBar,         "Slider":Slider,         "Tab":Tab,         "TextArea":TextArea,         "TextInput":TextInput,         "View":View,         "ViewStack":ViewStack,         "VScrollBar":VScrollBar,         "VSlider":VSlider,         "HBox":HBox,         "VBox":VBox,         "Tree":Tree,         "ColorPicker":ColorPicker,         "ProxyItem":ProxyItem,         "LevelIconEx":LevelIconEx,         "NumberImageEx":NumberImageEx,         "NameTextEx":NameTextEx,         "PageNavigaterEx":PageNavigaterEx,         "ButtonEx":ButtonEx,         "TabEx":TabEx,         "NumericStepper":NumericStepper,         "TabListEx":TabListEx,         "TabButtonEx":TabButtonEx,         "ScaleLeftRightImageEx":ScaleLeftRightImageEx      };            protected static var viewClassMap:Object = {};                   private var _enableEscKey:Boolean = false;            private var _escKeyHandler:Handler;            private var _enterKeyHandler:Handler;            public function View() { super(); }
            public static function createComp(uiView:Object, comp:Component = null, view:View = null) : Component { return null; }
            protected static function createCompByJSON(json:Object, comp:Component = null, view:View = null) : Component { return null; }
            protected static function createCompByXML(xml:XML, comp:Component = null, view:View = null) : Component { return null; }
            private static function setCompValue(comp:Component, prop:String, value:String, view:View = null) : void { }
            protected static function getCompInstanceByJSON(json:Object) : Component { return null; }
            protected static function getCompInstanceByXML(xml:XML) : Component { return null; }
            public static function registerComponent(key:String, compClass:Class) : void { }
            public static function registerViewRuntime(key:String, compClass:Class) : void { }
            protected function createView(uiView:Object) : void { }
            protected function loadUI(path:String) : void { }
            public function reCreate(comp:Component = null) : void { }
            public function get enableEscKey() : Boolean { return false; }
            public function set enableEscKey(value:Boolean) : void { }
            public function get escKeyHandler() : Handler { return null; }
            public function set escKeyHandler(value:Handler) : void { }
            public function get enterKeyHandler() : Handler { return null; }
            public function set enterKeyHandler(value:Handler) : void { }
            override public function dispose() : void { }
            private function addKeyEvent() : void { }
            private function onClick(e:MouseEvent) : void { }
            private function keyHandler(e:KeyboardEvent) : void { }
   }}