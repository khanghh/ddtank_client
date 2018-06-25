package littleGame.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import littleGame.model.LittleSelf;
   
   public class ClickGame extends Sprite implements Disposeable
   {
       
      
      private var _clickTextField:TextField;
      
      private var _startTime:int;
      
      private var _clickCount:int = 0;
      
      private var _self:LittleSelf;
      
      private var _asset:MovieClip;
      
      public function ClickGame()
      {
         super();
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         var pen:Graphics = graphics;
         pen.beginFill(0,0);
         pen.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         pen.endFill();
         var text:TextField = new TextField();
         text.defaultTextFormat = new TextFormat("Arial",20,65280,true);
         text.autoSize = "left";
         text.text = "Click Screen!!!";
         text.mouseEnabled = false;
         text.x = StageReferance.stageWidth - text.width >> 1;
         addChild(text);
         _clickTextField = new TextField();
         _clickTextField.defaultTextFormat = new TextFormat("Arial",20,16711680,true);
         _clickTextField.autoSize = "left";
         _clickTextField.mouseEnabled = false;
         addChild(_clickTextField);
         var cls:Class = getDefinitionByName("littlegame.object.normalBoguInhaled") as Class;
         _asset = new cls() as MovieClip;
         addChild(_asset);
      }
      
      private function addEvent() : void
      {
      }
      
      private function __shutdown(event:Event) : void
      {
         dispatchEvent(new Event("complete"));
         dispose();
      }
      
      private function __startup(event:Event) : void
      {
         _startTime = getTimer();
         addEventListener("click",__clicked);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clicked);
      }
      
      private function __clicked(event:MouseEvent) : void
      {
         var now:int = getTimer();
         _clickCount = Number(_clickCount) + 1;
         _clickTextField.text = "click:" + _clickCount;
         _clickTextField.x = StageReferance.stageWidth - _clickTextField.width >> 1;
         _clickTextField.y = StageReferance.stageHeight - _clickTextField.height >> 1;
         if(_asset["water"].totalFrames >= _asset["water"].currentFrame + 2)
         {
            _asset["water"].gotoAndStop(_asset["water"].currentFrame + 4);
         }
         else
         {
            _asset["water"].gotoAndStop(_asset["water"].totalFrames);
         }
         _asset.play();
         __shutdown(null);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
