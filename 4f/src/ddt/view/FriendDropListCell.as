package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IDropListCell;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   
   public class FriendDropListCell extends Component implements IDropListCell
   {
       
      
      private var _sex_icon:SexIcon;
      
      private var _data:String;
      
      private var _textField:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _bg:Bitmap;
      
      public function FriendDropListCell(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      override public function dispose() : void{}
   }
}
