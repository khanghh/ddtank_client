package bombKing.components
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BKingPlayerTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _viewInfo:IconButton;
      
      private var userId:int;
      
      private var areaId:int;
      
      public function BKingPlayerTip(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __onViewInfo(param1:MouseEvent) : void{}
      
      public function setUserId(param1:int, param2:int) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
