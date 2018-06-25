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
      
      public function show(goodsList:Array) : void
      {
         var i:int = 0;
         var _itemTempleteInfo:* = null;
         var _count:int = 0;
         var info:* = null;
         var boxGoodsInfo:* = null;
         var cell:* = null;
         _goodsList = goodsList;
         _cells = [];
         _list.beginChanges();
         for(i = 0; i < _goodsList.length; )
         {
            _count = 0;
            if(_goodsList[i] is InventoryItemInfo)
            {
               info = _goodsList[i];
               info.IsJudge = true;
            }
            else if(_goodsList[i] is BoxGoodsTempInfo)
            {
               boxGoodsInfo = _goodsList[i] as BoxGoodsTempInfo;
               info = getTemplateInfo(boxGoodsInfo.TemplateId) as InventoryItemInfo;
               info.IsBinds = boxGoodsInfo.IsBind;
               info.LuckCompose = boxGoodsInfo.LuckCompose;
               info.DefendCompose = boxGoodsInfo.DefendCompose;
               info.AttackCompose = boxGoodsInfo.AttackCompose;
               info.AgilityCompose = boxGoodsInfo.AgilityCompose;
               info.StrengthenLevel = boxGoodsInfo.StrengthenLevel;
               info.ValidDate = boxGoodsInfo.ItemValid;
               info.IsJudge = true;
               info.Count = boxGoodsInfo.ItemCount;
            }
            else if(_goodsList[i] is ItemTemplateInfo)
            {
               _itemTempleteInfo = _goodsList[i] as ItemTemplateInfo;
            }
            else
            {
               _itemTempleteInfo = _goodsList[i].info;
               _count = _goodsList[i].count;
            }
            if(info != null)
            {
               _itemTempleteInfo = info;
            }
            cell = ComponentFactory.Instance.creatCustomObject("bossbox.BoxAwardsCell");
            cell.info = _itemTempleteInfo;
            if(_itemTempleteInfo.hasOwnProperty("Count"))
            {
               cell.count = _itemTempleteInfo["Count"];
            }
            else if(_count > 0)
            {
               cell.count = _count;
            }
            else
            {
               cell.count = 1;
            }
            _list.addChild(cell);
            _cells.push(cell);
            i++;
         }
         _list.commitChanges();
         panel.beginChanges();
         panel.setView(_list);
         panel.hScrollProxy = 2;
         panel.vScrollProxy = _goodsList.length > 6?0:2;
         panel.commitChanges();
      }
      
      public function showForVipAward(infoList:Array) : void
      {
         var i:int = 0;
         var cell:* = null;
         _goodsList = infoList;
         _cells = [];
         _list.dispose();
         _list = new SimpleTileList(3);
         _list.vSpace = 6;
         _list.hSpace = 110;
         _list.beginChanges();
         for(i = 0; i < _goodsList.length; )
         {
            cell = ComponentFactory.Instance.creatCustomObject("bossbox.BoxAwardsCell");
            cell.mouseChildren = false;
            cell.mouseEnabled = false;
            cell.info = ItemManager.Instance.getTemplateById(BoxGoodsTempInfo(_goodsList[i]).TemplateId);
            if(_goodsList[i] && cell.info)
            {
               cell.count = 1;
               cell.itemName = cell.info.Name + "X" + String(BoxGoodsTempInfo(_goodsList[i]).ItemCount);
               _list.addChild(cell);
               _cells.push(cell);
            }
            i++;
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
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.dispose();
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
