package boguAdventure.cell
{
   import bagAndInfo.cell.BaseCell;
   import boguAdventure.model.BoguAdventureCellInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class BoguAdventureCell extends Sprite implements Disposeable
   {
      
      public static const PLAY_COMPLETE:String = "playcomplete";
       
      
      private var _cellBg:Bitmap;
      
      private var _info:BoguAdventureCellInfo;
      
      private var _goodsBg:BaseCell;
      
      private var _shine:MovieClip;
      
      private var _lightFilter:ColorMatrixFilter;
      
      private var _isMove:Boolean;
      
      public function BoguAdventureCell(){super();}
      
      public function set info(param1:BoguAdventureCellInfo) : void{}
      
      public function get info() : BoguAdventureCellInfo{return null;}
      
      public function changeCellBg() : void{}
      
      private function __onMove(param1:MouseEvent) : void{}
      
      private function __onOut(param1:MouseEvent) : void{}
      
      public function playShineAction() : void{}
      
      private function set lightFilter(param1:Boolean) : void{}
      
      private function __onPlayComplete(param1:Event) : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      public function close() : void{}
      
      public function open() : void{}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
