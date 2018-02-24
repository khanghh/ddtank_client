package gameStick.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameStick.GameStickManager;
   
   public class GameStickDetailBoard extends Sprite implements Disposeable
   {
       
      
      private var _bg:Sprite;
      
      private var _btnOK:SimpleBitmapButton;
      
      public function GameStickDetailBoard(){super();}
      
      protected function onOK(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
