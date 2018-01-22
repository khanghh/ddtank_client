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
      
      public function GroupPurchaseRankCell()
      {
         super();
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.rankCell.rankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.rankCell.nameTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.rankCell.numTxt");
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_numTxt);
      }
      
      public function refreshView(param1:Object) : void
      {
         if(param1)
         {
            _rankTxt.text = param1.rank;
            _nameTxt.text = param1.name;
            _numTxt.text = param1.num;
         }
         else
         {
            _rankTxt.text = "";
            _nameTxt.text = "";
            _numTxt.text = "";
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _rankTxt = null;
         _nameTxt = null;
         _numTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
