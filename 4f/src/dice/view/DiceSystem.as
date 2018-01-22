package dice.view
{
   import com.pickgliss.manager.CacheSysManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.states.BaseStateView;
   import dice.controller.DiceController;
   
   public class DiceSystem extends BaseStateView
   {
       
      
      private var _diceView:DiceSystemView;
      
      public function DiceSystem(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function dispose() : void{}
   }
}
