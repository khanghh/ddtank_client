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
      
      public function BaseGamePropBarView(param1:LocalPlayer, param2:Number, param3:Number, param4:Boolean, param5:Boolean, param6:Boolean, param7:String = ""){super();}
      
      public function get itemContainer() : ItemContainer{return null;}
      
      public function get self() : LocalPlayer{return null;}
      
      public function setClickEnabled(param1:Boolean, param2:Boolean) : void{}
      
      public function dispose() : void{}
      
      private function __changeAttack(param1:LivingEvent) : void{}
      
      private function __die(param1:LivingEvent) : void{}
      
      protected function __energyChange(param1:LivingEvent) : void{}
      
      protected function __move(param1:ItemEvent) : void{}
      
      public function setVisible(param1:int, param2:Boolean) : void{}
      
      protected function __over(param1:ItemEvent) : void{}
      
      protected function __out(param1:ItemEvent) : void{}
      
      protected function __click(param1:ItemEvent) : void{}
      
      public function setLayerMode(param1:int) : void{}
   }
}
