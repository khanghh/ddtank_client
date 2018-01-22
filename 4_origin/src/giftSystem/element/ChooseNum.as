package giftSystem.element
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChooseNum extends Sprite implements Disposeable
   {
      
      public static const NUMBER_IS_CHANGE:String = "numberIsChange";
       
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _numShow:TextInput;
      
      private var _number:int;
      
      public function ChooseNum()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set number(param1:int) : void
      {
         _number = param1;
         _numShow.text = _number.toString();
         dispatchEvent(new Event("numberIsChange"));
      }
      
      public function get number() : int
      {
         return _number;
      }
      
      private function initView() : void
      {
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopDownButton");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopUpButton");
         PositionUtils.setPos(_leftBtn,"giftSystem.leftBtnPos");
         PositionUtils.setPos(_rightBtn,"giftSystem.rightBtnPos");
         _numShow = ComponentFactory.Instance.creatComponentByStylename("ChooseNum.numShow");
         _numShow.textField.restrict = "0-9";
         _numShow.textField.maxChars = 4;
         addChild(_leftBtn);
         addChild(_rightBtn);
         addChild(_numShow);
         number = 1;
      }
      
      private function drawSprit() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,28,28);
         _loc1_.graphics.endFill();
         _loc1_.buttonMode = true;
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__leftClick);
         _rightBtn.addEventListener("click",__rightClick);
         _numShow.addEventListener("change",__numberChange);
      }
      
      private function __rightClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(number == 9999)
         {
            return;
         }
         number = Number(number) + 1;
      }
      
      private function __leftClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(number == 1)
         {
            return;
         }
         number = Number(number) - 1;
      }
      
      private function removeEvent() : void
      {
         _leftBtn.removeEventListener("click",__leftClick);
         _rightBtn.removeEventListener("click",__rightClick);
         _numShow.addEventListener("change",__numberChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _leftBtn = null;
         _rightBtn = null;
         _numShow = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function __numberChange(param1:Event) : void
      {
         if(_numShow.text == "" || parseInt(_numShow.text) == 0)
         {
            number = 1;
         }
         else
         {
            number = parseInt(_numShow.text);
         }
      }
   }
}
