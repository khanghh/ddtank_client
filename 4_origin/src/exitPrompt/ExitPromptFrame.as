package exitPrompt
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.DuowanInterfaceEvent;
   import ddt.manager.DuowanInterfaceManage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class ExitPromptFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _BG:MutipleImage;
      
      private var _menu:ExitAllButton;
      
      private var _listScroll:ScrollPanel;
      
      private const CENTERX:int = 13;
      
      private const CENTERY:int = 46;
      
      public function ExitPromptFrame()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.exitPrompt.prompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true);
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _BG = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.bg");
         addToContent(_BG);
         _menu = ComponentFactory.Instance.creatComponentByStylename("ExitAllButton");
         _menu.start();
         if(_menu.needScorllBar)
         {
            _listScroll = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.scrollPanel");
            _listScroll.hScrollProxy = 2;
            _listScroll.vScrollProxy = 0;
            _listScroll.setView(_menu);
            addToContent(_listScroll);
            _listScroll.invalidateViewport();
         }
         else
         {
            _menu.x = 13;
            _menu.y = 46;
            addToContent(_menu);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,2);
         StageReferance.stage.focus = this;
      }
      
      public function setList(arr:Array) : void
      {
      }
      
      public function _menuChange(e:Event) : void
      {
         if(_listScroll)
         {
            _listScroll.invalidateViewport();
         }
      }
      
      private function removeView() : void
      {
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         if(_menu)
         {
            ObjectUtils.disposeObject(_menu);
         }
         if(_listScroll)
         {
            ObjectUtils.disposeObject(_listScroll);
         }
         _BG = null;
         _menu = null;
         _listScroll = null;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _menu.addEventListener("change",_menuChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               dispatchEvent(new Event("close"));
               break;
            case 2:
            case 3:
            case 4:
               dispose();
               DuowanInterfaceManage.Instance.dispatchEvent(new DuowanInterfaceEvent("outLine"));
               dispatchEvent(new Event("submit"));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
