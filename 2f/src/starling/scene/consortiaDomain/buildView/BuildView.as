package starling.scene.consortiaDomain.buildView
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import consortion.ConsortionModelManager;
   import ddt.bagStore.BagStore;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import road7th.DDTAssetManager;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.Texture;
   import starlingui.core.components.PixelButton;
   import trainer.controller.WeakGuildManager;
   
   public class BuildView extends Sprite
   {
       
      
      public var buildId:int;
      
      private var _buildName:String;
      
      private var _state:int = -1;
      
      private var _build:PixelButton;
      
      private var _effArr:Array;
      
      private var _effSp:Sprite;
      
      private var _buildNameBg:Image;
      
      private var _buildNameImage:Image;
      
      private var _upStateIconSp:UpStateIconSp;
      
      private var _downStateIconSp:DownStateIconSp;
      
      private var _buildImageScale:Number;
      
      private var _upGradeBtn:Button;
      
      private var _openBtn:Button;
      
      private var _isShow:Boolean;
      
      public function BuildView(param1:int, param2:Number){super();}
      
      public function setBuildXY(param1:int, param2:int) : void{}
      
      public function createEff(param1:String, param2:int, param3:int, param4:Number = 1, param5:Number = 1) : void{}
      
      private function openBuildFrame() : void{}
      
      private function onBuildStateChange(param1:flash.events.Event) : void{}
      
      public function get state() : int{return 0;}
      
      public function set state(param1:int) : void{}
      
      private function updateBuildNameImage() : void{}
      
      private function onTouchBuild(param1:TouchEvent) : void{}
      
      private function showBtns(param1:Boolean) : void{}
      
      private function onBtnClick(param1:starling.events.Event) : void{}
      
      override public function dispose() : void{}
   }
}
