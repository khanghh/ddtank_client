package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   
   public class WorldBossAwardOptionRightView extends Sprite implements Disposeable
   {
       
      
      private var _rightViewBg:MovieImage;
      
      private var _rightViewBg1:MutipleImage;
      
      private var _rightViewBg2:MutipleImage;
      
      private var _listView:WorldBossAwardListView;
      
      private var _pointBg:Bitmap;
      
      private var _pointInputBg:Scale9CornerImage;
      
      private var _pointTable:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _btnGoback:BaseButton;
      
      private var _btnEnter:BaseButton;
      
      private var _titlebg:MutipleImage;
      
      public function WorldBossAwardOptionRightView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function onChange(param1:PlayerPropertyEvent) : void{}
      
      private function __btnGobackClick(param1:MouseEvent) : void{}
      
      private function __btnEnterClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __roomclose(param1:WorldBossRoomEvent) : void{}
      
      public function dispose() : void{}
   }
}
