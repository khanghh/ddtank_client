package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SelectStateButton extends Sprite implements Disposeable
   {
       
      
      private var _bg:DisplayObject;
      
      private var _overBg:DisplayObject;
      
      private var _gray:Boolean;
      
      private var _enable:Boolean;
      
      private var _selected:Boolean;
      
      public function SelectStateButton(){super();}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __outHander(param1:MouseEvent) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __clickHander(param1:MouseEvent) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get enable() : Boolean{return false;}
      
      public function set enable(param1:Boolean) : void{}
      
      public function get gray() : Boolean{return false;}
      
      public function set gray(param1:Boolean) : void{}
      
      public function set backGround(param1:DisplayObject) : void{}
      
      public function set overBackGround(param1:DisplayObject) : void{}
      
      public function dispose() : void{}
   }
}
