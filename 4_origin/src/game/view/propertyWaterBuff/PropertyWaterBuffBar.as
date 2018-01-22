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
      
      public static function getPropertyWaterBuffList(param1:DictionaryData) : DictionaryData
      {
         var _loc3_:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(EquipType.isPropertyWater(_loc2_.buffItemInfo))
            {
               _loc3_.add(_loc2_.Type,_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function init() : void
      {
         _container = UICreatShortcut.creatAndAdd("game.view.propertyWaterBuffBer",this);
         _buffList = getPropertyWaterBuffList(PlayerManager.Instance.Self.buffInfo);
         createIconList();
      }
      
      private function createIconList() : void
      {
         var _loc1_:* = null;
         _iconList = new Vector.<PropertyWaterBuffIcon>();
         var _loc4_:int = 0;
         var _loc3_:* = _buffList;
         for each(var _loc2_ in _buffList)
         {
            _loc1_ = ComponentFactory.Instance.creat("game.view.propertyWaterBuff.propertyWaterBuffIcon",[_loc2_]);
            _iconList.push(_loc1_);
            _container.addChild(_loc1_);
         }
      }
      
      private function disposeIconList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _iconList;
         for each(var _loc1_ in _iconList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
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
