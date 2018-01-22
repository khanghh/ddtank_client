package wantstrong.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import wantstrong.WantStrongControl;
   import wantstrong.data.WantStrongMenuData;
   
   public class WantStrongCell extends Sprite implements Disposeable
   {
       
      
      private var _info:Vector.<WantStrongMenuData>;
      
      private var _bg:ScaleFrameImage;
      
      private var _selected:Boolean = false;
      
      private var _titlefield:FilterFrameText;
      
      private var _title:String;
      
      public function WantStrongCell(param1:Vector.<WantStrongMenuData>, param2:String)
      {
         _info = new Vector.<WantStrongMenuData>();
         super();
         _info = param1;
         _title = param2;
         buttonMode = true;
         initUI();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         DisplayUtils.setFrame(_bg,!!_selected?2:1);
         DisplayUtils.setFrame(_titlefield,!!_selected?2:1);
      }
      
      public function get info() : Vector.<WantStrongMenuData>
      {
         return _info;
      }
      
      public function openItem() : void
      {
         SoundManager.instance.play("008");
         WantStrongControl.Instance.setCurrentInfo(_info);
      }
      
      private function initUI() : void
      {
         if(_title == LanguageMgr.GetTranslation("ddt.wantStrong.view.findBack"))
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("wantstrong.ActivitySpecialCellBg");
            _titlefield = ComponentFactory.Instance.creatComponentByStylename("wantstrong.ActivitySpecailCellTitleText");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("wantstrong.ActivityCellBg");
            _titlefield = ComponentFactory.Instance.creatComponentByStylename("wantstrong.ActivityCellTitleText");
         }
         DisplayUtils.setFrame(_bg,!!_selected?2:1);
         addChild(_bg);
         _titlefield.htmlText = "<b>·</b> " + _title;
         addChild(_titlefield);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titlefield);
         _titlefield = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
