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
      
      public function NavigationList()
      {
         super();
         configUI();
      }
      
      private function configUI() : void
      {
         _listBack = ComponentFactory.Instance.creatComponentByStylename("invite.list.BackgroundList");
         addChild(_listBack);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(val:int) : void
      {
      }
      
      public function get list() : Array
      {
         return _listArr;
      }
      
      public function set list(val:Array) : void
      {
      }
      
      public function get mode() : String
      {
         var i:int = 0;
         var string:String = "";
         for(i = 0; i < _modeArr.length; )
         {
            string = string + (_modeArr[i] + ",");
            i++;
         }
         return string.substr(0,string.length - 1);
      }
      
      public function set mode(val:String) : void
      {
         _modeArr = val.split(",");
      }
      
      public function addNavButton(button:NavButton, type:int) : void
      {
         var proxy:ButtonProxy = new ButtonProxy();
         proxy.button = button;
         proxy.type = type;
         _buttons.push(proxy);
      }
      
      private function setNavigationPos(pos:int) : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}

import invite.view.NavButton;

class ButtonProxy
{
    
   
   public var button:NavButton;
   
   public var type:int;
   
   function ButtonProxy()
   {
      super();
   }
}
