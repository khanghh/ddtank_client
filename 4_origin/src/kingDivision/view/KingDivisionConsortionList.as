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
         var _loc1_:int = 0;
         super.init();
         spacing = 2;
         length = KingDivisionManager.Instance.model.conLen;
         items = new Vector.<KingDivisionConsortionListItem>(length);
         _loc1_ = 1;
         while(_loc1_ <= length)
         {
            items[_loc1_ - 1] = new KingDivisionConsortionListItem(_loc1_);
            items[_loc1_ - 1].buttonMode = true;
            items[_loc1_ - 1].info = KingDivisionManager.Instance.model.conItemInfo[_loc1_ - 1];
            addChild(items[_loc1_ - 1]);
            _loc1_++;
         }
      }
   }
}
