package wonderfulActivity.items
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class NewGameBenifitTipSprite extends Component
   {
       
      
      private var _back:DisplayObject;
      
      public function NewGameBenifitTipSprite()
      {
         super();
      }
      
      public function set back(back:DisplayObject) : void
      {
         _back = back;
         _back.alpha = 0;
         _width = _back.width;
         _height = _back.height;
         addChild(_back);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
