package Indiana
{
   import Indiana.item.IndianaResoultLose;
   import Indiana.item.IndianaResoultSuccess;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class IndianaResoultPanel extends Sprite implements Disposeable
   {
       
      
      private var _successView:IndianaResoultSuccess;
      
      private var _loseView:IndianaResoultLose;
      
      public function IndianaResoultPanel()
      {
         super();
         showResoult(1);
      }
      
      private function showResoult(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               if(_successView == null)
               {
                  _successView = new IndianaResoultSuccess();
                  addChild(_successView);
               }
               break;
            case 1:
               if(_loseView == null)
               {
                  _loseView = new IndianaResoultLose();
                  addChild(_loseView);
                  break;
               }
         }
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _successView = null;
         _loseView = null;
      }
   }
}
