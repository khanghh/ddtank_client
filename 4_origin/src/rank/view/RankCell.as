package rank.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class RankCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _titlefield:FilterFrameText;
      
      private var _selected:Boolean = false;
      
      private var _info:GmActivityInfo;
      
      public function RankCell(info:GmActivityInfo)
      {
         super();
         _info = info;
         initUI();
      }
      
      public function get info() : GmActivityInfo
      {
         return _info;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         DisplayUtils.setFrame(_bg,!!_selected?2:1);
         DisplayUtils.setFrame(_titlefield,!!_selected?2:1);
      }
      
      private function initUI() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("rank.ActivityCellBg");
         _titlefield = ComponentFactory.Instance.creatComponentByStylename("rank.ActivityCellTitleText");
         DisplayUtils.setFrame(_bg,!!_selected?2:1);
         addChild(_bg);
         _titlefield.htmlText = "<b>·</b> " + _info.activityName;
         addChild(_titlefield);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titlefield);
         _titlefield = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
