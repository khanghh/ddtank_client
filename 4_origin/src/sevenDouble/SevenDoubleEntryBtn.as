package sevenDouble
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SevenDoubleEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:MovieClip;
      
      public function SevenDoubleEntryBtn()
      {
         super();
         this.buttonMode = true;
         this.mouseChildren = false;
         _btn = ComponentFactory.Instance.creat("asset.sevenDouble.entryBtn");
         _btn.gotoAndStop(1);
         addChild(_btn);
         addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(SevenDoubleManager.instance.isInGame)
         {
            SevenDoubleManager.instance.addEventListener("sevenDoubleCanEnter",canEnterHandler);
            SocketManager.Instance.out.sendSevenDoubleCanEnter();
         }
         else
         {
            SevenDoubleManager.instance.show();
         }
      }
      
      private function canEnterHandler(event:Event) : void
      {
         SevenDoubleManager.instance.removeEventListener("sevenDoubleCanEnter",canEnterHandler);
         StateManager.setState("sevenDoubleScene");
      }
      
      public function dispose() : void
      {
         SevenDoubleManager.instance.removeEventListener("sevenDoubleCanEnter",canEnterHandler);
         removeEventListener("click",clickHandler);
         if(_btn)
         {
            _btn.gotoAndStop(2);
         }
         removeChild(_btn);
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
