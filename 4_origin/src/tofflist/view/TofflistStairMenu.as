package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistStairMenu extends Sprite implements Disposeable
   {
      
      public static const CONSORTIA:String = "consortia";
      
      public static const CROSS_SERVER_CONSORTIA:String = "crossServerConsortia";
      
      public static const CROSS_SERVER_PERSONAL:String = "crossServerPersonal";
      
      public static const PERSONAL:String = "personal";
      
      public static const TEAM:String = "teams";
      
      public static const CROSS_SERVER_TEAM:String = "crossServerTeams";
       
      
      private var _selectedBtnGroupI:SelectedButtonGroup;
      
      private var _crossServerBtn:SelectedCheckButton;
      
      private var _theServerBtn:SelectedCheckButton;
      
      private var _selectedBtnGroupII:SelectedButtonGroup;
      
      private var _consortiaBtn:SelectedTextButton;
      
      private var _personalBtn:SelectedTextButton;
      
      private var _titleInfo:TextButton;
      
      private var _teamsBtn:SelectedTextButton;
      
      private var _resourceArr:Array;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _styleLinkArr:Array;
      
      public function TofflistStairMenu()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _selectedBtnGroupI = new SelectedButtonGroup(false,1);
         _theServerBtn = ComponentFactory.Instance.creatComponentByStylename("tofflist.theServerBtn");
         _selectedBtnGroupI.addSelectItem(_theServerBtn);
         addChild(_theServerBtn);
         _crossServerBtn = ComponentFactory.Instance.creatComponentByStylename("tofflist.crossServerBtn");
         _selectedBtnGroupI.addSelectItem(_crossServerBtn);
         addChild(_crossServerBtn);
         _selectedBtnGroupI.selectIndex = 0;
         _selectedBtnGroupII = new SelectedButtonGroup(false,1);
         _personalBtn = ComponentFactory.Instance.creatComponentByStylename("tofflist.personalBtn");
         _selectedBtnGroupII.addSelectItem(_personalBtn);
         _personalBtn.text = LanguageMgr.GetTranslation("tofflist.personal");
         addChild(_personalBtn);
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("tofflist.consortiaBtn");
         _selectedBtnGroupII.addSelectItem(_consortiaBtn);
         _consortiaBtn.text = LanguageMgr.GetTranslation("tofflist.consortia");
         addChild(_consortiaBtn);
         _teamsBtn = ComponentFactory.Instance.creatComponentByStylename("tofflist.teamsBtn");
         _selectedBtnGroupII.addSelectItem(_teamsBtn);
         _teamsBtn.text = LanguageMgr.GetTranslation("tofflist.teams");
         addChild(_teamsBtn);
         _selectedBtnGroupII.selectIndex = 0;
         _titleInfo = ComponentFactory.Instance.creatComponentByStylename("asset.toffilist.titleInfoBtn");
         _titleInfo.text = LanguageMgr.GetTranslation("toffilist.titleInfo.nameText");
         addChild(_titleInfo);
      }
      
      private function addEvent() : void
      {
         _selectedBtnGroupI.addEventListener("change",__typeChange);
         _selectedBtnGroupII.addEventListener("change",__typeChange);
      }
      
      private function __typeChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_selectedBtnGroupI.selectIndex == 0 && _selectedBtnGroupII.selectIndex == 0)
         {
            type = "personal";
         }
         else if(_selectedBtnGroupI.selectIndex == 1 && _selectedBtnGroupII.selectIndex == 0)
         {
            type = "crossServerPersonal";
         }
         else if(_selectedBtnGroupI.selectIndex == 0 && _selectedBtnGroupII.selectIndex == 1)
         {
            type = "consortia";
         }
         else if(_selectedBtnGroupI.selectIndex == 1 && _selectedBtnGroupII.selectIndex == 1)
         {
            type = "crossServerConsortia";
         }
         else if(_selectedBtnGroupI.selectIndex == 0 && _selectedBtnGroupII.selectIndex == 2)
         {
            type = "teams";
         }
         else if(_selectedBtnGroupI.selectIndex == 1 && _selectedBtnGroupII.selectIndex == 2)
         {
            type = "crossServerTeams";
         }
      }
      
      private function removeEvent() : void
      {
         _selectedBtnGroupI.removeEventListener("change",__typeChange);
         _selectedBtnGroupII.removeEventListener("change",__typeChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_theServerBtn)
         {
            _theServerBtn.dispose();
         }
         _theServerBtn = null;
         if(_crossServerBtn)
         {
            _crossServerBtn.dispose();
         }
         _crossServerBtn = null;
         if(_personalBtn)
         {
            _personalBtn.dispose();
         }
         _personalBtn = null;
         if(_consortiaBtn)
         {
            _consortiaBtn.dispose();
         }
         _consortiaBtn = null;
         if(_titleInfo)
         {
            _titleInfo.dispose();
         }
         _titleInfo = null;
         if(_teamsBtn)
         {
            _teamsBtn.dispose();
         }
         _teamsBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get type() : String
      {
         return TofflistModel.firstMenuType;
      }
      
      public function set type(param1:String) : void
      {
         TofflistModel.firstMenuType = param1;
         dispatchEvent(new TofflistEvent("tofflisttoolbarselect",type));
      }
   }
}
