package kingDivision.view
{
   import com.pickgliss.ui.controls.container.VBox;
   import kingDivision.KingDivisionManager;
   
   public class KingDivisionConsortionList extends VBox
   {
       
      
      private var _currentItem:KingDivisionConsortionListItem;
      
      private var items:Vector.<KingDivisionConsortionListItem>;
      
      private var length:int;
      
      public function KingDivisionConsortionList()
      {
         super();
         _spacing = 3;
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         super.init();
         spacing = 2;
         length = KingDivisionManager.Instance.model.conLen;
         items = new Vector.<KingDivisionConsortionListItem>(length);
         for(i = 1; i <= length; )
         {
            items[i - 1] = new KingDivisionConsortionListItem(i);
            items[i - 1].buttonMode = true;
            items[i - 1].info = KingDivisionManager.Instance.model.conItemInfo[i - 1];
            addChild(items[i - 1]);
            i++;
         }
      }
   }
}
