package littleGame.view
{
   import character.ICharacter;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.ddt_internal;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import littleGame.LittleGameManager;
   import littleGame.character.LittleGameCharacter;
   import littleGame.events.LittleLivingEvent;
   import littleGame.model.LittleLiving;
   
   use namespace ddt_internal;
   
   public class GameLittleLiving extends Sprite implements Disposeable
   {
       
      
      public var isMove:Boolean = false;
      
      protected var _living:LittleLiving;
      
      protected var _body:DisplayObject;
      
      protected var _hitArea:Sprite;
      
      protected var _realRender:Boolean;
      
      public function GameLittleLiving(param1:LittleLiving){super();}
      
      public function get realRender() : Boolean{return false;}
      
      public function set realRender(param1:Boolean) : void{}
      
      public function setInhaled(param1:Boolean) : void{}
      
      public function get lock() : Boolean{return false;}
      
      public function set lock(param1:Boolean) : void{}
      
      public function get inGame() : Boolean{return false;}
      
      override public function toString() : String{return null;}
      
      protected function configUI() : void{}
      
      protected function createBody() : void{}
      
      protected function addEvent() : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      protected function onOver(param1:MouseEvent) : void{}
      
      protected function onOut(param1:MouseEvent) : void{}
      
      protected function __doAction(param1:LittleLivingEvent) : void{}
      
      protected function __directionChanged(param1:LittleLivingEvent) : void{}
      
      protected function centerBody() : void{}
      
      private function __posChanged(param1:LittleLivingEvent) : void{}
      
      public function get living() : LittleLiving{return null;}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
