package game.gametrainer.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import phy.object.PhysicalObj;
   
   public class TrainerWeapon extends PhysicalObj
   {
       
      
      private var _weaponAsset:MovieClip;
      
      public function TrainerWeapon(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1)
      {
         super(param1,param2,param3,param4,param5,param6);
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
