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
      
      public function SexIcon(sex:Boolean = true)
      {
         super();
         _sexIcon = ComponentFactory.Instance.creat("sex_icon");
         _sexIcon.setFrame(!!sex?1:2);
         addChild(_sexIcon);
      }
      
      public function setSex(sex:Boolean) : void
      {
         _sexIcon.setFrame(!!sex?2:1);
      }
      
      public function set size(value:Number) : void
      {
         var _loc2_:* = value;
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
