package ddt.states
{
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.StateManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class FadingBlock extends Sprite
   {
       
      
      private var _func:Function;
      
      private var _life:Number;
      
      private var _exected:Boolean;
      
      private var _nextView:BaseStateView;
      
      private var _showLoading:Function;
      
      private var _newStart:Boolean;
      
      private var _showed:Boolean;
      
      private var _canSave:Boolean;
      
      private var _oldWidth:int;
      
      private var _oldHeight:int;
      
      public var canDisappear:Boolean = false;
      
      public function FadingBlock(param1:Function, param2:Function){super();}
      
      private function resetBlock() : void{}
      
      public function setNextState(param1:BaseStateView) : void{}
      
      public function update() : void{}
      
      public function stopImidily() : void{}
      
      public function set executed(param1:Boolean) : void{}
      
      private function __enterFrame(param1:Event) : void{}
   }
}
