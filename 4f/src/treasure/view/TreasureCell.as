package treasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import treasure.controller.TreasureManager;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureCell extends Sprite implements Disposeable
   {
       
      
      public var cell:TreasureFieldCell;
      
      private var _field:MovieClip;
      
      private var _tbxCount:FilterFrameText;
      
      public var cartoon:MovieClip;
      
      public var _fieldPos:int;
      
      private var cartoon_dig:MovieClip;
      
      private var cursor:Bitmap;
      
      public function TreasureCell(param1:int, param2:Boolean = true){super();}
      
      public function creatCartoon(param1:String = "show") : void{}
      
      private function __allOverHandler(param1:Event) : void{}
      
      public function removeCell() : void{}
      
      public function digBackHandler() : void{}
      
      private function cartoon_digHandler(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function addEvent() : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function mouseMoveHandler(param1:MouseEvent) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
