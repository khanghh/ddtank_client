package gameCommon.view.propContainer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PropShortCutView extends Sprite
   {
       
      
      private var _btn0:SimpleBitmapButton;
      
      private var _btn1:SimpleBitmapButton;
      
      private var _btn2:SimpleBitmapButton;
      
      private var _index:int;
      
      public function PropShortCutView()
      {
         super();
         _btn0 = ComponentFactory.Instance.creatComponentByStylename("asset.game.deletePropBtn1");
         addChild(_btn0);
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("asset.game.deletePropBtn2");
         addChild(_btn1);
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("asset.game.deletePropBtn3");
         addChild(_btn2);
         addEvent();
         setPropCloseVisible(0,false);
         setPropCloseVisible(1,false);
         setPropCloseVisible(2,false);
      }
      
      public function setPropCloseVisible(index:uint, b:Boolean) : void
      {
         this["_btn" + index.toString()].alpha = !!b?1:0;
      }
      
      public function setPropCloseEnabled(index:uint, b:Boolean) : void
      {
         this["_btn" + index.toString()].mouseEnabled = b;
      }
      
      private function addEvent() : void
      {
         _btn0.addEventListener("click",__throw);
         _btn1.addEventListener("click",__throw);
         _btn2.addEventListener("click",__throw);
         _btn0.addEventListener("mouseOver",__over);
         _btn1.addEventListener("mouseOver",__over);
         _btn2.addEventListener("mouseOver",__over);
         _btn0.addEventListener("mouseOut",__out);
         _btn1.addEventListener("mouseOut",__out);
         _btn2.addEventListener("mouseOut",__out);
      }
      
      private function removeEvent() : void
      {
         _btn0.removeEventListener("click",__throw);
         _btn1.removeEventListener("click",__throw);
         _btn2.removeEventListener("click",__throw);
         _btn0.removeEventListener("mouseOver",__over);
         _btn1.removeEventListener("mouseOver",__over);
         _btn2.removeEventListener("mouseOver",__over);
         _btn0.removeEventListener("mouseOut",__out);
         _btn1.removeEventListener("mouseOut",__out);
         _btn2.removeEventListener("mouseOut",__out);
      }
      
      private function __throw(event:MouseEvent) : void
      {
         if((event.target as SimpleBitmapButton).alpha == 0)
         {
            return;
         }
         var _loc2_:* = event.target;
         if(_btn0 !== _loc2_)
         {
            if(_btn1 !== _loc2_)
            {
               if(_btn2 === _loc2_)
               {
                  _index = 2;
               }
            }
            else
            {
               _index = 1;
            }
         }
         else
         {
            _index = 0;
         }
         SoundManager.instance.play("008");
         deleteProp();
      }
      
      private function deleteProp() : void
      {
         GameInSocketOut.sendThrowProp(_index);
         SoundManager.instance.play("008");
         stage.focus = null;
      }
      
      private function __over(event:MouseEvent) : void
      {
         (event.target as SimpleBitmapButton).alpha = 1;
      }
      
      private function __out(event:MouseEvent) : void
      {
         (event.target as SimpleBitmapButton).alpha = 0;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _btn0.dispose();
         _btn0 = null;
         _btn1.dispose();
         _btn1 = null;
         _btn2.dispose();
         _btn2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
