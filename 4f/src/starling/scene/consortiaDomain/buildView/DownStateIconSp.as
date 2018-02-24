package starling.scene.consortiaDomain.buildView
{
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   import road7th.DDTAssetManager;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.text.TextField;
   
   public class DownStateIconSp extends Sprite
   {
       
      
      private var _buildId:int;
      
      private var _state:int = -1;
      
      private var _downGradeTf:TextField;
      
      private var _progressImage:Image;
      
      private var _tipsTf:TextField;
      
      private var _progressImageW:int = 137;
      
      public function DownStateIconSp(param1:int){super();}
      
      public function set state(param1:int) : void{}
      
      private function createTips(param1:int) : void{}
      
      public function onRepairPlayerNumChange(param1:Event) : void{}
      
      private function clear() : void{}
      
      override public function dispose() : void{}
   }
}
