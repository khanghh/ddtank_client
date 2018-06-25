package starling.scene.consortiaDomain
{
   import consortiaDomain.ConsortiaDomainManager;
   import flash.events.Event;
   import road7th.DDTAssetManager;
   import starling.display.Sprite;
   import starling.scene.common.BgLayer;
   import starling.textures.SubTexture;
   
   public class StaticLayer extends Sprite
   {
       
      
      private var _bgLayer:BgLayer;
      
      public function StaticLayer()
      {
         super();
         _bgLayer = new BgLayer(ConsortiaDomainManager.instance.bgLayerViewRect,DDTAssetManager.instance.starlingAsset.getTexture("consortia_domain_scene/0_0") as SubTexture,DDTAssetManager.instance.starlingAsset.getTexture("consortia_domain_scene/1_0") as SubTexture);
         _bgLayer.touchable = false;
         addChild(_bgLayer);
         ConsortiaDomainManager.instance.addEventListener("resize",onStageResize);
      }
      
      public function setCenter() : void
      {
         _bgLayer.setCenter();
      }
      
      public function onStageResize(evt:Event) : void
      {
         _bgLayer.onStageResize();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ConsortiaDomainManager.instance.removeEventListener("resize",onStageResize);
         _bgLayer = null;
      }
   }
}
