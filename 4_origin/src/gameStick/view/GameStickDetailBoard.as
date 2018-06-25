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
      
      public function GameStickDetailBoard()
      {
         super();
         _bg = ComponentFactory.Instance.creat("asset.gamestick.detail");
         addChild(_bg);
         _btnOK = ComponentFactory.Instance.creat("asset.gamestick.okToStart");
         _btnOK.addEventListener("click",onOK);
         addChild(_btnOK);
      }
      
      protected function onOK(e:MouseEvent) : void
      {
         ObjectUtils.disposeObject(this);
         GameStickManager.getInstance().startGame();
      }
      
      public function dispose() : void
      {
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_btnOK != null)
         {
            _btnOK.removeEventListener("click",onOK);
            ObjectUtils.disposeObject(_btnOK);
            _btnOK = null;
         }
      }
   }
}
