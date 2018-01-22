package midAutumnWorshipTheMoon.view
{
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   
   public class WorshipTheMoonEnterButton extends SimpleBitmapButton
   {
       
      
      private var _hall:HallStateView;
      
      public function WorshipTheMoonEnterButton()
      {
         super();
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      public function show() : void
      {
         if(_hall != null)
         {
            _hall.leftTopGbox.addChild(this);
            _hall.arrangeLeftGrid();
            this.addEventListener("click",onClick);
         }
      }
      
      public function hide() : void
      {
         if(_hall != null)
         {
            this.parent && _hall.leftTopGbox.removeChild(this);
            _hall.arrangeLeftGrid();
            this.removeEventListener("click",onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade >= 15)
         {
            WorshipTheMoonManager.getInstance().show();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worshipTheMoon.higherGradeNeeded"),0,true,1);
         }
      }
      
      public function set hallView(param1:HallStateView) : void
      {
         _hall = param1;
      }
      
      override public function dispose() : void
      {
         hide();
         _hall = null;
         super.dispose();
      }
   }
}
