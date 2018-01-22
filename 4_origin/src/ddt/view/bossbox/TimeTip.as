package ddt.view.bossbox
{
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class TimeTip extends TransformableComponent
   {
       
      
      private var _closeBox:Sprite;
      
      private var _delayText:Sprite;
      
      public function TimeTip()
      {
         super();
      }
      
      public function setView(param1:Sprite, param2:Sprite) : void
      {
         _closeBox = param1;
         _delayText = param2;
         addChild(_closeBox);
      }
      
      public function get closeBox() : Sprite
      {
         return _closeBox;
      }
      
      public function get delayText() : Sprite
      {
         return _delayText;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_closeBox)
         {
            ObjectUtils.disposeObject(_closeBox);
         }
         _closeBox = null;
         if(_delayText)
         {
            ObjectUtils.disposeObject(_delayText);
         }
         _delayText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
