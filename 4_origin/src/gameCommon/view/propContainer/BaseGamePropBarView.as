package gameCommon.view.propContainer
{
   import ddt.events.ItemEvent;
   import ddt.events.LivingEvent;
   import flash.display.Sprite;
   import gameCommon.model.LocalPlayer;
   
   public class BaseGamePropBarView extends Sprite
   {
       
      
      protected var _notExistTip:Sprite;
      
      protected var _itemContainer:ItemContainer;
      
      private var _self:LocalPlayer;
      
      public function BaseGamePropBarView(param1:LocalPlayer, param2:Number, param3:Number, param4:Boolean, param5:Boolean, param6:Boolean, param7:String = "")
      {
         super();
         _self = param1;
         _itemContainer = new ItemContainer(param2,param3,param4,param5,param6,param7);
         addChild(_itemContainer);
         _self.addEventListener("energyChanged",__energyChange);
         _self.addEventListener("die",__die);
         _self.addEventListener("attackingChanged",__changeAttack);
      }
      
      public function get itemContainer() : ItemContainer
      {
         return _itemContainer;
      }
      
      public function get self() : LocalPlayer
      {
         return _self;
      }
      
      public function setClickEnabled(param1:Boolean, param2:Boolean) : void
      {
         _itemContainer.setState(param1,param2);
      }
      
      public function dispose() : void
      {
         _self.removeEventListener("die",__die);
         _self.removeEventListener("energyChanged",__energyChange);
         _self.removeEventListener("attackingChanged",__changeAttack);
         removeChild(_itemContainer);
         _itemContainer.removeEventListener("itemClick",__click);
         _itemContainer.removeEventListener("itemMove",__move);
         _itemContainer.removeEventListener("itemOut",__out);
         _itemContainer.removeEventListener("itemOver",__over);
         _itemContainer.dispose();
         _itemContainer = null;
         if(parent)
         {
            parent.removeChild(this);
            _itemContainer = null;
         }
      }
      
      private function __changeAttack(param1:LivingEvent) : void
      {
         if(_self.isAttacking && _self.isLiving && !_self.LockState)
         {
            setClickEnabled(false,false);
         }
      }
      
      private function __die(param1:LivingEvent) : void
      {
         setClickEnabled(false,false);
      }
      
      protected function __energyChange(param1:LivingEvent) : void
      {
         if(_self.isLiving && !_self.LockState)
         {
            _itemContainer.setClickByEnergy(_self.energy);
         }
         else if(_self.isLiving && _self.LockState)
         {
            setClickEnabled(false,true);
         }
      }
      
      protected function __move(param1:ItemEvent) : void
      {
      }
      
      public function setVisible(param1:int, param2:Boolean) : void
      {
         _itemContainer.setVisible(param1,param2);
      }
      
      protected function __over(param1:ItemEvent) : void
      {
      }
      
      protected function __out(param1:ItemEvent) : void
      {
      }
      
      protected function __click(param1:ItemEvent) : void
      {
      }
      
      public function setLayerMode(param1:int) : void
      {
      }
   }
}
