package ddt.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   
   public class ItemCellEffectMngr
   {
      
      public static const EFFECT_RUN_AROUND:int = 0;
      
      public static const SIZE_BAG_CELL:int = 100;
      
      public static const SIZE_SHOP_ITEM_CELL:int = 101;
      
      private static var effectState:IState;
       
      
      public function ItemCellEffectMngr()
      {
         super();
      }
      
      public static function getEffect(cellPos:Object, efftctType:int = 0, sizeType:int = 100) : MovieClip
      {
         var mc:* = null;
         if(!int(efftctType))
         {
            mc = ComponentFactory.Instance.creat("asset.core.icon.coolShining");
            effectState = new StateRunAround();
            mc.mouseChildren = false;
            mc.mouseEnabled = false;
            effectState.setSize(mc,cellPos,sizeType);
            effectState = null;
            return mc;
         }
         throw "没有这样的特效类型.";
      }
   }
}

import flash.display.MovieClip;

interface IState
{
    
   
   function setSize(param1:MovieClip, param2:Object, param3:int) : void;
}

import flash.display.MovieClip;

class StateRunAround implements IState
{
    
   
   function StateRunAround()
   {
      super();
   }
   
   public function setSize(tag:MovieClip, cellPos:Object, type:int) : void
   {
      switch(int(type) - 100)
      {
         case 0:
            var _loc4_:* = 1;
            tag.scaleY = _loc4_;
            tag.scaleX = _loc4_;
            tag.x = cellPos.x - 1;
            tag.y = cellPos.y - 1;
            break;
         case 1:
            _loc4_ = 1.24444444444444;
            tag.scaleY = _loc4_;
            tag.scaleX = _loc4_;
            tag.x = cellPos.x + 9;
            tag.y = cellPos.y + 10;
      }
   }
}
