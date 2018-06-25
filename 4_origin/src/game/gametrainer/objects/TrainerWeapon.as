package game.gametrainer.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import phy.object.PhysicalObj;
   
   public class TrainerWeapon extends PhysicalObj
   {
       
      
      private var _weaponAsset:MovieClip;
      
      public function TrainerWeapon(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,layerType,mass,gravityFactor,windFactor,airResitFactor);
         init();
      }
      
      private function init() : void
      {
         _weaponAsset = ComponentFactory.Instance.creat("asset.trainer.TrainerWeaponAsset");
         addChild(_weaponAsset);
      }
      
      override public function dispose() : void
      {
         if(_weaponAsset && _weaponAsset.parent)
         {
            _weaponAsset.parent.removeChild(_weaponAsset);
         }
         _weaponAsset = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
