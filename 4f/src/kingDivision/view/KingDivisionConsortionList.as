package kingDivision.view
{
   import com.pickgliss.ui.controls.container.VBox;
   import kingDivision.KingDivisionManager;
   
   public class KingDivisionConsortionList extends VBox
   {
       
      
      private var _currentItem:KingDivisionConsortionListItem;
      
      private var items:Vector.<KingDivisionConsortionListItem>;
      
      private var length:int;
      
      public function KingDivisionConsortionList(){super();}
      
      override protected function init() : void{}
   }
}
