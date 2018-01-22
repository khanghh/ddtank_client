package consortionBattle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class ConsBatTwoBtnView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _powerFullBtn:SimpleBitmapButton;
      
      private var _doubleScoreBtn:SimpleBitmapButton;
      
      private var _powerFullSprite:SimpleBitmapButton;
      
      private var _doubleScoreSprite:SimpleBitmapButton;
      
      private var _autoBuyBtn:SelectedCheckButton;
      
      private var _lastPowerFullClickTime:int = 0;
      
      public function ConsBatTwoBtnView(){super();}
      
      private function initView() : void{}
      
      private function refreshView(param1:Event = null) : void{}
      
      private function initEvent() : void{}
      
      private function autoClickHandler(param1:MouseEvent) : void{}
      
      private function __autoBuyConfirm(param1:FrameEvent) : void{}
      
      private function autoBuyPowerFull() : void{}
      
      private function powerFullHandler(param1:MouseEvent) : void{}
      
      private function __powerFullConfirm(param1:FrameEvent) : void{}
      
      private function doubleScoreHandler(param1:MouseEvent) : void{}
      
      private function __doubleScoreConfirm(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
