package littleGame.menu
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import littleGame.LittleGameManager;
   
   public class LittleMenuBar extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _returnButton:BaseButton;
      
      private var _switchButton:SwitchButton;
      
      private var _mode:int = 1;
      
      public function LittleMenuBar()
      {
         super();
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.littleGame.menuBG");
         addChild(_back);
         _returnButton = ComponentFactory.Instance.creatComponentByStylename("littleGame.ReturnButton");
         addChild(_returnButton);
         _switchButton = new SwitchButton();
         addChild(_switchButton);
         _switchButton.mode = _mode;
      }
      
      private function addEvent() : void
      {
         _switchButton.addEventListener("click",__switchMode);
         _returnButton.addEventListener("click",__return);
      }
      
      private function __return(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LittleGameManager.Instance.leave();
      }
      
      private function __switchMode(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_mode == 1)
         {
            _mode = 2;
            hide();
         }
         else
         {
            _mode = 1;
            show();
         }
         _switchButton.mode = _mode;
      }
      
      private function hide() : void
      {
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("littleGame.menu.pos2");
         TweenLite.to(this,0.3,{"x":_loc1_.x});
      }
      
      private function show() : void
      {
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("littleGame.menu.pos1");
         TweenLite.to(this,0.3,{"x":_loc1_.x});
      }
      
      private function removeEvent() : void
      {
         _switchButton.removeEventListener("click",__switchMode);
         _returnButton.removeEventListener("click",__return);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_switchButton);
         _switchButton = null;
         ObjectUtils.disposeObject(_returnButton);
         _returnButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
