package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HorseRacePlayerInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _itemList:Array;
      
      public var selectItemId:int = 0;
      
      public function HorseRacePlayerInfoView(){super();}
      
      private function initView() : void{}
      
      public function addPlayerItem(param1:HorseRacePlayerItemView) : void{}
      
      public function flushBuffList() : void{}
      
      private function _itemClick(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
