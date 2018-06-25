package church.view.weddingRoomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import quest.QuestDescTextAnalyz;
   
   public class DivorcePromptFrame extends BaseAlerFrame
   {
      
      private static var _instance:DivorcePromptFrame;
       
      
      private var _alertInfo:AlertInfo;
      
      private var _infoText:FilterFrameText;
      
      public var isOpenDivorce:Boolean = false;
      
      public function DivorcePromptFrame()
      {
         super();
         initialize();
      }
      
      public static function get Instance() : DivorcePromptFrame
      {
         if(_instance == null)
         {
            _instance = ComponentFactory.Instance.creatComponentByStylename("DivorcePromptFrame");
         }
         return _instance;
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"),LanguageMgr.GetTranslation("church.view.weddingRoomList.DivorcePromptFrame.yes"),LanguageMgr.GetTranslation("church.view.weddingRoomList.DivorcePromptFrame.no"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _infoText = ComponentFactory.Instance.creatComponentByStylename("DivorcePromptFrameText");
         var _str:String = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.frameInfo");
         _str = _str.replace(/XXXX/g,"<font COLOR=\'#FF0000\'>" + PlayerManager.Instance.Self.SpouseName + "</font>");
         _str = QuestDescTextAnalyz.start(_str);
         _infoText.htmlText = _str;
         addToContent(_infoText);
      }
      
      public function show() : void
      {
         if(PlayerManager.Instance.Self.SpouseName != null && PlayerManager.Instance.Self.SpouseName != "")
         {
            SocketManager.Instance.out.sendMateTime(PlayerManager.Instance.Self.SpouseID);
            SocketManager.Instance.addEventListener(PkgEvent.format(85),__mateTimeA);
            SharedManager.Instance.divorceBoolean = false;
            SharedManager.Instance.save();
         }
      }
      
      private function __mateTimeA(e:PkgEvent) : void
      {
         var _date:Date = e.pkg.readDate();
         SocketManager.Instance.removeEventListener(PkgEvent.format(85),__mateTimeA);
         var dat:Date = TimeManager.Instance.Now();
         var gapHours:int = (dat.valueOf() - _date.valueOf()) / 3600000;
         if(gapHours > 720)
         {
            LayerManager.Instance.addToLayer(this,3,true,1);
         }
         else
         {
            dispose();
         }
      }
      
      private function removeView() : void
      {
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
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
               break;
            case 2:
            case 3:
            case 4:
               isOpenDivorce = true;
               dispose();
               StateManager.setState("ddtchurchroomlist");
               ComponentSetting.SEND_USELOG_ID(6);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_infoText)
         {
            ObjectUtils.disposeObject(_infoText);
         }
         _infoText = null;
         removeEvent();
         removeView();
      }
   }
}
