package game.view.propertyWaterBuff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.EquipType;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class PropertyWaterBuffBar extends Sprite implements Disposeable
   {
       
      
      private var _container:HBox;
      
      private var _buffList:DictionaryData;
      
      private var _iconList:Vector.<PropertyWaterBuffIcon>;
      
      public function PropertyWaterBuffBar()
      {
         super();
         init();
      }
      
      public static function getPropertyWaterBuffList(buffInfos:DictionaryData) : DictionaryData
      {
         var tempList:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = buffInfos;
         for each(var i in buffInfos)
         {
            if(EquipType.isPropertyWater(i.buffItemInfo))
            {
               tempList.add(i.Type,i);
            }
         }
         return tempList;
      }
      
      private function init() : void
      {
         _container = UICreatShortcut.creatAndAdd("game.view.propertyWaterBuffBer",this);
         _buffList = getPropertyWaterBuffList(PlayerManager.Instance.Self.buffInfo);
         createIconList();
      }
      
      private function createIconList() : void
      {
         var icon:* = null;
         _iconList = new Vector.<PropertyWaterBuffIcon>();
         var _loc4_:int = 0;
         var _loc3_:* = _buffList;
         for each(var i in _buffList)
         {
            icon = ComponentFactory.Instance.creat("game.view.propertyWaterBuff.propertyWaterBuffIcon",[i]);
            _iconList.push(icon);
            _container.addChild(icon);
         }
      }
      
      private function disposeIconList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _iconList;
         for each(var icon in _iconList)
         {
            ObjectUtils.disposeObject(icon);
            icon = null;
         }
      }
      
      public function dispose() : void
      {
         disposeIconList();
         ObjectUtils.disposeObject(_container);
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
