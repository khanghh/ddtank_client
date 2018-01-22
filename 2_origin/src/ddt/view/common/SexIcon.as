package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import flash.display.Sprite;
   
   public class SexIcon extends Sprite implements Disposeable
   {
       
      
      private var _sexIcon:ScaleFrameImage;
      
      private var _sex:Boolean;
      
      public function SexIcon(param1:Boolean = true)
      {
         super();
         _sexIcon = ComponentFactory.Instance.creat("sex_icon");
         _sexIcon.setFrame(!!param1?1:2);
         addChild(_sexIcon);
      }
      
      public function setSex(param1:Boolean) : void
      {
         _sexIcon.setFrame(!!param1?2:1);
      }
      
      public function set size(param1:Number) : void
      {
         var _loc2_:* = param1;
         _sexIcon.scaleY = _loc2_;
         _sexIcon.scaleX = _loc2_;
      }
      
      public function dispose() : void
      {
         if(_sexIcon)
         {
            _sexIcon.dispose();
            _sexIcon = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
