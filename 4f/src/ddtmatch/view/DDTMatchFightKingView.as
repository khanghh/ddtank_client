package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.comm.PackageIn;
   
   public class DDTMatchFightKingView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _activityInfoTxt:FilterFrameText;
      
      private var _myscoreTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var scrollPanel:ScrollPanel;
      
      public function DDTMatchFightKingView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function __onFightKingSocreInfo(param1:CrazyTankSocketEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
