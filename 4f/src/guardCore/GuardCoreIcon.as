package guardCore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import guardCore.data.GuardCoreInfo;
   import trainer.view.NewHandContainer;
   
   public class GuardCoreIcon extends Component
   {
       
      
      private var _info:GuardCoreInfo;
      
      private var _icon:Bitmap;
      
      private var _player:PlayerInfo;
      
      public function GuardCoreIcon(){super();}
      
      public function setup(param1:PlayerInfo, param2:Boolean = true) : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function checkGuide() : void{}
      
      private function __onGuardChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateIcon() : void{}
      
      override public function dispose() : void{}
   }
}
