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
      
      public function AuctionDimCell()
      {
         super();
      }
      
      public function set NickName(param1:String) : void
      {
         _name = param1;
      }
      
      public function get NickName() : String
      {
         return _name;
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatComponentByStylename("droplist.CellBg");
         _textField = ComponentFactory.Instance.creatComponentByStylename("droplist.CellText");
         _bg.setFrame(1);
         width = _bg.width;
         height = _bg.height;
         addChild(_bg);
         addChild(_textField);
      }
      
      override protected function addChildren() : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _bg.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return "";
      }
      
      public function setCellValue(param1:*) : void
      {
         if(param1)
         {
            _textField.text = param1;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _bg = null;
         _textField = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
