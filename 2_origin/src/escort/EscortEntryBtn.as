package escort
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
   
   public class EscortEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:MovieClip;
      
      public function EscortEntryBtn()
      {
         super();
         this.buttonMode = true;
         this.mouseChildren = false;
         _btn = ComponentFactory.Instance.creat("asset.escort.entryBtn");
         _btn.gotoAndStop(1);
         addChild(_btn);
         addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(EscortManager.instance.isInGame)
         {
            EscortManager.instance.addEventListener("escortCanEnter",canEnterHandler);
            SocketManager.Instance.out.sendEscortCanEnter();
         }
         else
         {
            EscortManager.instance.show();
         }
      }
      
      private function canEnterHandler(event:Event) : void
      {
         EscortManager.instance.removeEventListener("escortCanEnter",canEnterHandler);
         StateManager.setState("escort");
      }
      
      public function dispose() : void
      {
         EscortManager.instance.removeEventListener("escortCanEnter",canEnterHandler);
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
