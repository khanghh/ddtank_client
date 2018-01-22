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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         CacheSysManager.lock("alertInDiceSystem");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _diceView = new DiceSystemView(DiceController.Instance);
         addChild(_diceView);
         super.enter(param1,param2);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         CacheSysManager.unlock("alertInDiceSystem");
         CacheSysManager.getInstance().release("alertInDiceSystem");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(param1);
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
