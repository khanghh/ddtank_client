package treasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import treasure.controller.TreasureManager;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureField extends Sprite implements Disposeable
   {
       
      
      private var X:Number = 236;
      
      private var Y:Number = 281;
      
      private var W:Number = 61;
      
      private var H:Number = 45;
      
      private var _fieldList:Vector.<TreasureCell>;
      
      private var cartoon:MovieClip;
      
      private var _fieldMc:MovieClip;
      
      private var _fieldMcList:Array;
      
      public function TreasureField(param1:Sprite){super();}
      
      private function initListener() : void{}
      
      public function setField(param1:Boolean) : void{}
      
      private function creatField() : void{}
      
      private function __fieldChangeHandler(param1:TreasureEvents) : void{}
      
      public function endGameShow() : void{}
      
      public function playStartCartoon() : void{}
      
      public function digField(param1:int) : void{}
      
      private function onCompleteHandeler(param1:Event) : void{}
      
      private function removeListener() : void{}
      
      public function dispose() : void{}
   }
}
