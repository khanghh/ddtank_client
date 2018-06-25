package starling.scene.consortiaDomain{   import consortiaDomain.ConsortiaDomainManager;   import flash.events.Event;   import road7th.DDTAssetManager;   import starling.display.Sprite;   import starling.scene.common.BgLayer;   import starling.textures.SubTexture;      public class StaticLayer extends Sprite   {                   private var _bgLayer:BgLayer;            public function StaticLayer() { super(); }
            public function setCenter() : void { }
            public function onStageResize(evt:Event) : void { }
            override public function dispose() : void { }
   }}