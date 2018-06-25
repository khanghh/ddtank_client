package game.gametrainer.view
{
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.SoundManager;
   import flash.events.KeyboardEvent;
   import game.gametrainer.TrainerEvent;
   import org.aswing.KeyboardManager;
   
   public class QuestionOverView extends Frame
   {
       
      
      public function QuestionOverView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.moveEnable = false;
         this.dispatchEvent(new TrainerEvent("closeFrame"));
      }
      
      public function set gotoAndStopTip(frame:int) : void
      {
      }
      
      private function __okFunction() : void
      {
         SoundManager.instance.play("008");
         this.dispatchEvent(new TrainerEvent("closeFrame"));
      }
      
      protected function __onKeyDownd(e:KeyboardEvent) : void
      {
         KeyboardManager.getInstance().reset();
         if(e.keyCode != 27)
         {
            return;
         }
         e.stopImmediatePropagation();
         this.dispatchEvent(new TrainerEvent("closeFrame"));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
