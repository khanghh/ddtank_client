package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import pet.data.PetSkill;
   import pet.data.PetSkillTemplateInfo;
   import petsBag.PetsBagManager;
   import petsBag.event.PetItemEvent;
   import petsBag.view.item.SkillItem;
   
   public class PetSkillPnl extends Sprite implements Disposeable
   {
       
      
      private var _petSkill:SimpleTileList;
      
      private var _petSkillScroll:ScrollPanel;
      
      private var _isWatch:Boolean = false;
      
      private var _itemInfoVec:Array;
      
      private var _itemViewVec:Vector.<SkillItem>;
      
      public function PetSkillPnl(param1:Boolean)
      {
         _isWatch = param1;
         super();
         _itemInfoVec = [];
         _itemViewVec = new Vector.<SkillItem>();
         creatView();
      }
      
      private function creatView() : void
      {
         if(!_isWatch)
         {
            _petSkillScroll = ComponentFactory.Instance.creatComponentByStylename("petsBag.scrollPanel.petSkillPnl");
            addChild(_petSkillScroll);
            _petSkill = ComponentFactory.Instance.creatCustomObject("petsBag.simpleTileList.petSkill",[4]);
            _petSkillScroll.setView(_petSkill);
         }
         else
         {
            _petSkillScroll = ComponentFactory.Instance.creatComponentByStylename("petsBag.scrollPanel.petSkillPnlWatch");
            addChild(_petSkillScroll);
            _petSkill = ComponentFactory.Instance.creatCustomObject("petsBag.simpleTileList.petSkill",[7]);
            _petSkillScroll.setView(_petSkill);
         }
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
               _loc2_ = new SkillItem(_loc3_,_loc4_,true,_isWatch);
               _loc2_.DoubleClickEnabled = true;
               _loc2_.McType = 1;
               _loc2_.iconPos = new Point(2.5,2.5);
               _loc2_.setExclusiveSkillImg();
               _petSkill.addChild(_loc2_);
               _itemViewVec.push(_loc2_);
            }
         }
         _loc1_ = !!_isWatch?14:8;
         while(_loc4_ < _loc1_)
         {
            _loc4_++;
            _loc2_ = new SkillItem(null,_loc4_,true,_isWatch);
            _loc2_.iconPos = new Point(3,3);
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
            _loc2_.McType = 1;
            _loc2_.setExclusiveSkillImg();
            _petSkill.addChild(_loc2_);
            _itemViewVec.push(_loc2_);
         }
         if(!_isWatch)
         {
            initEvent();
         }
      }
      
      public function set scrollVisble(param1:Boolean) : void
      {
         _petSkillScroll.vScrollbar.visible = param1;
      }
      
      private function removeItems() : void
      {
         removeEvent();
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
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemViewVec.length)
         {
            _itemViewVec[_loc1_].addEventListener("itemclick",__skillItemClick);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemViewVec.length)
         {
            _itemViewVec[_loc1_].removeEventListener("itemclick",__skillItemClick);
            _loc1_++;
         }
      }
      
      private function __skillItemClick(param1:PetItemEvent) : void
      {
         if(_isWatch)
         {
            return;
         }
         var _loc2_:PetSkill = (param1.data as SkillItem).info as PetSkill;
         if(_loc2_ && PetsBagManager.instance().petModel.currentPetInfo)
         {
            SocketManager.Instance.out.sendEquipPetSkill(PetsBagManager.instance().petModel.currentPetInfo.Place,_loc2_.ID,PetsBagManager.instance().getEquipdSkillIndex());
            if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] > 0)
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(117);
               PetsBagManager.instance().petModel.petGuildeOptionOnOff[117] = 0;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeItems();
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
