package dice.view
{
   import com.pickgliss.manager.CacheSysManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.states.BaseStateView;
   import dice.controller.DiceController;
   
   public class DiceSystem extends BaseStateView
   {
       
      
      private var _diceView:DiceSystemView;
      
      public function DiceSystem()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         CacheSysManager.lock("alertInDiceSystem");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _diceView = new DiceSystemView(DiceController.Instance);
         addChild(_diceView);
         super.enter(prev,data);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         CacheSysManager.unlock("alertInDiceSystem");
         CacheSysManager.getInstance().release("alertInDiceSystem");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(next);
      }
      
      override public function getType() : String
      {
         return "diceSystem";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function dispose() : void
      {
         if(_diceView)
         {
            _diceView.dispose();
            _diceView = null;
         }
      }
   }
}
