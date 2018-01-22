package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class VIPPrivilegeFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _view:Sprite;
      
      private var _currentViewIndex:int = -1;
      
      private var _growthRules:SelectedButton;
      
      private var _levelPrivilege:SelectedButton;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _openVipBtn:BaseButton;
      
      public function VIPPrivilegeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _selectedBtnGroup.removeEventListener("change",__onSelectedBtnChanged);
         _openVipBtn.removeEventListener("click",__onOpenVipBtnClick);
      }
      
      protected function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("ddt.vip.vipFrameHead.VipPrivilegeTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFrameBg");
         _growthRules = ComponentFactory.Instance.creatComponentByStylename("vip.vipPrivilegeFrame.GrowthRulesBtn");
         _levelPrivilege = ComponentFactory.Instance.creatComponentByStylename("vip.vipPrivilegeFrame.LevelPrivilegeBtn");
         addToContent(_bg);
         addToContent(_growthRules);
         addToContent(_levelPrivilege);
         _selectedBtnGroup = new SelectedButtonGroup();
         _selectedBtnGroup.addSelectItem(_growthRules);
         _selectedBtnGroup.addSelectItem(_levelPrivilege);
         _selectedBtnGroup.addEventListener("change",__onSelectedBtnChanged);
         _selectedBtnGroup.selectIndex = 0;
         if(!PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPExp <= 0)
         {
            _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VIPPrivilegeFrame.OpenVipBtn");
         }
         else
         {
            _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VIPPrivilegeFrame.RenewalVipBtn");
         }
         _openVipBtn.addEventListener("click",__onOpenVipBtnClick);
         addToContent(_openVipBtn);
      }
      
      protected function __onOpenVipBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.dispose();
      }
      
      protected function __onSelectedBtnChanged(param1:Event) : void
      {
         SoundManager.instance.play("008");
         updateView(_selectedBtnGroup.selectIndex);
      }
      
      private function updateView(param1:int) : void
      {
         if(param1 == _currentViewIndex)
         {
            return;
         }
         if(_view)
         {
            Disposeable(_view).dispose();
         }
         _currentViewIndex = param1;
         switch(int(param1))
         {
            case 0:
               _view = new GrowthRuleView();
               break;
            case 1:
               _view = new LevelPrivilegeView();
         }
         addToContent(_view);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_growthRules)
         {
            ObjectUtils.disposeObject(_growthRules);
         }
         if(_levelPrivilege)
         {
            ObjectUtils.disposeObject(_levelPrivilege);
         }
         if(_openVipBtn)
         {
            ObjectUtils.disposeObject(_openVipBtn);
         }
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.dispose();
         }
         _bg = null;
         _growthRules = null;
         _levelPrivilege = null;
         _openVipBtn = null;
         super.dispose();
      }
   }
}
