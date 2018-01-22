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
      
      public function NewPetSkillPanel()
      {
         super();
         _itemInfoVec = [];
         _itemViewVec = new Vector.<PetSkillItem>();
         creatView();
      }
      
      private function creatView() : void
      {
         _petSkillScroll = ComponentFactory.Instance.creatComponentByStylename("farm.scrollPanel.petSkillPnl");
         addChild(_petSkillScroll);
         _petSkill = ComponentFactory.Instance.creatCustomObject("farm.simpleTileList.petSkill",[4]);
         _petSkillScroll.setView(_petSkill);
      }
      
      public function set itemInfo(param1:Array) : void
      {
         _itemInfoVec = param1;
         _itemInfoVec.sortOn("ID",16);
         update();
      }
      
      public function update() : void
      {
         removeItems();
         creatItems();
      }
      
      protected function creatItems() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc1_:int = 8;
         var _loc6_:int = 0;
         var _loc5_:* = _itemInfoVec;
         for each(var _loc3_ in _itemInfoVec)
         {
            if(_loc3_)
            {
               _loc4_++;
               _loc2_ = new PetSkillItem(_loc3_,_loc4_);
               _loc2_.DoubleClickEnabled = true;
               _loc2_.iconPos = new Point(2.5,2.5);
               _petSkill.addChild(_loc2_);
               _itemViewVec.push(_loc2_);
            }
         }
         _loc1_ = 8;
         while(_loc4_ < _loc1_)
         {
            _loc4_++;
            _loc2_ = new PetSkillItem(null,_loc4_);
            _loc2_.iconPos = new Point(3,3);
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
            _petSkill.addChild(_loc2_);
            _itemViewVec.push(_loc2_);
         }
      }
      
      public function set scrollVisble(param1:Boolean) : void
      {
         _petSkillScroll.vScrollbar.visible = param1;
      }
      
      private function removeItems() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _itemViewVec;
         for each(var _loc1_ in _itemViewVec)
         {
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         _itemViewVec.splice(0,_itemViewVec.length);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_petSkill);
         _petSkill = null;
         ObjectUtils.disposeObject(_petSkillScroll);
         _petSkillScroll = null;
         _itemInfoVec = null;
         _itemViewVec = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
