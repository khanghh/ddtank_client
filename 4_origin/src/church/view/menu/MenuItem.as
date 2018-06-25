package church.view.menu
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class MenuItem extends Sprite implements Disposeable
   {
       
      
      private var _textFormat1:TextFormat;
      
      private var _textFormat2:TextFormat;
      
      private var _label:FilterFrameText;
      
      private var _bg:ScaleFrameImage;
      
      protected var _enable:Boolean = false;
      
      public function MenuItem(label:String = "")
      {
         super();
         _bg = ComponentFactory.Instance.creat("church.room.listGuestListMenuItemBgAsset");
         _bg.setFrame(1);
         addChild(_bg);
         _label = ComponentFactory.Instance.creat("church.room.listGuestListMenuItemInfoAsset");
         _label.text = !!label?label:"";
         addChild(_label);
         _textFormat1 = ComponentFactory.Instance.model.getSet("church.textFormat14");
         _textFormat2 = ComponentFactory.Instance.model.getSet("church.textFormat15");
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         enable = true;
         addEventListener("click",__mouseClick);
         addEventListener("rollOver",__rollOver);
         addEventListener("rollOut",__rollOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__mouseClick);
         removeEventListener("rollOver",__rollOver);
         removeEventListener("rollOut",__rollOut);
      }
      
      private function __rollOver(event:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __rollOut(event:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __mouseClick(event:MouseEvent) : void
      {
         if(_enable)
         {
            dispatchEvent(new Event("menuClick"));
         }
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(value:Boolean) : void
      {
         if(_enable != value)
         {
            _enable = value;
            mouseEnabled = value;
            _bg.setFrame(1);
            if(value)
            {
               _label.setTextFormat(_textFormat1);
            }
            else
            {
               _label.setTextFormat(_textFormat2);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _textFormat1 = null;
         _textFormat2 = null;
         if(_label)
         {
            if(_label.parent)
            {
               _label.parent.removeChild(_label);
            }
            _label.dispose();
         }
         _label = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.dispose();
         }
         _bg = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
