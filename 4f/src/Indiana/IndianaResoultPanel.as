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
      
      public function IndianaResoultPanel(){super();}
      
      private function showResoult(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
