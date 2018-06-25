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
      
      public function FadingBlock(func:Function, showLoading:Function)
      {
         super();
         _func = func;
         _showLoading = showLoading;
         _life = 0;
         _newStart = true;
         _canSave = true;
         _oldWidth = StageReferance.stageWidth;
         _oldHeight = StageReferance.stageHeight;
         if(StateManager.RecordFlag)
         {
            this.x = 13;
            this.y = 35;
         }
      }
      
      private function resetBlock() : void
      {
         if(_oldWidth != StageReferance.stageWidth || _oldWidth != StageReferance.stageHeight)
         {
            _oldWidth = StageReferance.stageWidth;
            _oldHeight = StageReferance.stageHeight;
            graphics.clear();
            graphics.beginFill(0);
            graphics.drawRect(0,0,_oldWidth + 8,_oldHeight + 8);
            graphics.endFill();
         }
      }
      
      public function setNextState(next:BaseStateView) : void
      {
         _nextView = next;
         _canSave = StateManager.currentStateType != "login" && StateManager.currentStateType != "main";
      }
      
      public function update() : void
      {
         if(parent == null)
         {
            resetBlock();
            LayerManager.Instance.addToLayer(this,2,false,0,false);
         }
         if(_newStart)
         {
            if(StateManager.isShowFadingAnimation)
            {
               alpha = 0;
               _life = 0;
               _exected = false;
               _showed = false;
               addEventListener("enterFrame",__enterFrame);
            }
            else
            {
               _func();
               if(parent)
               {
                  parent.removeChild(this);
               }
               dispatchEvent(new Event("complete"));
               _nextView.fadingComplete();
               return;
            }
         }
         else
         {
            _life = 1;
            alpha = _life;
            _exected = false;
         }
         _newStart = false;
      }
      
      public function stopImidily() : void
      {
         parent.removeChild(this);
         removeEventListener("enterFrame",__enterFrame);
         _newStart = true;
         dispatchEvent(new Event("complete"));
      }
      
      public function set executed(value:Boolean) : void
      {
         _exected = value;
      }
      
      private function __enterFrame(event:Event) : void
      {
         var tick:int = 0;
         var time:Number = NaN;
         if(_life < 1)
         {
            _life = _life + 0.16;
            alpha = _life;
         }
         else if(_life < 2)
         {
            tick = getTimer();
            if(_canSave)
            {
               LoaderSavingManager.saveFilesToLocal();
            }
            tick = getTimer() - tick;
            time = tick / 40 * 0.1;
            _life = _life + (time < 0.1?0.1:Number(time));
            if(_life > 2)
            {
               _life = 2.01;
            }
            if(!_exected)
            {
               _exected = true;
               alpha = 1;
               _func();
            }
         }
         else if(_life >= 2 && canDisappear)
         {
            _life = _life + 0.16;
            alpha = 3 - _life;
            if(alpha < 0.2)
            {
               if(parent)
               {
                  parent.removeChild(this);
               }
               removeEventListener("enterFrame",__enterFrame);
               canDisappear = false;
               _newStart = true;
               dispatchEvent(new Event("complete"));
               _nextView.fadingComplete();
            }
         }
      }
   }
}
