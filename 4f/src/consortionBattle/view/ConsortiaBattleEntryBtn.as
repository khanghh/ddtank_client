package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortiaBattleEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:MovieClip;
      
      private var _isOpen:Boolean;
      
      public function ConsortiaBattleEntryBtn(){super();}
      
      public function setEnble(param1:Boolean) : void{}
      
      private function initThis() : void{}
      
      private function playAllMc(param1:MovieClip) : void{}
      
      private function stopAllMc(param1:MovieClip) : void{}
      
      private function clickhandler(param1:MouseEvent) : void{}
      
      private function resLoadComplete(param1:Event) : void{}
      
      private function closeHandler(param1:Event) : void{}
      
      private function closeDispose() : void{}
      
      public function dispose() : void{}
   }
}
