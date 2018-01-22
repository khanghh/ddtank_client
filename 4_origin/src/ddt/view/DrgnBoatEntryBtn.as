package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import drgnBoat.DrgnBoatManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DrgnBoatEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:MovieClip;
      
      public function DrgnBoatEntryBtn()
      {
         super();
         this.buttonMode = true;
         this.mouseChildren = false;
         _btn = ComponentFactory.Instance.creat("asset.hall.dragonBoatBtn");
         _btn.gotoAndStop(1);
         addChild(_btn);
         addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(DrgnBoatManager.instance.isInGame)
         {
            DrgnBoatManager.instance.addEventListener("drgnBoatCanEnter",canEnterHandler);
            SocketManager.Instance.out.sendEscortCanEnter();
         }
         else
         {
            DrgnBoatManager.instance.show();
         }
      }
      
      private function canEnterHandler(param1:Event) : void
      {
         DrgnBoatManager.instance.removeEventListener("drgnBoatCanEnter",canEnterHandler);
         StateManager.setState("drgnBoat");
      }
      
      public function dispose() : void
      {
         DrgnBoatManager.instance.removeEventListener("drgnBoatCanEnter",canEnterHandler);
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
