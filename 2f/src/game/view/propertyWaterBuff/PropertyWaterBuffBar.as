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
      
      public function PropertyWaterBuffBar(){super();}
      
      public static function getPropertyWaterBuffList(param1:DictionaryData) : DictionaryData{return null;}
      
      private function init() : void{}
      
      private function createIconList() : void{}
      
      private function disposeIconList() : void{}
      
      public function dispose() : void{}
   }
}
