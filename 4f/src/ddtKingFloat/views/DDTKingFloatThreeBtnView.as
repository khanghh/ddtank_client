package ddtKingFloat.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtKingFloat.DDTKingFloatEvent;
   import ddtKingFloat.DDTKingFloatManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class DDTKingFloatThreeBtnView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leapBtn:SimpleBitmapButton;
      
      private var _invisibilityBtn:SimpleBitmapButton;
      
      private var _cleanBtn:SimpleBitmapButton;
      
      private var _missileBtn:SimpleBitmapButton;
      
      private var _recordClickTag:int;
      
      private var _freeTipList:Vector.<MovieClip>;
      
      public var targetId:int = 0;
      
      public var targetZone:int = -1;
      
      public function DDTKingFloatThreeBtnView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function refreshFreeCount(param1:Event) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function enableBtn(param1:SimpleBitmapButton) : void{}
      
      private function unEnableBtn(param1:int) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      public function useSkill() : void{}
      
      private function useSkillConfirm(param1:FrameEvent) : void{}
      
      private function useSkillReConfirm(param1:FrameEvent) : void{}
      
      private function sendUseSkillSocket(param1:int, param2:Boolean, param3:Boolean, param4:int = 0, param5:int = -1) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
