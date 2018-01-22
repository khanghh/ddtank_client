package dice.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import dice.DiceManager;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DiceReturnBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _stretchBtn:SelectedButton;
      
      private var _returnBtn:BaseButton;
      
      private var _pos:Point;
      
      public function DiceReturnBar()
      {
         super();
         initialize();
         addEvent();
      }
      
      private function initialize() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.dice.returnBarBG");
         _stretchBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.returnBar.stretchBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.returnBar.returnBtn");
         _pos = ComponentFactory.Instance.creatCustomObject("asset.dice.returnBar.position");
         addChild(_bg);
         addChild(_stretchBtn);
         addChild(_returnBtn);
      }
      
      private function addEvent() : void
      {
         _stretchBtn.addEventListener("click",__onStretchBtnClick);
         _returnBtn.addEventListener("click",__onReturnClick);
      }
      
      private function __onStretchBtnClick(param1:MouseEvent) : void
      {
         TweenLite.to(this,0.5,{"x":(!!_stretchBtn.selected?_pos.y:Number(_pos.x))});
      }
      
      private function __onReturnClick(param1:MouseEvent) : void
      {
         DiceController.Instance.isPlayDownMovie = false;
         DiceController.Instance.isFirst = true;
         DiceManager.Instance.dispatchEvent(new DiceEvent("dice_return"));
      }
      
      private function removeEvent() : void
      {
         _stretchBtn.removeEventListener("click",__onStretchBtnClick);
         _returnBtn.removeEventListener("click",__onReturnClick);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_stretchBtn);
         _stretchBtn = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
