package game.gametrainer.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.PlayerManager;
   import flash.display.MovieClip;
   import phy.object.PhysicalObj;
   
   public class TrainerEquip extends PhysicalObj
   {
       
      
      private var _equip:MovieClip;
      
      public function TrainerEquip(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,layerType,mass,gravityFactor,windFactor,airResitFactor);
         init();
      }
      
      private function init() : void
      {
         var str:String = !!PlayerManager.Instance.Self.Sex?"asset.trainer.TrainerManEquipAsset":"asset.trainer.TrainerWomanEquipAsset";
         _equip = ComponentFactory.Instance.creat(str);
         addChild(_equip);
      }
      
      override public function dispose() : void
      {
         if(_equip && _equip.parent)
         {
            _equip.parent.removeChild(_equip);
         }
         _equip = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
