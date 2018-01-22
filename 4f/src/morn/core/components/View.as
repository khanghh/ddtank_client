package morn.core.components
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import morn.core.ex.ButtonEx;
   import morn.core.ex.LevelIconEx;
   import morn.core.ex.NameTextEx;
   import morn.core.ex.NumberImageEx;
   import morn.core.ex.NumericStepper;
   import morn.core.ex.PageNavigaterEx;
   import morn.core.ex.TabButtonEx;
   import morn.core.ex.TabEx;
   import morn.core.ex.TabListEx;
   import morn.core.handlers.Handler;
   import morn.editor.core.IRender;
   
   public class View extends Box
   {
      
      public static var uiMap:Object = {};
      
      protected static var uiClassMap:Object = {
         "Box":Box,
         "Button":Button,
         "CheckBox":CheckBox,
         "Clip":Clip,
         "ComboBox":ComboBox,
         "Component":Component,
         "Container":Container,
         "FrameClip":FrameClip,
         "HScrollBar":HScrollBar,
         "HSlider":HSlider,
         "Image":Image,
         "Label":Label,
         "LinkButton":LinkButton,
         "List":List,
         "Panel":Panel,
         "ProgressBar":ProgressBar,
         "RadioButton":RadioButton,
         "RadioGroup":RadioGroup,
         "ScrollBar":ScrollBar,
         "Slider":Slider,
         "Tab":Tab,
         "TextArea":TextArea,
         "TextInput":TextInput,
         "View":View,
         "ViewStack":ViewStack,
         "VScrollBar":VScrollBar,
         "VSlider":VSlider,
         "HBox":HBox,
         "VBox":VBox,
         "Tree":Tree,
         "ColorPicker":ColorPicker,
         "ProxyItem":ProxyItem,
         "LevelIconEx":LevelIconEx,
         "NumberImageEx":NumberImageEx,
         "NameTextEx":NameTextEx,
         "PageNavigaterEx":PageNavigaterEx,
         "ButtonEx":ButtonEx,
         "TabEx":TabEx,
         "NumericStepper":NumericStepper,
         "TabListEx":TabListEx,
         "TabButtonEx":TabButtonEx
      };
      
      protected static var viewClassMap:Object = {};
       
      
      private var _enableEscKey:Boolean = false;
      
      private var _escKeyHandler:Handler;
      
      private var _enterKeyHandler:Handler;
      
      public function View(){super();}
      
      public static function createComp(param1:Object, param2:Component = null, param3:View = null) : Component{return null;}
      
      protected static function createCompByJSON(param1:Object, param2:Component = null, param3:View = null) : Component{return null;}
      
      protected static function createCompByXML(param1:XML, param2:Component = null, param3:View = null) : Component{return null;}
      
      private static function setCompValue(param1:Component, param2:String, param3:String, param4:View = null) : void{}
      
      protected static function getCompInstanceByJSON(param1:Object) : Component{return null;}
      
      protected static function getCompInstanceByXML(param1:XML) : Component{return null;}
      
      public static function registerComponent(param1:String, param2:Class) : void{}
      
      public static function registerViewRuntime(param1:String, param2:Class) : void{}
      
      protected function createView(param1:Object) : void{}
      
      protected function loadUI(param1:String) : void{}
      
      public function reCreate(param1:Component = null) : void{}
      
      public function get enableEscKey() : Boolean{return false;}
      
      public function set enableEscKey(param1:Boolean) : void{}
      
      public function get escKeyHandler() : Handler{return null;}
      
      public function set escKeyHandler(param1:Handler) : void{}
      
      public function get enterKeyHandler() : Handler{return null;}
      
      public function set enterKeyHandler(param1:Handler) : void{}
      
      override public function dispose() : void{}
      
      private function addKeyEvent() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function keyHandler(param1:KeyboardEvent) : void{}
   }
}
