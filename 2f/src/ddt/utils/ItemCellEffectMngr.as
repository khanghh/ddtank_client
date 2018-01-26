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
       
      
      public function ItemCellEffectMngr(){super();}
      
      public static function getEffect(param1:Object, param2:int = 0, param3:int = 100) : MovieClip{return null;}
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
    
   
   function StateRunAround(){super();}
   
   public function setSize(param1:MovieClip, param2:Object, param3:int) : void{}
}
