package starling.core
{
   import flash.system.System;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.text.TextField;
   
   class StatsDisplay extends Sprite
   {
       
      
      private const UPDATE_INTERVAL:Number = 0.5;
      
      private var mBackground:Quad;
      
      private var mTextField:TextField;
      
      private var mFrameCount:int = 0;
      
      private var mTotalTime:Number = 0;
      
      private var mFps:Number = 0;
      
      private var mMemory:Number = 0;
      
      private var mDrawCount:int = 0;
      
      function StatsDisplay()
      {
         super();
         mBackground = new Quad(50,25,0);
         mTextField = new TextField(48,25,"","mini",-1,16777215);
         mTextField.x = 2;
         mTextField.hAlign = "left";
         mTextField.vAlign = "top";
         addChild(mBackground);
         addChild(mTextField);
         blendMode = "none";
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onAddedToStage() : void
      {
         addEventListener("enterFrame",onEnterFrame);
         mFrameCount = 0;
         mTotalTime = 0;
         update();
      }
      
      private function onRemovedFromStage() : void
      {
         removeEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(event:EnterFrameEvent) : void
      {
         mTotalTime = mTotalTime + event.passedTime;
         mFrameCount = Number(mFrameCount) + 1;
         if(mTotalTime > 0.5)
         {
            update();
            mTotalTime = 0;
            mFrameCount = 0;
         }
      }
      
      public function update() : void
      {
         mFps = mTotalTime > 0?mFrameCount / mTotalTime:0;
         mMemory = System.totalMemory * 9.54e-7;
         mTextField.text = "FPS: " + mFps.toFixed(mFps < 100?1:0) + "\nMEM: " + mMemory.toFixed(mMemory < 100?1:0) + "\nDRW: " + (mTotalTime > 0?mDrawCount - 2:mDrawCount);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         support.finishQuadBatch();
         super.render(support,parentAlpha);
      }
      
      public function get drawCount() : int
      {
         return mDrawCount;
      }
      
      public function set drawCount(value:int) : void
      {
         mDrawCount = value;
      }
      
      public function get fps() : Number
      {
         return mFps;
      }
      
      public function set fps(value:Number) : void
      {
         mFps = value;
      }
      
      public function get memory() : Number
      {
         return mMemory;
      }
      
      public function set memory(value:Number) : void
      {
         mMemory = value;
      }
   }
}
