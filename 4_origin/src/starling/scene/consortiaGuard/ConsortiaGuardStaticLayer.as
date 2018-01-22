package starling.scene.consortiaGuard
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import road7th.DDTAssetManager;
   import starling.display.Sprite;
   import starling.scene.common.BgLayer;
   import starling.textures.SubTexture;
   
   public class ConsortiaGuardStaticLayer extends Sprite
   {
       
      
      private var _bg:BgLayer;
      
      private var _rect:Rectangle;
      
      public function ConsortiaGuardStaticLayer()
      {
         super();
         _rect = new Rectangle(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _bg = new BgLayer(_rect,DDTAssetManager.instance.starlingAsset.getTexture("consortiaGuardMap") as SubTexture);
         _bg.touchable = false;
         addChild(_bg);
         StageReferance.stage.addEventListener("resize",__onReset);
      }
      
      public function setCenter() : void
      {
         _bg.setCenter();
      }
      
      public function __onReset(param1:Event) : void
      {
         _rect.width = StageReferance.stage.stageWidth;
         _rect.height = StageReferance.stage.stageHeight;
         _bg.onStageResize();
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         _rect.x = param1;
         _rect.y = param2;
      }
      
      override public function dispose() : void
      {
         _rect = null;
         StageReferance.stage.removeEventListener("resize",__onReset);
         StarlingObjectUtils.disposeObject(_bg);
         _bg = null;
         super.dispose();
      }
   }
}
