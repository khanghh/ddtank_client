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
      
      public function FriendDropListCell()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creat("asset.core.comboxItembg3");
         _bg.width = 220;
         _textField = ComponentFactory.Instance.creatComponentByStylename("droplist.CellText");
         _sex_icon = new SexIcon();
         PositionUtils.setPos(_sex_icon,"IM.IMLookup.SexPos");
         _bg.alpha = 0;
         width = _bg.width;
         height = _bg.height;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_textField)
         {
            addChild(_textField);
         }
         if(_sex_icon)
         {
            addChild(_sex_icon);
         }
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
            _bg.alpha = 1;
         }
         else
         {
            _bg.alpha = 0;
         }
      }
      
      public function getCellValue() : *
      {
         if(_data)
         {
            return (_data as PlayerInfo).NickName;
         }
         return "";
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         if(param1)
         {
            _textField.text = param1.NickName;
            _sex_icon.visible = true;
            _sex_icon.setSex(param1.Sex);
         }
         else
         {
            _textField.text = LanguageMgr.GetTranslation("ddt.FriendDropListCell.noFriend");
            _sex_icon.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_sex_icon)
         {
            ObjectUtils.disposeObject(_sex_icon);
         }
         _sex_icon = null;
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
