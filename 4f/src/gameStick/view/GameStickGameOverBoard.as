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
      
      public function GameStickGameOverBoard(){super();}
      
      protected function onExitClick(param1:MouseEvent) : void{}
      
      protected function onRestartClick(param1:MouseEvent) : void{}
      
      protected function onShareClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
