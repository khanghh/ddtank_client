package groupPurchase.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class GroupPurchaseRankCell extends Sprite implements Disposeable
   {
       
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      public function GroupPurchaseRankCell(){super();}
      
      public function refreshView(param1:Object) : void{}
      
      public function dispose() : void{}
   }
}
