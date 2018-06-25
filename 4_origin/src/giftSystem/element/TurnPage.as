package giftSystem.element
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TurnPage extends Sprite implements Disposeable
   {
      
      public static const CURRENTPAGE_CHANGE:String = "currentPageChange";
       
      
      private var _numShow:FilterFrameText;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _firstBtn:BaseButton;
      
      private var _endBtn:BaseButton;
      
      private var _numBG:Scale9CornerImage;
      
      private var _current:int;
      
      private var _total:int;
      
      public function TurnPage()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set current(value:int) : void
      {
         if(_current == value)
         {
            return;
         }
         _current = value;
         _numShow.text = _current + "/" + _total;
         dispatchEvent(new Event("currentPageChange"));
      }
      
      public function get current() : int
      {
         return _current;
      }
      
      public function set total(value:int) : void
      {
         if(_total == value)
         {
            return;
         }
         _total = value;
         _numShow.text = _current + "/" + _total;
      }
      
      public function get total() : int
      {
         return _total;
      }
      
      private function initView() : void
      {
         _numShow = ComponentFactory.Instance.creatComponentByStylename("TurnPage.numShow");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("ddtgiftleftbutton");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("ddtrightbutton");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("ddtfirstbutton");
         _endBtn = ComponentFactory.Instance.creatComponentByStylename("ddtendbutton");
         _numBG = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSystemTextViewII");
         addChild(_numBG);
         addChild(_numShow);
         addChild(_leftBtn);
         addChild(_rightBtn);
         addChild(_firstBtn);
         addChild(_endBtn);
      }
      
      private function drawSprit() : Sprite
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(0,0);
         sp.graphics.drawRect(0,0,25,25);
         sp.graphics.endFill();
         sp.buttonMode = true;
         return sp;
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__leftClick);
         _rightBtn.addEventListener("click",__rightClick);
         _firstBtn.addEventListener("click",__firtClick);
         _endBtn.addEventListener("click",__endClick);
      }
      
      private function __rightClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_current >= _total)
         {
            current = 1;
         }
         else
         {
            current = Number(current) + 1;
         }
      }
      
      private function __endClick(evnet:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         current = _total;
      }
      
      private function __leftClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_current <= 1)
         {
            current = total;
         }
         else
         {
            current = Number(current) - 1;
         }
      }
      
      private function __firtClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         current = 1;
      }
      
      private function removeEvent() : void
      {
         _leftBtn.removeEventListener("click",__leftClick);
         _rightBtn.removeEventListener("click",__rightClick);
         _firstBtn.removeEventListener("click",__firtClick);
         _endBtn.removeEventListener("click",__endClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_numBG)
         {
            ObjectUtils.disposeObject(_numBG);
         }
         _numBG = null;
         if(_numShow)
         {
            ObjectUtils.disposeObject(_numShow);
         }
         _numShow = null;
         if(_leftBtn)
         {
            ObjectUtils.disposeObject(_leftBtn);
         }
         _leftBtn = null;
         if(_rightBtn)
         {
            ObjectUtils.disposeObject(_rightBtn);
         }
         _rightBtn = null;
         if(_firstBtn)
         {
            ObjectUtils.disposeObject(_firstBtn);
         }
         _firstBtn = null;
         if(_endBtn)
         {
            ObjectUtils.disposeObject(_endBtn);
         }
         _endBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
