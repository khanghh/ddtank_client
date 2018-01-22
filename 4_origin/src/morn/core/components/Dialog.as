package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   public class Dialog extends View
   {
      
      public static const CLOSE:String = "close";
      
      public static const CANCEL:String = "cancel";
      
      public static const SURE:String = "sure";
      
      public static const NO:String = "no";
      
      public static const OK:String = "ok";
      
      public static const YES:String = "yes";
       
      
      protected var _dragArea:Rectangle;
      
      protected var _popupCenter:Boolean = true;
      
      protected var _closeHandler:Handler;
      
      public function Dialog()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:DisplayObject = getChildByName("drag");
         if(_loc1_)
         {
            this.dragArea = _loc1_.x + "," + _loc1_.y + "," + _loc1_.width + "," + _loc1_.height;
            removeElement(_loc1_);
         }
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_)
         {
            switch(_loc2_.name)
            {
               case CLOSE:
               case CANCEL:
               case SURE:
               case NO:
               case OK:
               case YES:
                  this.close(_loc2_.name);
            }
         }
      }
      
      public function show(param1:Boolean = false) : void
      {
         App.dialog.show(this,param1);
      }
      
      public function popup(param1:Boolean = false) : void
      {
         App.dialog.popup(this,param1);
      }
      
      public function close(param1:String = null) : void
      {
         App.dialog.close(this);
         if(this._closeHandler != null)
         {
            this._closeHandler.executeWith([param1]);
         }
      }
      
      public function get dragArea() : String
      {
         return StringUtils.rectToString(this._dragArea);
      }
      
      public function set dragArea(param1:String) : void
      {
         var _loc2_:Array = null;
         if(Boolean(param1))
         {
            _loc2_ = StringUtils.fillArray([0,0,0,0],param1);
            this._dragArea = new Rectangle(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         else
         {
            this._dragArea = null;
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(this._dragArea.contains(mouseX,mouseY))
         {
            App.drag.doDrag(this);
         }
      }
      
      public function get isPopup() : Boolean
      {
         return parent != null;
      }
      
      public function get popupCenter() : Boolean
      {
         return this._popupCenter;
      }
      
      public function set popupCenter(param1:Boolean) : void
      {
         this._popupCenter = param1;
      }
      
      public function get closeHandler() : Handler
      {
         return this._closeHandler;
      }
      
      public function set closeHandler(param1:Handler) : void
      {
         this._closeHandler = param1;
      }
   }
}
