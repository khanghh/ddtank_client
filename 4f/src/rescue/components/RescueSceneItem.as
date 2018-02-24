package rescue.components
{
   import catchInsect.data.RescueSceneInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RescueSceneItem extends Sprite implements Disposeable
   {
       
      
      private var _light:Bitmap;
      
      private var _bg:ScaleFrameImage;
      
      private var _sceneNum:Bitmap;
      
      private var _star:Bitmap;
      
      private var _hBox:HBox;
      
      private var _sceneId:int;
      
      private var _info:RescueSceneInfo;
      
      public function RescueSceneItem(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      public function setData(param1:Boolean, param2:int = 0, param3:RescueSceneInfo = null) : void{}
      
      public function setSelected(param1:Boolean) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
      
      public function get info() : RescueSceneInfo{return null;}
      
      public function get sceneId() : int{return 0;}
   }
}
