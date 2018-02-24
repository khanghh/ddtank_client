package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IDropListCell;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class AuctionDimCell extends Component implements IDropListCell
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _textField:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _name:String;
      
      public function AuctionDimCell(){super();}
      
      public function set NickName(param1:String) : void{}
      
      public function get NickName() : String{return null;}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      override public function dispose() : void{}
   }
}
