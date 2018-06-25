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
      
      public function BaseGamePropBarView(self:LocalPlayer, count:Number, column:Number, bgvisible:Boolean, ordinal:Boolean, clickable:Boolean, EffectType:String = "")
      {
         super();
         _self = self;
         _itemContainer = new ItemContainer(count,column,bgvisible,ordinal,clickable,EffectType);
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
      
      public function setClickEnabled(clickAble:Boolean, isGray:Boolean) : void
      {
         _itemContainer.setState(clickAble,isGray);
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
      
      private function __changeAttack(event:LivingEvent) : void
      {
         if(_self.isAttacking && _self.isLiving && !_self.LockState)
         {
            setClickEnabled(false,false);
         }
      }
      
      private function __die(event:LivingEvent) : void
      {
         setClickEnabled(false,false);
      }
      
      protected function __energyChange(event:LivingEvent) : void
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
      
      protected function __move(event:ItemEvent) : void
      {
      }
      
      public function setVisible(index:int, v:Boolean) : void
      {
         _itemContainer.setVisible(index,v);
      }
      
      protected function __over(event:ItemEvent) : void
      {
      }
      
      protected function __out(event:ItemEvent) : void
      {
      }
      
      protected function __click(event:ItemEvent) : void
      {
      }
      
      public function setLayerMode(mode:int) : void
      {
      }
   }
}
