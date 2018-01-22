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
         var _loc1_:Graphics = graphics;
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _loc1_.endFill();
         var _loc2_:TextField = new TextField();
         _loc2_.defaultTextFormat = new TextFormat("Arial",20,65280,true);
         _loc2_.autoSize = "left";
         _loc2_.text = "Click Screen!!!";
         _loc2_.mouseEnabled = false;
         _loc2_.x = StageReferance.stageWidth - _loc2_.width >> 1;
         addChild(_loc2_);
         _clickTextField = new TextField();
         _clickTextField.defaultTextFormat = new TextFormat("Arial",20,16711680,true);
         _clickTextField.autoSize = "left";
         _clickTextField.mouseEnabled = false;
         addChild(_clickTextField);
         var _loc3_:Class = getDefinitionByName("littlegame.object.normalBoguInhaled") as Class;
         _asset = new _loc3_() as MovieClip;
         addChild(_asset);
      }
      
      private function addEvent() : void
      {
      }
      
      private function __shutdown(param1:Event) : void
      {
         dispatchEvent(new Event("complete"));
         dispose();
      }
      
      private function __startup(param1:Event) : void
      {
         _startTime = getTimer();
         addEventListener("click",__clicked);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clicked);
      }
      
      private function __clicked(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
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
