package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.GameEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import gameCommon.GameControl;
   import room.RoomManager;
   
   public class GameTrusteeshipView extends Sprite implements Disposeable
   {
       
      
      private var _trusteeshipBtn:SelectedButton;
      
      private var _trusteeshipMovie:MovieClip;
      
      private var _cancelText:TextField;
      
      private var _trusteeshipState:Boolean;
      
      public function GameTrusteeshipView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _trusteeshipBtn = UICreatShortcut.creatAndAdd("game.view.GameTrusteeshipView.trusteeshipBtn",this);
         _trusteeshipBtn.tipData = LanguageMgr.GetTranslation("game.view.GameTrusteeshipView.tipsData");
         _trusteeshipMovie = UICreatShortcut.creatAndAdd("game.view.TrusteeshipMC",this);
         _cancelText = new TextField();
         _cancelText.setTextFormat(ComponentFactory.Instance.model.getSet("game.view.GameTrusteeshipView.cancelText.tf"));
         _cancelText.filters = [ComponentFactory.Instance.model.getSet("game.view.GameTrusteeshipView.cancelText.gf")];
         _cancelText.x = 54;
         _cancelText.y = 5;
         _cancelText.htmlText = LanguageMgr.GetTranslation("game.view.GameTrusteeshipView.cancelTxt");
         addChild(_cancelText);
         trusteeshipState = false;
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            visible = false;
         }
      }
      
      private function initEvent() : void
      {
         _trusteeshipBtn.addEventListener("click",__onTrusteeshipBtnClick);
         _cancelText.addEventListener("link",__onTrusteeshipBtnClick);
         SharedManager.Instance.addEventListener("transparentChanged",__transparentChanged);
         GameControl.Instance.Current.selfGamePlayer.addEventListener("die",__die);
         PlayerManager.Instance.Self.addEventListener("trusteeshipChange",__trusteeshipChange);
      }
      
      private function removeEvent() : void
      {
         _trusteeshipBtn.removeEventListener("click",__onTrusteeshipBtnClick);
         _cancelText.removeEventListener("link",__onTrusteeshipBtnClick);
         SharedManager.Instance.removeEventListener("transparentChanged",__transparentChanged);
         GameControl.Instance.Current.selfGamePlayer.removeEventListener("die",__die);
         PlayerManager.Instance.Self.removeEventListener("trusteeshipChange",__trusteeshipChange);
      }
      
      protected function __die(param1:Event) : void
      {
         visible = false;
         trusteeshipState = false;
         SocketManager.Instance.out.sendGameTrusteeship(false);
      }
      
      protected function __transparentChanged(param1:Event) : void
      {
         if(parent)
         {
            if(SharedManager.Instance.propTransparent)
            {
               _trusteeshipBtn.alpha = 0.5;
            }
            else
            {
               _trusteeshipBtn.alpha = 1;
            }
         }
      }
      
      protected function __onTrusteeshipBtnClick(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         trusteeshipState = !trusteeshipState;
         _trusteeshipBtn.selected = trusteeshipState;
         SocketManager.Instance.out.sendGameTrusteeship(trusteeshipState);
      }
      
      public function set trusteeshipState(param1:Boolean) : void
      {
         _trusteeshipState = param1;
         update();
      }
      
      public function get trusteeshipState() : Boolean
      {
         return _trusteeshipState;
      }
      
      private function update() : void
      {
         if(_trusteeshipMovie)
         {
            _trusteeshipMovie.visible = _trusteeshipState;
         }
         if(_cancelText)
         {
            _cancelText.visible = _trusteeshipState;
         }
      }
      
      private function __trusteeshipChange(param1:GameEvent) : void
      {
         var _loc2_:Boolean = param1.data as Boolean;
         if(_loc2_)
         {
            trusteeshipState = true;
            if(_trusteeshipBtn)
            {
               _trusteeshipBtn.selected = true;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_trusteeshipBtn);
         _trusteeshipBtn = null;
         ObjectUtils.disposeObject(_trusteeshipMovie);
         _trusteeshipMovie = null;
         ObjectUtils.disposeObject(_cancelText);
         _cancelText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
