package gameCommon.view.tool
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.RightChatFacePanel;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import org.aswing.KeyboardManager;
   import setting.controll.SettingController;
   import trainer.view.GhostTipFrame;
   
   public class ToolStripView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _faceBtn:SimpleBitmapButton;
      
      private var _fastMovie:MovieClip;
      
      private var _fastChatBtn:SimpleBitmapButton;
      
      private var _bloodStrip:BloodStrip;
      
      private var _powerStrip:PowerStrip;
      
      private var _facePanelPos:Point;
      
      private var _center:Bitmap;
      
      private var _transparentBtn:BaseButton;
      
      private var _startDate:Date;
      
      private var _facePanel:RightChatFacePanel;
      
      private var _danderBar:DanderBar;
      
      private var _frame:int;
      
      public function ToolStripView(){super();}
      
      private function initView() : void{}
      
      private function setTip(param1:BaseButton, param2:String) : void{}
      
      private function initEvents() : void{}
      
      protected function __noMessageHandler(param1:Event) : void{}
      
      protected function __hasNewHandler(param1:Event) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      protected function __outHandler(param1:MouseEvent) : void{}
      
      protected function __transparentChanged(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
      
      private function __fastChat(param1:MouseEvent) : void{}
      
      private function __setBtn(param1:MouseEvent) : void{}
      
      private function __face(param1:MouseEvent) : void{}
      
      private function __onFaceSelect(param1:Event) : void{}
      
      private function __im(param1:MouseEvent) : void{}
      
      private function updateDander(param1:int) : void{}
      
      private function __dander(param1:LivingEvent) : void{}
      
      private function __ok() : void{}
      
      private function __cancel() : void{}
      
      private function __die(param1:LivingEvent) : void{}
      
      private function showDeadTip() : void{}
      
      public function set specialEnabled(param1:Boolean) : void{}
      
      public function setDanderEnable(param1:Boolean) : void{}
   }
}
