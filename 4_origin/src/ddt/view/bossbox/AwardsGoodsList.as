package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Sprite;
   
   public class AwardsGoodsList extends Sprite implements Disposeable
   {
       
      
      private var _goodsList:Array;
      
      private var _list:SimpleTileList;
      
      private var panel:ScrollPanel;
      
      private var _cells:Array;
      
      public function AwardsGoodsList()
      {
         super();
         initList();
      }
      
      protected function initList() : void
      {
         _list = new SimpleTileList(2);
         _list.vSpace = 6;
         _list.hSpace = 110;
         panel = ComponentFactory.Instance.creat("TimeBoxScrollpanel");
         addChild(panel);
      }
      
      public function show(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         _goodsList = param1;
         _cells = [];
         _list.beginChanges();
         _loc7_ = 0;
         while(_loc7_ < _goodsList.length)
         {
            _loc3_ = 0;
            if(_goodsList[_loc7_] is InventoryItemInfo)
            {
               _loc6_ = _goodsList[_loc7_];
               _loc6_.IsJudge = true;
            }
            else if(_goodsList[_loc7_] is BoxGoodsTempInfo)
            {
               _loc5_ = _goodsList[_loc7_] as BoxGoodsTempInfo;
               _loc6_ = getTemplateInfo(_loc5_.TemplateId) as InventoryItemInfo;
               _loc6_.IsBinds = _loc5_.IsBind;
               _loc6_.LuckCompose = _loc5_.LuckCompose;
               _loc6_.DefendCompose = _loc5_.DefendCompose;
               _loc6_.AttackCompose = _loc5_.AttackCompose;
               _loc6_.AgilityCompose = _loc5_.AgilityCompose;
               _loc6_.StrengthenLevel = _loc5_.StrengthenLevel;
               _loc6_.ValidDate = _loc5_.ItemValid;
               _loc6_.IsJudge = true;
               _loc6_.Count = _loc5_.ItemCount;
            }
            else if(_goodsList[_loc7_] is ItemTemplateInfo)
            {
               _loc2_ = _goodsList[_loc7_] as ItemTemplateInfo;
            }
            else
            {
               _loc2_ = _goodsList[_loc7_].info;
               _loc3_ = _goodsList[_loc7_].count;
            }
            if(_loc6_ != null)
            {
               _loc2_ = _loc6_;
            }
            _loc4_ = ComponentFactory.Instance.creatCustomObject("bossbox.BoxAwardsCell");
            _loc4_.info = _loc2_;
            if(_loc2_.hasOwnProperty("Count"))
            {
               _loc4_.count = _loc2_["Count"];
            }
            else if(_loc3_ > 0)
            {
               _loc4_.count = _loc3_;
            }
            else
            {
               _loc4_.count = 1;
            }
            _list.addChild(_loc4_);
            _cells.push(_loc4_);
            _loc7_++;
         }
         _list.commitChanges();
         panel.beginChanges();
         panel.setView(_list);
         panel.hScrollProxy = 2;
         panel.vScrollProxy = _goodsList.length > 6?0:2;
         panel.commitChanges();
      }
      
      public function showForVipAward(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _goodsList = param1;
         _cells = [];
         _list.dispose();
         _list = new SimpleTileList(3);
         _list.vSpace = 6;
         _list.hSpace = 110;
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _goodsList.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("bossbox.BoxAwardsCell");
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
            _loc2_.info = ItemManager.Instance.getTemplateById(BoxGoodsTempInfo(_goodsList[_loc3_]).TemplateId);
            if(_goodsList[_loc3_] && _loc2_.info)
            {
               _loc2_.count = 1;
               _loc2_.itemName = _loc2_.info.Name + "X" + String(BoxGoodsTempInfo(_goodsList[_loc3_]).ItemCount);
               _list.addChild(_loc2_);
               _cells.push(_loc2_);
            }
            _loc3_++;
         }
         _list.commitChanges();
         panel.beginChanges();
         panel.width = 500;
         panel.height = 178;
         panel.setView(_list);
         panel.hScrollProxy = 2;
         panel.vScrollProxy = 2;
         panel.commitChanges();
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.dispose();
         }
         _cells.splice(0,_cells.length);
         _cells = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(panel)
         {
            ObjectUtils.disposeObject(panel);
         }
         panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
