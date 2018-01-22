package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import flash.text.TextFormat;
   
   public class RoomPlayerItemIip extends BaseTip implements Disposeable, ITip
   {
      
      public static const MAX_HEIGHT:int = 70;
      
      public static const MIN_HEIGHT:int = 22;
       
      
      private var _textFrameArray:Vector.<FilterFrameText>;
      
      private var _contentLabel:TextFormat;
      
      private var _bg:ScaleBitmapImage;
      
      public function RoomPlayerItemIip(){super();}
      
      protected function initView() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function returnFilterFrameText(param1:String) : FilterFrameText{return null;}
      
      private function isVisibleFunction() : void{}
      
      private function reset() : void{}
      
      private function update() : void{}
      
      private function updateBgSize() : void{}
      
      private function getMaxWidth() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
