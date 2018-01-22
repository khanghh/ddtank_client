package invite.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class NavigationList extends Sprite implements Disposeable
   {
       
      
      private var _type:int;
      
      private var _modeArr:Array;
      
      private var _buttons:Array;
      
      private var _list:ListPanel;
      
      private var _listBack:DisplayObject;
      
      private var _listArr:Array;
      
      public function NavigationList(){super();}
      
      private function configUI() : void{}
      
      public function get type() : int{return 0;}
      
      public function set type(param1:int) : void{}
      
      public function get list() : Array{return null;}
      
      public function set list(param1:Array) : void{}
      
      public function get mode() : String{return null;}
      
      public function set mode(param1:String) : void{}
      
      public function addNavButton(param1:NavButton, param2:int) : void{}
      
      private function setNavigationPos(param1:int) : void{}
      
      public function dispose() : void{}
   }
}

import invite.view.NavButton;

class ButtonProxy
{
    
   
   public var button:NavButton;
   
   public var type:int;
   
   function ButtonProxy(){super();}
}
