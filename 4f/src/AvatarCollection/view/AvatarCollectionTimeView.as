package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class AvatarCollectionTimeView extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _btnDelayTime:SimpleBitmapButton;
      
      private var _btnSelectAll:SimpleBitmapButton;
      
      private var _btnUnSelectAll:SimpleBitmapButton;
      
      private var _timer:TimerJuggler;
      
      private var _data:AvatarCollectionUnitVo;
      
      private var _needHonor:int;
      
      public function AvatarCollectionTimeView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function onSetSelectedAll(param1:CEvent) : void{}
      
      protected function unSelectAllClickHandler(param1:MouseEvent) : void{}
      
      protected function selectAllClickHandler(param1:MouseEvent) : void{}
      
      public function onSelectChange() : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      private function delayTimeClickHandler(param1:MouseEvent) : void{}
      
      protected function __onConfirmResponse(param1:FrameEvent) : void{}
      
      private function initTimer() : void{}
      
      private function timerHandler(param1:Event) : void{}
      
      public function refreshView(param1:AvatarCollectionUnitVo) : void{}
      
      private function refreshTimePlayTxt() : void{}
      
      private function setDefaultView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
