package farm.viewx.newPet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Point;
   import pet.data.PetSkillTemplateInfo;
   import petsBag.view.item.SkillItem;
   
   public class NewPetSkillPanel extends Sprite implements Disposeable
   {
       
      
      private var _petSkill:SimpleTileList;
      
      private var _petSkillScroll:ScrollPanel;
      
      private var _itemInfoVec:Array;
      
      private var _itemViewVec:Vector.<PetSkillItem>;
      
      public function NewPetSkillPanel(){super();}
      
      private function creatView() : void{}
      
      public function set itemInfo(param1:Array) : void{}
      
      public function update() : void{}
      
      protected function creatItems() : void{}
      
      public function set scrollVisble(param1:Boolean) : void{}
      
      private function removeItems() : void{}
      
      public function dispose() : void{}
   }
}
