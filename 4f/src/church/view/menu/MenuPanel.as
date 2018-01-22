package church.view.menu
{
   import church.ChurchManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MenuPanel extends Sprite
   {
      
      public static const STARTPOS:int = 10;
      
      public static const STARTPOS_OFSET:int = 18;
      
      public static const GUEST_X:int = 9;
      
      public static const THIS_X_OFSET:int = 95;
      
      public static const THIS_Y_OFSET:int = 55;
       
      
      private var _info:PlayerInfo;
      
      private var _kickGuest:MenuItem;
      
      private var _blackGuest:MenuItem;
      
      private var _bg:ScaleBitmapImage;
      
      public function MenuPanel(){super();}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      private function __menuClick(param1:Event) : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function dispose() : void{}
   }
}
