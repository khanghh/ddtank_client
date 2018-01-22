package game.gametrainer.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.PlayerManager;
   import flash.display.MovieClip;
   import phy.object.PhysicalObj;
   
   public class TrainerEquip extends PhysicalObj
   {
       
      
      private var _equip:MovieClip;
      
      public function TrainerEquip(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1){super(null,null,null,null,null,null);}
      
      private function init() : void{}
      
      override public function dispose() : void{}
   }
}
