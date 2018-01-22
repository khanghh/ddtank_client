package gameStick.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameStick.GameStickManager;
   
   public class GameStickGameOverBoard extends Sprite implements Disposeable
   {
       
      
      private var _bg:Sprite;
      
      private var _btnShare:SimpleBitmapButton;
      
      private var _btnRestart:SimpleBitmapButton;
      
      private var _btnExit:SimpleBitmapButton;
      
      public function GameStickGameOverBoard()
      {
         super();
         _bg = ComponentFactory.Instance.creat("asset.gamestick.gameover");
         addChild(_bg);
         _btnShare = ComponentFactory.Instance.creat("gamestick.shareBtn");
         _btnShare.addEventListener("click",onShareClick);
         addChild(_btnShare);
         _btnRestart = ComponentFactory.Instance.creat("gamestick.reStartBtn");
         _btnRestart.addEventListener("click",onRestartClick);
         addChild(_btnRestart);
         _btnExit = ComponentFactory.Instance.creat("gamestick.exitBtn");
         _btnExit.addEventListener("click",onExitClick);
         addChild(_btnExit);
      }
      
      protected function onExitClick(param1:MouseEvent) : void
      {
         GameStickManager.getInstance().exit();
      }
      
      protected function onRestartClick(param1:MouseEvent) : void
      {
         GameStickManager.getInstance().restart();
      }
      
      protected function onShareClick(param1:MouseEvent) : void
      {
         GameStickManager.getInstance().share();
      }
      
      public function dispose() : void
      {
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_btnShare != null)
         {
            ObjectUtils.disposeObject(_btnShare);
            _btnShare.removeEventListener("click",onShareClick);
            _btnShare = null;
         }
         if(_btnRestart != null)
         {
            ObjectUtils.disposeObject(_btnRestart);
            _btnRestart.removeEventListener("click",onRestartClick);
            _btnRestart = null;
         }
         if(_btnExit != null)
         {
            _btnExit.removeEventListener("click",onExitClick);
            ObjectUtils.disposeObject(_btnExit);
            _btnExit = null;
         }
      }
   }
}
