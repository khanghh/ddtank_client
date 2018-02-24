package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class SimpleItem extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_foreStyle:String = "foreStyle";
       
      
      private var _backStyle:String;
      
      private var _foreStyle:String;
      
      private var _back:DisplayObject;
      
      private var _fore:Vector.<DisplayObject>;
      
      private var _foreLinks:Array;
      
      public function SimpleItem(){super();}
      
      override protected function init() : void{}
      
      public function set backStyle(param1:String) : void{}
      
      public function set foreStyle(param1:String) : void{}
      
      private function clearObject() : void{}
      
      private function createObject() : void{}
      
      public function get foreItems() : Vector.<DisplayObject>{return null;}
      
      public function get backItem() : DisplayObject{return null;}
      
      override protected function addChildren() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      override public function dispose() : void{}
   }
}
