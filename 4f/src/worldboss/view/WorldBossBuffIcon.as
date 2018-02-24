package worldboss.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossBuffIcon extends Sprite implements Disposeable
   {
       
      
      private var _moneyBtn:SimpleBitmapButton;
      
      private var _bindMoneyBtn:SimpleBitmapButton;
      
      private var _buffIcon:WorldBossBuffItem;
      
      public function WorldBossBuffIcon(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function buyBuff(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
