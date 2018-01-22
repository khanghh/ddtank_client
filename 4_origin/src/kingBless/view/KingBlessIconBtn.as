package kingBless.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kingBless.KingBlessManager;
   
   public class KingBlessIconBtn extends Component
   {
       
      
      private var _btn:MovieClip;
      
      public function KingBlessIconBtn()
      {
         super();
         this.mouseChildren = false;
         _btn = ComponentFactory.Instance.creat("asset.kingBless.iconBtn");
         _btn.gotoAndStop(1);
         addChild(_btn);
         refreshCartoonState(null);
         this.buttonMode = true;
         this.addEventListener("click",openKingBlessFrame,false,0,true);
         KingBlessManager.instance.addEventListener("update_main_event",refreshCartoonState);
      }
      
      private function refreshCartoonState(param1:Event) : void
      {
         var _loc3_:MovieClip = _btn["cartoon"] as MovieClip;
         var _loc2_:MovieClip = _btn["icon"] as MovieClip;
         if(_loc3_)
         {
            if(KingBlessManager.instance.openType > 0)
            {
               _loc3_.gotoAndPlay(1);
               _loc2_.gotoAndPlay(1);
            }
            else
            {
               _loc3_.gotoAndStop(_loc3_.totalFrames);
               _loc2_.gotoAndStop(1);
            }
         }
      }
      
      private function openKingBlessFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         KingBlessManager.instance.show();
      }
      
      override public function get tipData() : Object
      {
         return KingBlessManager.instance.getRemainTimeTxt();
      }
      
      override public function get height() : Number
      {
         if(_btn)
         {
            return 65;
         }
         return super.height;
      }
      
      override public function dispose() : void
      {
         KingBlessManager.instance.removeEventListener("update_main_event",refreshCartoonState);
         this.removeEventListener("click",openKingBlessFrame);
         if(_btn)
         {
            _btn.gotoAndStop(2);
            if(_btn.parent)
            {
               _btn.parent.removeChild(_btn);
            }
            _btn = null;
         }
         super.dispose();
      }
   }
}
