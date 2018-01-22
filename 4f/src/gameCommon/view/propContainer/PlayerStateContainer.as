package gameCommon.view.propContainer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.events.LivingEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.ItemCellView;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import pet.data.PetSkillTemplateInfo;
   
   public class PlayerStateContainer extends SimpleTileList
   {
       
      
      private var _info:TurnedLiving;
      
      public function PlayerStateContainer(param1:Number = 10){super(null);}
      
      public function get info() : TurnedLiving{return null;}
      
      public function set info(param1:TurnedLiving) : void{}
      
      private function __addingState(param1:LivingEvent) : void{}
      
      protected function __useSkillHandler(param1:LivingEvent) : void{}
      
      private function __usePetSkill(param1:LivingEvent) : void{}
      
      override public function dispose() : void{}
   }
}
